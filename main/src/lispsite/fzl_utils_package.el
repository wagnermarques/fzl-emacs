;;https://www.gnu.org/software/emacs/manual/html_node/elisp/Packaging-Basics.html

(print "===> fzl_utils_package.el loaded sucessfully!!!")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("melpa" . "https://melpa.org/packages/")))

(require 'package)
(setq package-check-signature nil)

(package-initialize)

(defun fzl/install-package-if-not-installed (pkgName)
  (print pkgName)
  (if (not (package-installed-p pkgName))
      (progn
        ;;befor install packages we need to refresh package contents
        ;;in order to work around pkgName is unavailable error like below
        ;;Debugger entered--Lisp error: (error "Package ‘pkgName’ is unavailable")
        (package-refresh-contents)
        (package-install pkgName)))
    (print "==> this package is already installed!!!")
  )

(defun fzl/install-list-of-packages (listOfPackages)
  (message "==> (defun install-list-of-packages (listOfPackages)...")
  (mapc 'fzl/install-package-if-not-installed  listOfPackages))
  
;  (setq package-load-list '(all))     ;; List of packages to load
;  (package-initialize)                ;; Initialize & Install Package

(defun fzl/print-all-installed-packages()
  (print package-activated-list))

(defun fzl/install-all-packages-from-list(pkglist)
  "PKGLIST is a list of packages. Install all packages if it is not installed yet."  
  )

(defun fzl/org-feed-config()
  "Configure org-feed-config. Code from:https://melpa.org/#/getting-started"

  (let* (
         (orgfeed-file-path (concat "/home/wagner/wagnerdocri3@gmail.com/envs/env-dev/sources/emacsinitfile" "/org-feeds")))

    (require 'package)    
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
    (package-initialize)
    ))
    
(provide 'fzl_utils_package)
  
;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Package-Installation.html
