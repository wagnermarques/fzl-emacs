;;; package --- Summary
;;; Commentary:
;;; Code:

(provide 'fzl_menus)

(require 'easymenu)
(require 'fzl-util-browser)

(easy-menu-define djcb-menu global-map "HOST"
  '("HOST Config"
    ("Config"
     ("Etc"
      ["/etc/selinux/config" fzl-find-file-as-root-selinuxconfig]
      ["/etc/ansible/hosts" fzl-find-file-as-root-ansible-hosts]
      ["/etc/ansible/a" fzl-find-file-as-root-ansible-cfg]))))

(easy-menu-define djcb-menu global-map "HOST"
  '("Desktop"
    ("Libre Office"
     ("Bookmarks"
      ("Templates"
       ["www.libreofficetemplates.net"
        (lambda () (interactive)
          (fzl-libreoffice-bookmarks--open-templates-site-in-browser "https://www.libreofficetemplates.net"))]
       ["Open Libre Office templates folder" fzl-open-libre-office-templates-folder]
       ["Open Libre Office my templates folder" fzl-open-libre-office-my-templates-folder])
      ("Extensions"
       ["Open Libre Office extensions folder" fzl-open-libre-office-extensions-folder]))
     ["Start Libre Office" fzl-start-libre-office]
     ["Open Libre Office config file" fzl-open-libre-office-config-file])
    ("Utils"
     ["wkhtmltopdf" fzl-html2pdf])
    ("Desktop"
     ("Azure"
      ["az login" fzl-az-login])
     ["Rclone sync GDrive_wgn:/ 2 Desktop" rclone_sync_from_gdrive_to_desktop]
     ["Rclone sync Desktop to GDrive_wgn" rclone_sync_from_desktop_to_gdrive]
     ("Nodejs"
      ["List config (TODO)" nodejs-npm-config-list]))
    ("Org-mode"
     ["Export Beamer" fzl-orgmode-export-beamer-to-pdf]
     ["Open org-mode cheat sheet in browser"
      (lambda () (interactive)
        (start-process
         "ProcessName=OrgModeCheetSheetInBrowser"
         "BufferNameForTheProcess=OrgModeCheetSheetInBrowser"
         "firefox"
         "http://orgmode.org/orgcard.pdf"))])
    ("Config files"
     ["Maven Settings: " (lambda () (interactive) (fzl-maven-settings))]
     ["Git config: ~/.gitconfig" (lambda () (interactive) (find-file "~/.gitconfig"))]
     ["docker.service file" fzl-docker-service]
     ["docker-storage-setup file" fzl-docker-storage-setup]
     ["mariadb.service file" fzl-mariadb-service]
     ["~/.gradle/gradle.properties file" fzl-open-gradle-properties-file]
     ["/etc/sysconfig/network-scripts/ifcfg-enp2s0" fzl-open-ifcfg-enp2s0-file]
     ["/etc/resolv.conf" fzl-open-resolv-conf-file]
     ["ansible.cfg file" fzl-ansible-service])))

(defun fzl-libreoffice-bookmarks--open-templates-site-in-browser (url)
  "Open the Libre Office templates site in browser."
  (interactive)
  (fzl-open-url-in-browser url))

(defun fzl-open-libre-office-templates-folder ()
  "Open the Libre Office templates folder."
  (interactive)
  (start-process
   "ProcessName=LibreOfficeTemplatesFolder"
   "BufferNameForTheProcess=LibreOfficeTemplatesFolder"
   "xdg-open"
   (concat (getenv "HOME") "/.config/libreoffice/4/user/templates/")))

(defun fzl-open-libre-office-my-templates-folder ()
  "Open the Libre Office my templates folder."
  (interactive)
  (start-process
   "ProcessName=LibreOfficeMyTemplatesFolder"
   "BufferNameForTheProcess=LibreOfficeMyTemplatesFolder"
   "xdg-open"
   (concat (getenv "HOME") "/.config/libreoffice/4/user/mytemplates/")))

(provide 'fzl-ide-feat-menus)

;;; fzl-ide-feat-menus.el ends here
