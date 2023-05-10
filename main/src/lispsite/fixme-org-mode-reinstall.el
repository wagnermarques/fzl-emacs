;; Remove the existing Org mode installation from Emacs packages
;; Delete the org package, if it's installed
(require 'package)

(when (package-installed-p 'org)
  (package-delete (cadr (assq 'org package-alist))))


;; Delete the ~/.emacs.d/elpa/org-* directory
(let ((org-dir (concat user-emacs-directory "elpa/org-*")))
  (when (file-exists-p org-dir)
    (delete-directory org-dir t)))

;; Download the latest version of Org mode from the official website
(let* ((url "https://orgmode.org/org-latest.tar.gz")
       (filename (concat temporary-file-directory "org-latest.tar.gz")))
  (url-copy-file url filename)
  (message "Downloaded %s" filename))

;; Extract the tarball
(let ((org-tarball (concat temporary-file-directory "org-latest.tar.gz"))
      (org-dir (concat user-emacs-directory "site-lisp/org-*")))
  (when (file-exists-p org-dir)
    (delete-directory org-dir t))
  (make-directory org-dir t)
  (shell-command (concat "tar xvf " org-tarball " -C " org-dir))
  (message "Extracted %s to %s" org-tarball org-dir))

;; Add the new Org mode directory to your load-path
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/org-*"))

;; Byte-compile the new Org mode files
(byte-recompile-directory (concat user-emacs-directory "site-lisp/org-*") 0)

;; Restart Emacs
(restart-emacs)
