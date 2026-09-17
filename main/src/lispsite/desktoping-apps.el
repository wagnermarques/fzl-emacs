;;; desktoping-apps.el --- Desktop applications, host configs, sync, and shortcuts manager -*- lexical-binding: t -*-

;;; Commentary:
;; This package organizes desktop application launchers, cloud synchronization
;; commands, host/system configuration files, and developer utilities.
;; It establishes a dedicated prefix keymap (C-c d) and installs the "Desktoping"
;; menu bar item with shortcut hints for all actions.

;;; Code:

(require 'easymenu)
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
;;; Group 4: Utilities & Documentation
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

;; Productivity keybindings
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
    ("LibreOffice & Office"
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
