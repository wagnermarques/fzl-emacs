;;; fzl-buku-sync.el --- Keep Buku's SQLite DB in sync with a versionable SQL text file -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Buku only stores bookmarks in SQLite, which git cannot diff or merge.
;; This module keeps a plain-text twin of the database, `bookmarks.sql',
;; next to it: a header plus one `INSERT OR REPLACE' line per bookmark
;; (without the `id' column, so two machines never clash on ids).
;;
;; The .sql file is what goes into git; the .db is a local cache.
;; Synchronization is a 3-way comparison between:
;;   D = dump of the .db, S = the .sql file, B = last synced state
;;   (`.bookmarks.sync-base.sql', local only).
;;   D = S         -> nothing to do
;;   S = B         -> only the DB changed   -> rewrite .sql
;;   D = B         -> only the .sql changed -> rebuild .db
;;   otherwise     -> union merge of D and S over B, rebuild both
;;
;; It runs when the module is loaded (Emacs startup) and whenever the
;; .db or .sql changes on disk (buku CLI, ebuku, browser extension,
;; git pull...), via `file-notify', debounced.
;;
;; Requires the `sqlite3' command line tool and `git' (for merge-file).

;;; Code:

(require 'subr-x)
(require 'filenotify)
(require 'seq)

(defgroup fzl-buku-sync nil
  "Synchronize the Buku SQLite database with a text SQL file."
  :group 'tools)

(defcustom fzl-buku-sync-db-path nil
  "Buku database to synchronize.  When nil, use `desktoping-buku-db-path'."
  :type '(choice (const nil) file))

(defcustom fzl-buku-sync-delay 2
  "Seconds to wait after a file change before synchronizing."
  :type 'number)

(defconst fzl-buku-sync--columns "URL,metadata,tags,desc,flags"
  "Buku columns serialized to the SQL file (everything except `id').")

(defconst fzl-buku-sync--header
  (concat
   "-- fzl-emacs Buku bookmarks. Generated automatically from bookmarks.db by\n"
   "-- fzl-buku-sync.el: one bookmark per line. Prefer editing through buku/Emacs.\n"
   "CREATE TABLE IF NOT EXISTS bookmarks (id integer PRIMARY KEY, URL text NOT NULL UNIQUE, "
   "metadata text default '', tags text default ',', desc text default '', flags integer default 0);\n")
  "Fixed header of the SQL file.")

;;; Paths

(defun fzl-buku-sync--db ()
  "Absolute path of the Buku database."
  (expand-file-name (or fzl-buku-sync-db-path
                        (bound-and-true-p desktoping-buku-db-path)
                        (error "fzl-buku-sync: no database path configured"))))

(defun fzl-buku-sync--sql ()
  "Absolute path of the SQL text file."
  (concat (file-name-sans-extension (fzl-buku-sync--db)) ".sql"))

(defun fzl-buku-sync--base ()
  "Absolute path of the local last-synced state file."
  (expand-file-name (concat "." (file-name-base (fzl-buku-sync--db)) ".sync-base.sql")
                    (file-name-directory (fzl-buku-sync--db))))

;;; Helpers

(defun fzl-buku-sync--read (file)
  "Return FILE contents as a string, or nil if it does not exist."
  (when (file-exists-p file)
    (with-temp-buffer
      (let ((coding-system-for-read 'utf-8))
        (insert-file-contents file))
      (buffer-string))))

(defun fzl-buku-sync--write (file text)
  "Write TEXT to FILE (UTF-8), only if its contents differ."
  (unless (equal (fzl-buku-sync--read file) text)
    (let ((coding-system-for-write 'utf-8-unix)
          (write-region-inhibit-fsync t))
      (write-region text nil file nil 'silent))))

(defun fzl-buku-sync--count (text)
  "Number of bookmark lines in SQL TEXT."
  (with-temp-buffer
    (insert (or text ""))
    (count-matches "^INSERT " (point-min) (point-max))))

(defun fzl-buku-sync--quote (col)
  "SQL expression quoting COL as a single-line SQL literal."
  ;; quote() keeps newlines literally; split them into char(N) so that
  ;; every bookmark stays on exactly one line.
  (format "replace(replace(quote(%s),char(10),'''||char(10)||'''),char(13),'''||char(13)||''')" col))

(defun fzl-buku-sync--dump (db)
  "Serialize DB to SQL text.  Return nil (never partial text) on failure."
  (let* ((cols (split-string fzl-buku-sync--columns ","))
         (query (format "SELECT 'INSERT OR REPLACE INTO bookmarks(%s) VALUES('||%s||');' FROM bookmarks ORDER BY id;"
                        fzl-buku-sync--columns
                        (mapconcat #'fzl-buku-sync--quote cols "||','||"))))
    (with-temp-buffer
      (let* ((coding-system-for-read 'utf-8)
             (status (call-process "sqlite3" nil t nil
                                   "-batch" "-bail" "-noheader" "-readonly"
                                   "-cmd" ".timeout 5000" db query)))
        (if (and (eql status 0)
                 (not (string-match-p "^\\(Error\\|Parse error\\|Runtime error\\)" (buffer-string))))
            (concat fzl-buku-sync--header (buffer-string))
          (message "fzl-buku-sync: failed to read %s: %s" db (string-trim (buffer-string)))
          nil)))))

(defun fzl-buku-sync--build (db text)
  "Rebuild DB from SQL TEXT atomically.  Return non-nil on success."
  (let ((new (concat db ".new")))
    (when (file-exists-p new) (delete-file new))
    (with-temp-buffer
      (insert ".bail on\nBEGIN;\n" text "\nCOMMIT;\n")
      (let* ((coding-system-for-write 'utf-8-unix)
             (coding-system-for-read 'utf-8)
             (status (call-process-region (point-min) (point-max) "sqlite3"
                                          t t nil "-batch" new)))
        (if (and (eql status 0) (file-exists-p new))
            (progn (rename-file new db t) t)
          (message "fzl-buku-sync: failed to rebuild %s: %s" db (string-trim (buffer-string)))
          (when (file-exists-p new) (delete-file new))
          nil)))))

(defun fzl-buku-sync--union (ours base theirs)
  "Line-based union merge of OURS and THEIRS over BASE (strings)."
  (let ((f-ours (make-temp-file "fzl-buku-ours"))
        (f-base (make-temp-file "fzl-buku-base"))
        (f-theirs (make-temp-file "fzl-buku-theirs")))
    (unwind-protect
        (progn
          (let ((coding-system-for-write 'utf-8-unix))
            (write-region ours nil f-ours nil 'silent)
            (write-region (or base "") nil f-base nil 'silent)
            (write-region theirs nil f-theirs nil 'silent))
          (with-temp-buffer
            (let ((coding-system-for-read 'utf-8))
              (call-process "git" nil (list t nil) nil
                            "merge-file" "-p" "--union" f-ours f-base f-theirs))
            (buffer-string)))
      (mapc #'delete-file (list f-ours f-base f-theirs)))))

;;; Synchronization

(defun fzl-buku-sync--rebuild-and-normalize (db sql base text)
  "Build DB from TEXT, then rewrite SQL and BASE from the resulting DB.
Return the normalized dump, or nil on failure."
  (when (fzl-buku-sync--build db text)
    (let ((norm (fzl-buku-sync--dump db)))
      (when norm
        (fzl-buku-sync--write sql norm)
        (fzl-buku-sync--write base norm)
        norm))))

(defun fzl-buku-sync-run ()
  "Synchronize the Buku database and its SQL file once.
Return a symbol describing what happened."
  (let* ((db (fzl-buku-sync--db))
         (sql (fzl-buku-sync--sql))
         (base (fzl-buku-sync--base))
         (db-p (file-exists-p db))
         (S (fzl-buku-sync--read sql)))
    (cond
     ((not (executable-find "sqlite3"))
      (message "fzl-buku-sync: `sqlite3' not found; bookmarks.sql is not being synchronized")
      'no-sqlite3)
     ((and (not db-p) (not S)) 'nothing)
     ((not db-p)
      (if (fzl-buku-sync--rebuild-and-normalize db sql base S)
          (progn (message "Buku: %s criado a partir de %s"
                          (file-name-nondirectory db) (file-name-nondirectory sql))
                 'db-created)
        'error))
     (t
      (let ((D (fzl-buku-sync--dump db))
            (B (fzl-buku-sync--read base)))
        (cond
         ((null D) 'error)
         ((equal D S) (fzl-buku-sync--write base D) 'in-sync)
         ((or (null S) (and B (equal S B)))
          (fzl-buku-sync--write sql D)
          (fzl-buku-sync--write base D)
          (message "Buku: %s atualizado (%d favoritos)"
                   (file-name-nondirectory sql) (fzl-buku-sync--count D))
          'sql-updated)
         ((and B (equal D B))
          (if (fzl-buku-sync--rebuild-and-normalize db sql base S)
              (progn (message "Buku: %s recarregado de %s"
                              (file-name-nondirectory db) (file-name-nondirectory sql))
                     'db-updated)
            'error))
         (t
          ;; Both sides changed (or first run without base): keep everything.
          (if (fzl-buku-sync--rebuild-and-normalize
               db sql base (fzl-buku-sync--union D B S))
              (progn (message "Buku: alterações do .db e do .sql mescladas")
                     'merged)
            'error))))))))

;;;###autoload
(defun fzl-buku-sync-now ()
  "Synchronize the Buku database with bookmarks.sql now and report."
  (interactive)
  (message "Buku sync: %s" (fzl-buku-sync-run)))

;;;###autoload
(defun fzl-buku-sync-git-commit-and-push (&optional user-message)
  "Synchronize bookmarks.db to bookmarks.sql, then git commit and push bookmarks.sql.
Allows saving and sharing bookmarks without closing Emacs."
  (interactive)
  (message "Buku: sincronizando bookmarks.db <-> bookmarks.sql...")
  (let ((sync-result (fzl-buku-sync-run))
        (sql-file (fzl-buku-sync--sql)))
    (unless (file-exists-p sql-file)
      (user-error "fzl-buku-sync: arquivo %s não encontrado" sql-file))
    (let* ((repo-dir (locate-dominating-file sql-file ".git")))
      (unless repo-dir
        (user-error "fzl-buku-sync: %s não pertence a um repositório Git" sql-file))
      (let* ((default-directory (expand-file-name repo-dir))
             (rel-sql (file-relative-name sql-file default-directory))
             (msg (or user-message
                      (format "chore(bookmarks): update bookmarks.sql (%s)"
                              (format-time-string "%Y-%m-%d %H:%M:%S"))))
             (cmd (format "git add %s && (git diff --cached --quiet -- %s || git commit -m %s -- %s) && git push origin HEAD"
                          (shell-quote-argument rel-sql)
                          (shell-quote-argument rel-sql)
                          (shell-quote-argument msg)
                          (shell-quote-argument rel-sql))))
        (message "Buku: executando Git commit & push para %s..." rel-sql)
        (let ((output (shell-command-to-string cmd)))
          (message "Buku: bookmarks.sql sincronizado, commitado e enviado com sucesso! (%s)" sync-result)
          (when (called-interactively-p 'interactive)
            (message "Git output: %s" (string-trim output))))))))

;;; File watching

(defvar fzl-buku-sync--watch nil "Active `file-notify' descriptor.")
(defvar fzl-buku-sync--timer nil "Pending debounce timer.")
(defvar fzl-buku-sync--running nil "Non-nil while a synchronization is running.")

(defun fzl-buku-sync--run-safely ()
  "Run `fzl-buku-sync-run', catching errors and avoiding re-entrance."
  (setq fzl-buku-sync--timer nil)
  (unless fzl-buku-sync--running
    (let ((fzl-buku-sync--running t))
      (condition-case err
          (fzl-buku-sync-run)
        (error (message "fzl-buku-sync: %s" (error-message-string err)))))))

(defun fzl-buku-sync--on-change (event)
  "Schedule a synchronization when EVENT concerns the .db or .sql file."
  (let ((names (list (file-name-nondirectory (fzl-buku-sync--db))
                     (file-name-nondirectory (fzl-buku-sync--sql))))
        (files (seq-filter #'stringp (list (nth 2 event) (nth 3 event)))))
    (when (seq-some (lambda (f) (member (file-name-nondirectory f) names)) files)
      (when (timerp fzl-buku-sync--timer) (cancel-timer fzl-buku-sync--timer))
      (setq fzl-buku-sync--timer
            (run-with-timer fzl-buku-sync-delay nil #'fzl-buku-sync--run-safely)))))

;;;###autoload
(define-minor-mode fzl-buku-sync-mode
  "Keep the Buku database and its versionable bookmarks.sql in sync.
Synchronizes once when enabled and then on every change to either file."
  :global t
  :group 'fzl-buku-sync
  (when fzl-buku-sync--watch
    (file-notify-rm-watch fzl-buku-sync--watch)
    (setq fzl-buku-sync--watch nil))
  (when fzl-buku-sync-mode
    (let ((dir (file-name-directory (fzl-buku-sync--db))))
      (fzl-buku-sync--run-safely)
      (if (file-directory-p dir)
          (condition-case err
              (setq fzl-buku-sync--watch
                    (file-notify-add-watch dir '(change) #'fzl-buku-sync--on-change))
            (error (message "fzl-buku-sync: cannot watch %s: %s"
                            dir (error-message-string err))))
        (message "fzl-buku-sync: directory %s does not exist" dir)))))

(provide 'fzl-buku-sync)
;;; fzl-buku-sync.el ends here
