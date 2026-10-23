;;; pkgconfig-antigravity.el --- Portable Antigravity Remote Control for Emacs (Treemacs & Dired) -*- lexical-binding: t; -*-

;;; Commentary:
;; Cross-platform (Linux & Windows) integration to start, stop, and monitor
;; Antigravity (`agy`) remote sessions directly from Treemacs, Dired, or any buffer.
;;
;; Features:
;; - 100% pure Emacs Lisp (portable across GNU/Linux, Windows, and macOS).
;; - Works seamlessly in both Treemacs (`treemacs-mode`) and Dired (`dired-mode`):
;;   * In Treemacs: uses the folder at point (or parent directory if on a file).
;;   * In Dired: uses `(dired-current-directory)` (the working directory of the
;;     Dired buffer, including inserted subdirs), or the subdirectory under point
;;     when `fzl/agy-dired-prefer-subdir-at-point` is non-nil.
;;   * In any other buffer: falls back to `default-directory`.
;; - Automatically names the remote session after the target folder name.
;; - Updates `~/.gemini/config/config.json` (`cliRemoteControlHostname`) and
;;   registers the folder in `~/.gemini/antigravity-cli/settings.json`
;;   (`trustedWorkspaces`) using built-in Emacs JSON support.
;; - Automatically injects `OPENSSL_ia32cap=~0x4000000000000000` on Linux
;;   to prevent BoringSSL `CRNGT failed` crashes.
;;
;; Keybindings (global, Treemacs, and Dired):
;;   C-c a s   — Start background remote session in folder (Treemacs / Dired)
;;   C-c a S   — Start background remote session strictly in Dired working directory
;;   C-c a i   — Start interactive terminal remote session (`agy --remote-control`)
;;   C-c a k   — Stop remote session (for folder at point or selected from active list)
;;   C-c a K   — Stop ALL active remote sessions and daemon
;;   C-c a t   — Toggle remote session for folder at point
;;   C-c a l   — List/status of active remote sessions
;;   C-c a b   — Show output/terminal buffer for a remote session
;;   C-c a w   — Open https://antigravity.google.com in browser

;;; Code:

(require 'json)
(require 'seq)
(require 'subr-x)
(require 'easymenu)

(defgroup fzl-antigravity nil
  "Antigravity (`agy`) Remote Control integration for Emacs, Treemacs, and Dired."
  :group 'tools
  :prefix "fzl/agy-")

(defcustom fzl/agy-remote-url "https://antigravity.google.com"
  "Web URL for Antigravity Remote Control dashboard."
  :type 'string
  :group 'fzl-antigravity)

(defcustom fzl/agy-dired-prefer-subdir-at-point nil
  "How `dired-mode` resolves the target directory for `fzl/agy-remote-start`.
- When nil (default): always uses `(dired-current-directory)` (the working
  directory currently open in Dired).
- When non-nil: if the cursor is on a subdirectory line in Dired, uses that
  subdirectory; otherwise falls back to `(dired-current-directory)`."
  :type 'boolean
  :group 'fzl-antigravity)

(defvar fzl/agy-sessions (make-hash-table :test #'equal)
  "Hash table mapping normalized directory path -> plist (:name :dir :process :buffer :mode).")

;;; ----------------------------------------------------------------------------
;;; 1. Cross-platform Binary & Config Path Discovery (Linux + Windows)
;;; ----------------------------------------------------------------------------

(defun fzl/agy-executable ()
  "Locate the `agy` executable across Linux, Windows, and macOS."
  (or (executable-find "agy")
      (executable-find "agy.exe")
      (let* ((is-win (memq system-type '(windows-nt ms-dos cygwin)))
             (candidates
              (if is-win
                  (list (expand-file-name "~/.local/bin/agy.exe")
                        (expand-file-name "~/AppData/Local/Programs/Antigravity/agy.exe")
                        (expand-file-name "~/AppData/Roaming/npm/agy.cmd"))
                (list (expand-file-name "~/.local/bin/agy")
                      "/usr/local/bin/agy"
                      "/usr/bin/agy"))))
        (seq-find #'file-executable-p candidates))
      (user-error "Executável `agy' não encontrado no PATH nem em ~/.local/bin")))

(defun fzl/agy--gemini-config-file ()
  "Return path to `~/.gemini/config/config.json` (portable across Linux/Windows)."
  (expand-file-name ".gemini/config/config.json" (expand-file-name "~")))

(defun fzl/agy--cli-settings-file ()
  "Return path to `~/.gemini/antigravity-cli/settings.json`."
  (expand-file-name ".gemini/antigravity-cli/settings.json" (expand-file-name "~")))

(defun fzl/agy--read-json-file (file)
  "Read FILE as a JSON alist, returning nil on missing or invalid file."
  (when (file-readable-p file)
    (condition-case nil
        (with-temp-buffer
          (insert-file-contents file)
          ;; Strip UTF-8 BOM if present on Windows
          (goto-char (point-min))
          (when (looking-at "\uFEFF")
            (delete-char 1))
          (let ((json-object-type 'alist)
                (json-array-type 'list)
                (json-key-type 'symbol))
            (json-read)))
      (error nil))))

(defun fzl/agy--write-json-file (file data)
  "Write alist DATA as pretty-printed JSON to FILE."
  (let ((dir (file-name-directory file)))
    (unless (file-directory-p dir)
      (make-directory dir t)))
  (let ((coding-system-for-write 'utf-8-unix)
        (json-encoding-pretty-print t))
    (with-temp-file file
      (insert (json-encode data))
      (insert "\n"))))

(defun fzl/agy--configure-session-name-and-trust (dir session-name)
  "Set `cliRemoteControlHostname` to SESSION-NAME and trust DIR in `settings.json`."
  (let* ((clean-dir (directory-file-name (expand-file-name dir)))
         (cfg-file (fzl/agy--gemini-config-file))
         (cfg (or (fzl/agy--read-json-file cfg-file) '()))
         (user-settings (alist-get 'userSettings cfg)))
    (setf (alist-get 'cliRemoteControlHostname user-settings) session-name)
    (setf (alist-get 'userSettings cfg) user-settings)
    (ignore-errors (fzl/agy--write-json-file cfg-file cfg))
    ;; Ensure directory is in trustedWorkspaces so remote session never hangs on trust prompt
    (let* ((settings-file (fzl/agy--cli-settings-file))
           (settings (or (fzl/agy--read-json-file settings-file) '()))
           (trusted (alist-get 'trustedWorkspaces settings)))
      (unless (member clean-dir trusted)
        (setf (alist-get 'trustedWorkspaces settings)
              (append trusted (list clean-dir)))
        (ignore-errors (fzl/agy--write-json-file settings-file settings))))))

;;; ----------------------------------------------------------------------------
;;; 2. Treemacs & Dired Directory + Folder Name Resolution
;;; ----------------------------------------------------------------------------

(defun fzl/agy--treemacs-path-at-point ()
  "Return the filesystem path at point in Treemacs, or nil if unavailable."
  (when (derived-mode-p 'treemacs-mode)
    (or (and (fboundp 'treemacs--prop-at-point)
             (ignore-errors (treemacs--prop-at-point :path)))
        (and (fboundp 'treemacs-current-button)
             (fboundp 'treemacs-button-get)
             (let ((btn (ignore-errors (treemacs-current-button))))
               (and btn (ignore-errors (treemacs-button-get btn :path))))))))

(defun fzl/agy--dired-path-at-point ()
  "Return the target directory when in `dired-mode`, or nil.
By default returns `(dired-current-directory)` (the Dired working directory).
If `fzl/agy-dired-prefer-subdir-at-point` is non-nil and point is on a
subdirectory line, returns that subdirectory."
  (when (derived-mode-p 'dired-mode)
    (let ((item (and fzl/agy-dired-prefer-subdir-at-point
                     (fboundp 'dired-get-filename)
                     (ignore-errors (dired-get-filename nil t)))))
      (if (and item
               (file-directory-p item)
               (not (member (file-name-nondirectory (directory-file-name item))
                            '("." ".."))))
          item
        (if (fboundp 'dired-current-directory)
            (dired-current-directory)
          default-directory)))))

(defun fzl/agy-target-directory (&optional prompt-if-prefix)
  "Resolve target directory from Treemacs, Dired, or `default-directory`.
If PROMPT-IF-PREFIX is non-nil (e.g. called with `C-u`), prompt for directory."
  (let* ((treemacs-path (fzl/agy--treemacs-path-at-point))
         (dired-path    (fzl/agy--dired-path-at-point))
         (candidate     (or treemacs-path dired-path default-directory))
         (raw-path      (cond
                         ((and (stringp candidate) (file-directory-p candidate))
                          candidate)
                         ((and (stringp candidate) (file-exists-p candidate))
                          (file-name-directory candidate))
                         (t default-directory)))
         (resolved      (file-name-as-directory (expand-file-name raw-path))))
    (if prompt-if-prefix
        (file-name-as-directory
         (expand-file-name
          (read-directory-name "Pasta para sessão remota do Antigravity: " resolved nil t)))
      resolved)))

(defun fzl/agy-folder-name (dir)
  "Extract the exact folder name from DIR to use as the remote session name."
  (let ((clean (directory-file-name (expand-file-name dir))))
    (file-name-nondirectory clean)))

(defun fzl/agy--process-environment ()
  "Build portable `process-environment` for `agy` subprocesses."
  (let ((env (copy-sequence process-environment)))
    (when (eq system-type 'gnu/linux)
      ;; Prevent BoringSSL CRNGT SIGABRT on affected Linux CPUs
      (push "OPENSSL_ia32cap=~0x4000000000000000" env))
    (push "AGY_CLI_HIDE_LOGO=1" env)
    env))

(defun fzl/agy--cleanup-dead-sessions ()
  "Remove finished processes from `fzl/agy-sessions`."
  (let (dead-keys)
    (maphash (lambda (k v)
               (unless (process-live-p (plist-get v :process))
                 (push k dead-keys)))
             fzl/agy-sessions)
    (dolist (k dead-keys)
      (remhash k fzl/agy-sessions))))

;;; ----------------------------------------------------------------------------
;;; 3. Interactive Commands: Start, Stop, Toggle, Status, Web
;;; ----------------------------------------------------------------------------

;;;###autoload
(defun fzl/agy-remote-start (&optional prefix)
  "Start an Antigravity remote session in the Treemacs or Dired folder.
The remote session is named after the exact folder name.
With PREFIX (`C-u`), prompt for the directory."
  (interactive "P")
  (fzl/agy--cleanup-dead-sessions)
  (let* ((dir (fzl/agy-target-directory prefix))
         (key (directory-file-name dir))
         (session-name (fzl/agy-folder-name dir))
         (existing (gethash key fzl/agy-sessions)))
    (if (and existing (process-live-p (plist-get existing :process)))
        (message "Antigravity: sessão remota [%s] já está rodando em %s (PID %s)."
                 session-name key (process-id (plist-get existing :process)))
      (let* ((agy-bin (fzl/agy-executable))
             (buf-name (format "*agy-remote:%s*" session-name))
             (buf (get-buffer-create buf-name))
             (default-directory dir)
             (process-environment (fzl/agy--process-environment))
             (process-connection-type nil))
        (fzl/agy--configure-session-name-and-trust dir session-name)
        (with-current-buffer buf
          (goto-char (point-max))
          (insert (format "\n=== [%s] Iniciando Antigravity Remote Control ===\nPasta: %s\nNome da sessão: %s\n"
                          (format-time-string "%Y-%m-%d %H:%M:%S") dir session-name)))
        (let ((proc (start-process (format "agy-remote-%s" session-name)
                                   buf
                                   agy-bin
                                   "remote-control" "serve")))
          (set-process-query-on-exit-flag proc nil)
          (puthash key
                   (list :name session-name
                         :dir dir
                         :process proc
                         :buffer buf
                         :mode 'background)
                   fzl/agy-sessions)
          (message "Antigravity: sessão remota [%s] iniciada para %s (PID %d)."
                   session-name key (process-id proc)))))))

;;;###autoload
(defun fzl/agy-remote-start-dired-workdir ()
  "Start an Antigravity remote session strictly in `dired-current-directory`,
even if `fzl/agy-dired-prefer-subdir-at-point` is enabled."
  (interactive)
  (let ((fzl/agy-dired-prefer-subdir-at-point nil))
    (fzl/agy-remote-start nil)))

;;;###autoload
(defun fzl/agy-remote-start-interactive (&optional prefix)
  "Start an interactive `agy --remote-control --project <folder>` terminal in Emacs."
  (interactive "P")
  (require 'term)
  (fzl/agy--cleanup-dead-sessions)
  (let* ((dir (fzl/agy-target-directory prefix))
         (key (directory-file-name dir))
         (session-name (fzl/agy-folder-name dir))
         (existing (gethash key fzl/agy-sessions)))
    (if (and existing (process-live-p (plist-get existing :process)))
        (progn
          (pop-to-buffer (plist-get existing :buffer))
          (message "Antigravity: sessão [%s] já está ativa." session-name))
      (fzl/agy--configure-session-name-and-trust dir session-name)
      (let* ((agy-bin (fzl/agy-executable))
             (default-directory dir)
             (process-environment (fzl/agy--process-environment))
             (term-buf (make-term (format "agy-tty:%s" session-name)
                                  agy-bin nil
                                  "--remote-control"
                                  "--project" session-name))
             (proc (get-buffer-process term-buf)))
        (with-current-buffer term-buf
          (term-mode)
          (term-char-mode))
        (set-process-query-on-exit-flag proc nil)
        (puthash key (list :name session-name :dir dir :process proc :buffer term-buf :mode 'interactive)
                 fzl/agy-sessions)
        (pop-to-buffer term-buf)
        (message "Antigravity: sessão remota interativa [%s] iniciada em %s." session-name key)))))

;;;###autoload
(defun fzl/agy-remote-stop (&optional prefix)
  "Stop the Antigravity remote session for the folder at point, or choose from active sessions.
With PREFIX (`C-u`), always prompt to choose from active sessions."
  (interactive "P")
  (fzl/agy--cleanup-dead-sessions)
  (let* ((dir (fzl/agy-target-directory nil))
         (key (directory-file-name dir))
         (at-point-session (and (not prefix) (gethash key fzl/agy-sessions))))
    (cond
     (at-point-session
      (let ((proc (plist-get at-point-session :process))
            (name (plist-get at-point-session :name)))
        (when (process-live-p proc)
          (delete-process proc))
        (remhash key fzl/agy-sessions)
        (message "Antigravity: sessão remota [%s] (%s) encerrada." name key)))
     ((> (hash-table-count fzl/agy-sessions) 0)
      (let (choices)
        (maphash (lambda (k v)
                   (push (cons (format "%s  —  %s" (plist-get v :name) k) k) choices))
                 fzl/agy-sessions)
        (let* ((picked (completing-read "Parar sessão remota do Antigravity: " choices nil t))
               (target-key (cdr (assoc picked choices)))
               (session (and target-key (gethash target-key fzl/agy-sessions))))
          (when session
            (let ((proc (plist-get session :process))
                  (name (plist-get session :name)))
              (when (process-live-p proc)
                (delete-process proc))
              (remhash target-key fzl/agy-sessions)
              (message "Antigravity: sessão remota [%s] (%s) encerrada." name target-key))))))
     (t
      ;; Also offer to stop the system-wide CLI daemon if running
      (let ((agy-bin (ignore-errors (fzl/agy-executable)))
            (process-environment (fzl/agy--process-environment)))
        (if agy-bin
            (progn
              (call-process agy-bin nil nil nil "remote-control" "stop")
              (message "Antigravity: nenhuma sessão de pasta ativa no Emacs; daemon global parado."))
          (message "Antigravity: nenhuma sessão remota ativa no momento.")))))))

;;;###autoload
(defun fzl/agy-remote-stop-all ()
  "Stop all active Antigravity remote sessions managed by Emacs and the background daemon."
  (interactive)
  (fzl/agy--cleanup-dead-sessions)
  (let ((count 0))
    (maphash (lambda (_k v)
               (let ((proc (plist-get v :process)))
                 (when (process-live-p proc)
                   (delete-process proc)
                   (setq count (1+ count)))))
             fzl/agy-sessions)
    (clrhash fzl/agy-sessions)
    (let ((agy-bin (ignore-errors (fzl/agy-executable)))
          (process-environment (fzl/agy--process-environment)))
      (when agy-bin
        (ignore-errors (call-process agy-bin nil nil nil "remote-control" "stop"))))
    (message "Antigravity: %d sessão(ões) remota(s) encerrada(s) e daemon parado." count)))

;;;###autoload
(defun fzl/agy-remote-toggle ()
  "Toggle Antigravity remote session for the Treemacs or Dired folder at point."
  (interactive)
  (fzl/agy--cleanup-dead-sessions)
  (let* ((dir (fzl/agy-target-directory nil))
         (key (directory-file-name dir))
         (existing (gethash key fzl/agy-sessions)))
    (if (and existing (process-live-p (plist-get existing :process)))
        (fzl/agy-remote-stop)
      (fzl/agy-remote-start))))

;;;###autoload
(defun fzl/agy-remote-status ()
  "Display active Antigravity remote sessions managed by Emacs."
  (interactive)
  (fzl/agy--cleanup-dead-sessions)
  (if (= (hash-table-count fzl/agy-sessions) 0)
      (message "Antigravity: nenhuma sessão remota ativa no Emacs.")
    (let (items)
      (maphash (lambda (k v)
                 (let ((proc (plist-get v :process)))
                   (push (format "[%s] (PID %s, %s) -> %s"
                                 (plist-get v :name)
                                 (if (process-live-p proc) (process-id proc) "morto")
                                 (plist-get v :mode)
                                 k)
                         items)))
               fzl/agy-sessions)
      (message "Antigravity sessões ativas (%d): %s"
               (length items)
               (string-join (nreverse items) " | ")))))

;;;###autoload
(defun fzl/agy-remote-open-buffer ()
  "Open the output or terminal buffer of an active Antigravity remote session."
  (interactive)
  (fzl/agy--cleanup-dead-sessions)
  (cond
   ((= (hash-table-count fzl/agy-sessions) 0)
    (user-error "Nenhuma sessão remota ativa no momento"))
   ((= (hash-table-count fzl/agy-sessions) 1)
    (let (buf)
      (maphash (lambda (_k v) (setq buf (plist-get v :buffer))) fzl/agy-sessions)
      (if (buffer-live-p buf)
          (pop-to-buffer buf)
        (user-error "Buffer da sessão não está mais ativo"))))
   (t
    (let (choices)
      (maphash (lambda (k v)
                 (push (cons (format "%s  —  %s" (plist-get v :name) k)
                             (plist-get v :buffer))
                       choices))
               fzl/agy-sessions)
      (let* ((picked (completing-read "Abrir buffer da sessão: " choices nil t))
             (buf (cdr (assoc picked choices))))
        (when (buffer-live-p buf)
          (pop-to-buffer buf)))))))

;;;###autoload
(defun fzl/agy-remote-open-web ()
  "Open https://antigravity.google.com in the system browser."
  (interactive)
  (browse-url fzl/agy-remote-url)
  (message "Abrindo %s no navegador..." fzl/agy-remote-url))

;;; ----------------------------------------------------------------------------
;;; 4. Keybindings, Top Menu Bar, Treemacs & Dired Integration
;;; ----------------------------------------------------------------------------

(defvar fzl/agy-command-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") #'fzl/agy-remote-start)
    (define-key map (kbd "S") #'fzl/agy-remote-start-dired-workdir)
    (define-key map (kbd "i") #'fzl/agy-remote-start-interactive)
    (define-key map (kbd "k") #'fzl/agy-remote-stop)
    (define-key map (kbd "K") #'fzl/agy-remote-stop-all)
    (define-key map (kbd "t") #'fzl/agy-remote-toggle)
    (define-key map (kbd "l") #'fzl/agy-remote-status)
    (define-key map (kbd "b") #'fzl/agy-remote-open-buffer)
    (define-key map (kbd "w") #'fzl/agy-remote-open-web)
    map)
  "Keymap for Antigravity remote control commands under `C-c a`.")

(global-set-key (kbd "C-c a") fzl/agy-command-map)

(with-eval-after-load 'treemacs
  (when (boundp 'treemacs-mode-map)
    (define-key treemacs-mode-map (kbd "C-c a") fzl/agy-command-map)))

(with-eval-after-load 'dired
  (when (boundp 'dired-mode-map)
    (define-key dired-mode-map (kbd "C-c a") fzl/agy-command-map)))

(easy-menu-define fzl/agy-menu global-map "Menu de controle remoto do Antigravity (agy)."
  '("Antigravity"
    ["Iniciar Sessão Remota na Pasta (Treemacs/Dired) (C-c a s)" fzl/agy-remote-start t]
    ["Iniciar Sessão no Diretório de Trabalho do Dired (C-c a S)" fzl/agy-remote-start-dired-workdir
     :visible (derived-mode-p 'dired-mode)]
    ["Iniciar Sessão Interativa no Emacs (C-c a i)"              fzl/agy-remote-start-interactive t]
    ["Alternar (Start/Stop) na Pasta Atual (C-c a t)"            fzl/agy-remote-toggle t]
    "--"
    ["Parar Sessão Remota (C-c a k)"                             fzl/agy-remote-stop t]
    ["Parar TODAS as Sessões Remotas (C-c a K)"                  fzl/agy-remote-stop-all t]
    "--"
    ["Status das Sessões Ativas (C-c a l)"                       fzl/agy-remote-status t]
    ["Ver Buffer de Log/Terminal (C-c a b)"                      fzl/agy-remote-open-buffer t]
    ["Abrir Painel Web Remote Control (C-c a w)"                 fzl/agy-remote-open-web t]))

(provide 'pkgconfig-antigravity)
;;; pkgconfig-antigravity.el ends here
