;;; desktoping-apps.el --- Desktop applications, host configs, sync, bookmarks, and shortcuts manager -*- lexical-binding: t -*-

;;; Commentary:
;; This package organizes desktop application launchers, cloud synchronization
;; commands, host/system configuration files, Buku bookmark management, and developer utilities.
;; It establishes a dedicated prefix keymap (C-c d) and installs the "Desktoping"
;; menu bar item with shortcut hints for all actions.

;;; Code:

(require 'easymenu)
(require 'subr-x)
(require 'fzl-util-browser nil t)

;;; ============================================================================
;;; Helper Functions
;;; ============================================================================

(defun desktoping--open-file-or-sudo (file-path)
  "Open FILE-PATH. If not writable, attempt to open via TRAMP sudo."
  (if (file-writable-p file-path)
      (find-file file-path)
    (find-file (concat "/sudo::" file-path))))

(defun desktoping--browse-url (url)
  "Open URL in the default browser."
  (if (fboundp 'fzl-open-url-in-browser)
      (fzl-open-url-in-browser url)
    (browse-url url)))

;;; ============================================================================
;;; Group 1: Productivity & Office Applications
;;; ============================================================================

(defun desktoping-app-chromium ()
  "Launch Chromium Browser in the background."
  (interactive)
  (let ((chromium-bin (or (executable-find "chromium-browser")
                          (executable-find "chromium")
                          "chromium-browser")))
    (start-process "desktoping-chromium" nil chromium-bin)
    (message "Launched Chromium Browser in background.")))

(defun desktoping-app-libreoffice ()
  "Launch LibreOffice in the background."
  (interactive)
  (start-process "desktoping-libreoffice" nil "libreoffice")
  (message "Launched LibreOffice in background."))

(defun desktoping-libreoffice-open-templates-dir ()
  "Open the LibreOffice user templates directory in Dired."
  (interactive)
  (let ((dir (expand-file-name "~/.config/libreoffice/4/user/templates/")))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (dired dir)))

(defun desktoping-libreoffice-open-mytemplates-dir ()
  "Open the LibreOffice custom mytemplates directory in Dired."
  (interactive)
  (let ((dir (expand-file-name "~/.config/libreoffice/4/user/mytemplates/")))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (dired dir)))

(defun desktoping-libreoffice-open-extensions-dir ()
  "Open the LibreOffice extensions directory in Dired."
  (interactive)
  (let ((dir (expand-file-name "~/.config/libreoffice/4/user/uno_packages/")))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (dired dir)))

(defun desktoping-libreoffice-open-templates-web ()
  "Open the LibreOffice templates website in browser."
  (interactive)
  (desktoping--browse-url "https://www.libreofficetemplates.net"))

;;; ============================================================================
;;; Group 2: Cloud & Synchronization Tools
;;; ============================================================================

(defun desktoping-cloud-rclone-gdrive-to-desktop ()
  "Run rclone sync from GDrive_wgn: to ~/Desktop asynchronously."
  (interactive)
  (async-shell-command "rclone sync GDrive_wgn:/ ~/Desktop" "*desktoping-rclone-sync*")
  (message "Started rclone sync: GDrive -> Desktop"))

(defun desktoping-cloud-rclone-desktop-to-gdrive ()
  "Run rclone sync from ~/Desktop to GDrive_wgn: asynchronously."
  (interactive)
  (async-shell-command "rclone sync ~/Desktop GDrive_wgn:/" "*desktoping-rclone-sync*")
  (message "Started rclone sync: Desktop -> GDrive"))

(defun desktoping-cloud-azure-login ()
  "Run Azure CLI interactive login in a shell buffer."
  (interactive)
  (let ((buf (get-buffer-create "*desktoping-azure-login*")))
    (display-buffer buf)
    (async-shell-command "az login" buf)
    (message "Executed `az login` in buffer *desktoping-azure-login*.")))

;;; ============================================================================
;;; Group 3: Configuration Files (Host, System & User)
;;; ============================================================================

;; User & Developer configs
(defun desktoping-config-git ()
  "Open global git configuration ~/.gitconfig."
  (interactive)
  (find-file (expand-file-name "~/.gitconfig")))

(defun desktoping-config-maven ()
  "Open Maven settings.xml."
  (interactive)
  (find-file (expand-file-name "~/.m2/settings.xml")))

(defun desktoping-config-gradle ()
  "Open Gradle properties file."
  (interactive)
  (find-file (expand-file-name "~/.gradle/gradle.properties")))

;; Host & System (/etc) configs
(defun desktoping-config-selinux ()
  "Open /etc/selinux/config with sudo if necessary."
  (interactive)
  (desktoping--open-file-or-sudo "/etc/selinux/config"))

(defun desktoping-config-ansible-hosts ()
  "Open /etc/ansible/hosts with sudo if necessary."
  (interactive)
  (desktoping--open-file-or-sudo "/etc/ansible/hosts"))

(defun desktoping-config-ansible ()
  "Open /etc/ansible/ansible.cfg or ~/.ansible.cfg."
  (interactive)
  (let ((file (if (file-exists-p "~/.ansible.cfg")
                  (expand-file-name "~/.ansible.cfg")
                "/etc/ansible/ansible.cfg")))
    (desktoping--open-file-or-sudo file)))

(defun desktoping-config-resolv ()
  "Open /etc/resolv.conf with sudo if necessary."
  (interactive)
  (desktoping--open-file-or-sudo "/etc/resolv.conf"))

(defun desktoping-config-network-ifcfg ()
  "Open /etc/sysconfig/network-scripts/ifcfg-enp2s0 with sudo if necessary."
  (interactive)
  (desktoping--open-file-or-sudo "/etc/sysconfig/network-scripts/ifcfg-enp2s0"))

;; Systemd services configs
(defun desktoping-config-docker-service ()
  "Open systemd docker.service file with sudo if necessary."
  (interactive)
  (let ((paths '("/etc/systemd/system/docker.service"
                 "/usr/lib/systemd/system/docker.service"
                 "/lib/systemd/system/docker.service")))
    (desktoping--open-file-or-sudo
     (or (seq-find #'file-exists-p paths)
         "/usr/lib/systemd/system/docker.service"))))

(defun desktoping-config-docker-storage ()
  "Open docker-storage-setup configuration file with sudo if necessary."
  (interactive)
  (desktoping--open-file-or-sudo "/etc/sysconfig/docker-storage-setup"))

(defun desktoping-config-mariadb-service ()
  "Open systemd mariadb.service file with sudo if necessary."
  (interactive)
  (let ((paths '("/etc/systemd/system/mariadb.service"
                 "/usr/lib/systemd/system/mariadb.service"
                 "/lib/systemd/system/mariadb.service")))
    (desktoping--open-file-or-sudo
     (or (seq-find #'file-exists-p paths)
         "/usr/lib/systemd/system/mariadb.service"))))

;;; ============================================================================
;;; Group 4: Bookmarks Management (Buku Integration)
;;; ============================================================================

(defvar desktoping-buku-db-path nil
  "Custom path to Buku SQLite database. If nil, uses default ~/.local/share/buku/bookmarks.db.")

(defun desktoping-buku-open-manager ()
  "Open interactive ebuku manager if available, or launch search."
  (interactive)
  (if (fboundp 'ebuku)
      (ebuku)
    (if (executable-find "buku")
        (desktoping-buku-search-and-open)
      (message "Buku CLI not found. Install with: sudo dnf install buku"))))

(defun desktoping--buku-parse-json (str)
  "Extract and parse JSON array from Buku output STR, ignoring warning noise."
  (let ((start (string-match "\\[" str))
        (end (when (string-match "\\][^]]*$" str)
               (match-end 0))))
    (if (and start end)
        (condition-case nil
            (json-parse-string (substring str start end) :object-type 'alist :array-type 'list)
          (error nil))
      nil)))

(defun desktoping--buku-get-entries ()
  "Fetch and parse all Buku bookmark entries."
  (unless (executable-find "buku")
    (user-error "Buku executable not found in PATH. Install with: sudo dnf install buku"))
  (let* ((cmd "PYTHONWARNINGS=\"ignore\" buku --nostdin -p -j 2>/dev/null")
         (json-str (shell-command-to-string cmd)))
    (desktoping--buku-parse-json json-str)))

(defun desktoping--buku-get-all-tags (entries)
  "Extract a unique, sorted list of all tags from ENTRIES."
  (let (tag-list)
    (dolist (item entries)
      (let ((raw-tags (cdr (assq 'tags item))))
        (when raw-tags
          (let ((split-tags (if (listp raw-tags)
                                raw-tags
                              (split-string raw-tags "," t "[ \t\n\r]+"))))
            (dolist (tag split-tags)
              (let ((clean (string-trim tag)))
                (unless (or (string-empty-p clean) (member clean tag-list))
                  (push clean tag-list))))))))
    (sort tag-list #'string-lessp)))

(defun desktoping--buku-entry-has-tag-p (item tag)
  "Check if ITEM has TAG."
  (let ((raw-tags (cdr (assq 'tags item))))
    (when raw-tags
      (let ((split-tags (if (listp raw-tags)
                            raw-tags
                          (split-string raw-tags "," t "[ \t\n\r]+"))))
        (seq-some (lambda (tg) (string= (string-trim tg) tag)) split-tags)))))

(defun desktoping-buku-search-and-open ()
  "Search Buku bookmarks interactively and open selected URL in default browser."
  (interactive)
  (let ((entries (desktoping--buku-get-entries)))
    (if (not entries)
        (message "No bookmarks found in Buku database (or database is empty).")
      (let* ((candidates
              (mapcar (lambda (item)
                        (let* ((index (cdr (assq 'index item)))
                               (raw-title (cdr (assq 'title item)))
                               (uri (cdr (assq 'uri item)))
                               (desc (cdr (assq 'description item)))
                               (tags (cdr (assq 'tags item)))
                               (tag-str (if (listp tags) (string-join tags ", ") (or tags "")))
                               (title (cond
                                       ((and (stringp raw-title) (not (string-empty-p raw-title)) (not (string= raw-title "Untitled"))) raw-title)
                                       ((and (stringp desc) (not (string-empty-p desc))) desc)
                                       (t uri)))
                               (display (format "[#%s] %s  (%s)%s"
                                                index
                                                title
                                                uri
                                                (if (string-empty-p tag-str) "" (concat "  🏷️ " tag-str)))))
                          (cons display uri)))
                      entries))
             (choice (completing-read "Open Bookmark: " (mapcar #'car candidates) nil t))
             (selected-url (cdr (assoc choice candidates))))
        (when selected-url
          (desktoping--browse-url selected-url)
          (message "Opened: %s" selected-url))))))

(defun desktoping-buku-browse-by-tag ()
  "Filter and browse Bookmarks by a selected Tag/Group."
  (interactive)
  (let* ((entries (desktoping--buku-get-entries))
         (tags (desktoping--buku-get-all-tags entries)))
    (if (not tags)
        (message "No tagged bookmarks found in database.")
      (let* ((chosen-tag (completing-read "Filter by Tag/Group: " tags nil t))
             (filtered (seq-filter (lambda (item) (desktoping--buku-entry-has-tag-p item chosen-tag)) entries))
             (candidates
              (mapcar (lambda (item)
                        (let* ((index (cdr (assq 'index item)))
                               (raw-title (cdr (assq 'title item)))
                               (uri (cdr (assq 'uri item)))
                               (desc (cdr (assq 'description item)))
                               (title (cond
                                       ((and (stringp raw-title) (not (string-empty-p raw-title)) (not (string= raw-title "Untitled"))) raw-title)
                                       ((and (stringp desc) (not (string-empty-p desc))) desc)
                                       (t uri)))
                               (display (format "[#%s] %s  (%s)" index title uri)))
                          (cons display uri)))
                      filtered))
             (choice (completing-read (format "Bookmarks in group [%s]: " chosen-tag)
                                      (mapcar #'car candidates) nil t))
             (selected-url (cdr (assoc choice candidates))))
        (when selected-url
          (desktoping--browse-url selected-url)
          (message "Opened: %s" selected-url))))))

(defun desktoping-buku-open-all-in-tag ()
  "Open ALL bookmarks belonging to a selected Tag/Group in separate browser tabs."
  (interactive)
  (let* ((entries (desktoping--buku-get-entries))
         (tags (desktoping--buku-get-all-tags entries)))
    (if (not tags)
        (message "No tagged bookmarks found in database.")
      (let* ((chosen-tag (completing-read "Open all links for Tag/Group: " tags nil t))
             (filtered (seq-filter (lambda (item) (desktoping--buku-entry-has-tag-p item chosen-tag)) entries))
             (urls (delq nil (mapcar (lambda (item) (cdr (assq 'uri item))) filtered))))
        (if (not urls)
            (message "No URLs found for tag '%s'." chosen-tag)
          (when (yes-or-no-p (format "Open all %d bookmarks for group '%s' in Chromium? " (length urls) chosen-tag))
            (dolist (u urls)
              (desktoping--browse-url u))
            (message "Opened %d bookmarks for group '%s'." (length urls) chosen-tag)))))))

(defun desktoping-buku-add-bookmark (url title tags comment)
  "Add a new bookmark to Buku with URL, optional TITLE, TAGS, and optional COMMENT."
  (interactive
   (let* ((default-url (or (thing-at-point 'url) (current-kill 0 t) ""))
          (in-url (read-string (format "URL (%s): " (if (string-empty-p default-url) "required" default-url))
                               nil nil (if (string-empty-p default-url) nil default-url)))
          (in-title (read-string "Title (optional, blank to auto-fetch): "))
          (in-tags (read-string "Tags (comma-separated, e.g. dev,emacs,linux): "))
          (in-comment (read-string "Comment / Description (optional): ")))
     (list in-url in-title in-tags in-comment)))
  (unless (executable-find "buku")
    (user-error "Buku executable not found in PATH. Install with: sudo dnf install buku"))
  (if (string-empty-p url)
      (message "No URL provided.")
    (let* ((cmd (format "PYTHONWARNINGS=\"ignore\" buku -a %s %s %s %s --nostdin 2>&1"
                        (shell-quote-argument url)
                        (if (string-empty-p tags) "" (shell-quote-argument tags))
                        (if (string-empty-p comment) "" (format "-c %s" (shell-quote-argument comment)))
                        (if (string-empty-p title) "" (format "--title %s" (shell-quote-argument title)))))
           (output (shell-command-to-string cmd)))
      (message "Buku: Bookmark added successfully!"))))

(defun desktoping-buku-export-html (file)
  "Export Buku bookmarks to Netscape HTML format (importable into any browser)."
  (interactive "FExport bookmarks to HTML file: ")
  (unless (executable-find "buku")
    (user-error "Buku executable not found in PATH."))
  (let ((cmd (format "PYTHONWARNINGS=\"ignore\" buku -e %s --nostdin" (shell-quote-argument (expand-file-name file)))))
    (shell-command cmd)
    (message "Exported Buku bookmarks to %s" file)))

(defun desktoping-buku-import-html (file)
  "Import bookmarks from an HTML file into Buku."
  (interactive "fImport bookmarks from HTML file: ")
  (unless (executable-find "buku")
    (user-error "Buku executable not found in PATH."))
  (let ((cmd (format "PYTHONWARNINGS=\"ignore\" buku -i %s --nostdin" (shell-quote-argument (expand-file-name file)))))
    (async-shell-command cmd "*desktoping-buku-import*")
    (message "Importing bookmarks from %s into Buku..." file)))

(defun desktoping-buku-open-tutorial ()
  "Open the Brazilian Portuguese Buku tutorial in Emacs."
  (interactive)
  (let* ((dir (file-name-directory (or load-file-name buffer-file-name (locate-library "desktoping-apps") "")))
         (file (expand-file-name "buku-tutorial-guia.org" dir)))
    (if (file-exists-p file)
        (find-file file)
      (find-file (expand-file-name "buku-tutorial-guia.org" default-directory)))))

;;; ============================================================================
;;; Group 5: Utilities & Documentation
;;; ============================================================================

(defun desktoping-util-org-cheatsheet ()
  "Open the Org-mode reference sheet card in browser."
  (interactive)
  (desktoping--browse-url "https://orgmode.org/orgcard.pdf"))

(defun desktoping-util-org-export-beamer ()
  "Export the current Org buffer to Beamer PDF."
  (interactive)
  (if (fboundp 'org-beamer-export-to-pdf)
      (org-beamer-export-to-pdf)
    (message "org-beamer-export-to-pdf is not available.")))

(defun desktoping-util-wkhtmltopdf ()
  "Convert the current HTML file visiting the buffer to a PDF."
  (interactive)
  (if (and (buffer-file-name) (string-match-p "\\.html?$" (buffer-file-name)))
      (let* ((html-file (buffer-file-name))
             (pdf-file (concat (file-name-sans-extension html-file) ".pdf"))
             (cmd (format "wkhtmltopdf %s %s"
                          (shell-quote-argument html-file)
                          (shell-quote-argument pdf-file))))
        (async-shell-command cmd "*desktoping-wkhtmltopdf*")
        (message "Generating PDF: %s" pdf-file))
    (message "Current buffer is not visiting an HTML file.")))

(defun desktoping-util-npm-config-list ()
  "List npm configuration in a dedicated buffer."
  (interactive)
  (async-shell-command "npm config list" "*desktoping-npm-config*"))

;;; ============================================================================
;;; Keymap Setup (Prefix: C-c d)
;;; ============================================================================

(defvar desktoping-apps-map (make-sparse-keymap)
  "Keymap prefix for Desktoping commands.")

;; Define prefix command
(define-prefix-command 'desktoping-apps-map)
(define-key global-map (kbd "C-c d") 'desktoping-apps-map)

;; Productivity & App keybindings
(define-key desktoping-apps-map (kbd "C")   #'desktoping-app-chromium)
(define-key desktoping-apps-map (kbd "B")   #'desktoping-app-chromium)
(define-key desktoping-apps-map (kbd "l")   #'desktoping-app-libreoffice)
(define-key desktoping-apps-map (kbd "t")   #'desktoping-libreoffice-open-templates-dir)
(define-key desktoping-apps-map (kbd "T")   #'desktoping-libreoffice-open-mytemplates-dir)
(define-key desktoping-apps-map (kbd "e")   #'desktoping-libreoffice-open-extensions-dir)
(define-key desktoping-apps-map (kbd "w")   #'desktoping-libreoffice-open-templates-web)

;; Cloud & Sync keybindings
(define-key desktoping-apps-map (kbd "s g") #'desktoping-cloud-rclone-gdrive-to-desktop)
(define-key desktoping-apps-map (kbd "s d") #'desktoping-cloud-rclone-desktop-to-gdrive)
(define-key desktoping-apps-map (kbd "a")   #'desktoping-cloud-azure-login)

;; Config files keybindings (User & Dev)
(define-key desktoping-apps-map (kbd "c g") #'desktoping-config-git)
(define-key desktoping-apps-map (kbd "c m") #'desktoping-config-maven)
(define-key desktoping-apps-map (kbd "c p") #'desktoping-config-gradle)

;; Config files keybindings (Host & System)
(define-key desktoping-apps-map (kbd "c x") #'desktoping-config-selinux)
(define-key desktoping-apps-map (kbd "c h") #'desktoping-config-ansible-hosts)
(define-key desktoping-apps-map (kbd "c a") #'desktoping-config-ansible)
(define-key desktoping-apps-map (kbd "c r") #'desktoping-config-resolv)
(define-key desktoping-apps-map (kbd "c n") #'desktoping-config-network-ifcfg)

;; Config files keybindings (Systemd services)
(define-key desktoping-apps-map (kbd "c d") #'desktoping-config-docker-service)
(define-key desktoping-apps-map (kbd "c s") #'desktoping-config-docker-storage)
(define-key desktoping-apps-map (kbd "c b") #'desktoping-config-mariadb-service)

;; Bookmarks (Buku) keybindings (Prefix: C-c d b)
(define-key desktoping-apps-map (kbd "b b") #'desktoping-buku-open-manager)
(define-key desktoping-apps-map (kbd "b s") #'desktoping-buku-search-and-open)
(define-key desktoping-apps-map (kbd "b g") #'desktoping-buku-browse-by-tag)
(define-key desktoping-apps-map (kbd "b o") #'desktoping-buku-open-all-in-tag)
(define-key desktoping-apps-map (kbd "b a") #'desktoping-buku-add-bookmark)
(define-key desktoping-apps-map (kbd "b e") #'desktoping-buku-export-html)
(define-key desktoping-apps-map (kbd "b i") #'desktoping-buku-import-html)
(define-key desktoping-apps-map (kbd "b t") #'desktoping-buku-open-tutorial)

;; Utilities & Docs keybindings
(define-key desktoping-apps-map (kbd "o c") #'desktoping-util-org-cheatsheet)
(define-key desktoping-apps-map (kbd "o b") #'desktoping-util-org-export-beamer)
(define-key desktoping-apps-map (kbd "p")   #'desktoping-util-wkhtmltopdf)
(define-key desktoping-apps-map (kbd "n")   #'desktoping-util-npm-config-list)

;;; ============================================================================
;;; Menu Definition: "Desktoping"
;;; ============================================================================

(easy-menu-define desktoping-apps-menu global-map "Desktoping Applications Menu"
  '("Desktoping"
    ("Bookmarks (Buku)"
     ["Search & Open Bookmark" desktoping-buku-search-and-open :keys "C-c d b s" :help "Search bookmarks and open in browser"]
     ["Filter by Tag/Group" desktoping-buku-browse-by-tag :keys "C-c d b g" :help "Browse bookmarks in a specific tag group"]
     ["Open All in Tag/Group (Tabs)" desktoping-buku-open-all-in-tag :keys "C-c d b o" :help "Open all links of a tag group in Chromium tabs"]
     "---"
     ["Add New Bookmark" desktoping-buku-add-bookmark :keys "C-c d b a" :help "Add bookmark with tags and comments"]
     ["Open Buku Manager (ebuku)" desktoping-buku-open-manager :keys "C-c d b b" :help "Open interactive ebuku manager"]
     "---"
     ["Export to HTML (Cross-Browser)" desktoping-buku-export-html :keys "C-c d b e" :help "Export bookmarks to Netscape HTML"]
     ["Import from HTML (Browser Export)" desktoping-buku-import-html :keys "C-c d b i" :help "Import bookmarks from HTML file"]
     "---"
     ["Buku Tutorial & Guia (Org)" desktoping-buku-open-tutorial :keys "C-c d b t" :help "Open Brazilian Portuguese tutorial"])
    ("Applications & Office"
     ["Start Chromium Browser" desktoping-app-chromium :keys "C-c d C" :help "Launch Chromium Browser"]
     "---"
     ["Start LibreOffice" desktoping-app-libreoffice :keys "C-c d l" :help "Launch LibreOffice"]
     ["Templates Directory" desktoping-libreoffice-open-templates-dir :keys "C-c d t" :help "Open LibreOffice templates in Dired"]
     ["Custom MyTemplates Directory" desktoping-libreoffice-open-mytemplates-dir :keys "C-c d T" :help "Open user templates in Dired"]
     ["Extensions Directory" desktoping-libreoffice-open-extensions-dir :keys "C-c d e" :help "Open UNO packages extensions directory"]
     "---"
     ["Templates Online Site" desktoping-libreoffice-open-templates-web :keys "C-c d w" :help "Open templates site in browser"])
    ("Cloud & Synchronization"
     ["Rclone: GDrive -> Desktop" desktoping-cloud-rclone-gdrive-to-desktop :keys "C-c d s g" :help "Sync GDrive to Desktop"]
     ["Rclone: Desktop -> GDrive" desktoping-cloud-rclone-desktop-to-gdrive :keys "C-c d s d" :help "Sync Desktop to GDrive"]
     "---"
     ["Azure Login (az login)" desktoping-cloud-azure-login :keys "C-c d a" :help "Login to Azure CLI"])
    ("Configuration Files"
     ("Host & System (/etc)"
      ["SELinux (/etc/selinux/config)" desktoping-config-selinux :keys "C-c d c x" :help "Open /etc/selinux/config"]
      ["Ansible Hosts (/etc/ansible/hosts)" desktoping-config-ansible-hosts :keys "C-c d c h" :help "Open /etc/ansible/hosts"]
      ["Ansible Config (ansible.cfg)" desktoping-config-ansible :keys "C-c d c a" :help "Open ansible.cfg"]
      ["DNS Resolv (/etc/resolv.conf)" desktoping-config-resolv :keys "C-c d c r" :help "Open /etc/resolv.conf"]
      ["Network ifcfg (ifcfg-enp2s0)" desktoping-config-network-ifcfg :keys "C-c d c n" :help "Open network ifcfg"])
     ("Services (Systemd)"
      ["Docker Service (/etc/...)" desktoping-config-docker-service :keys "C-c d c d" :help "Open docker.service"]
      ["Docker Storage Setup" desktoping-config-docker-storage :keys "C-c d c s" :help "Open docker-storage-setup"]
      ["MariaDB Service" desktoping-config-mariadb-service :keys "C-c d c b" :help "Open mariadb.service"])
     ("User & Developer (~/)"
      ["Git Config (~/.gitconfig)" desktoping-config-git :keys "C-c d c g" :help "Open ~/.gitconfig"]
      ["Maven Settings (~/.m2/settings.xml)" desktoping-config-maven :keys "C-c d c m" :help "Open Maven settings"]
      ["Gradle Properties (~/.gradle/gradle.properties)" desktoping-config-gradle :keys "C-c d c p" :help "Open Gradle properties"]))
    ("Utilities & Docs"
     ["Org-Mode Cheatsheet (Web)" desktoping-util-org-cheatsheet :keys "C-c d o c" :help "Open Org-mode reference sheet"]
     ["Org-Mode Export Beamer" desktoping-util-org-export-beamer :keys "C-c d o b" :help "Export Org to Beamer PDF"]
     "---"
     ["HTML to PDF (wkhtmltopdf)" desktoping-util-wkhtmltopdf :keys "C-c d p" :help "Convert HTML file to PDF"]
     ["NPM Config List" desktoping-util-npm-config-list :keys "C-c d n" :help "List npm configuration"])))

(provide 'desktoping-apps)
;;; desktoping-apps.el ends here
