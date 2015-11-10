(provide 'config_package_system)

;;http://ergoemacs.org/emacs/emacs_package_system.html
;;http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name

(message (concat (expand-file-name "./config_package_system.el") " --> loaded sucessfully"))

(when (>= emacs-major-version 24)
  (require 'package)

  (setq packages-to-be-installed-list '(org
                                        php-mode
					markdown-mode
					auto-complete
					flycheck
					gist
					magit
                                        yasnippet))
  

  ;;ANOTHER INTERESINTG PACKAGES
  ;;ac-slime auto-complet autopair clojure-mode clojure-test- coffee-mode
  ;;csharp-mode deft erlang feature-mode haml-mode
  ;;haskell-mode htmlize
  ;; magit markdown-mode marmalade nodejs-repl nrepl o-blog org paredit 
  ;;php-mode puppet-mode
  ;;restclient
  ;;rvm scala-mode
  ;;https://github.com/nonsequitur/smex smex
  ;;http://www.emacswiki.org/emacs/SMLMode sml-mode 
  ;;solarized-theme
  ;;http://web-mode.org/ web-mode
  ;;https://github.com/bnbeckwith/writegood-mode writegood-mode 
  ;;yaml-mode


  
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  ;:(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  ;;list the repositories containing them
  ;;("elpa" . "http://tromey.com/elpa/")
  
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("org" . "http://orgmode.org/elpa/")
			   ("melpa" . "http://melpa.milkbox.net/packages/")))


  (setq package-load-list '(all))     ;; List of packages to load
  (package-initialize)                ;; Initialize & Install Package

  
  
  (defun prelude-packages-installed-p ()
    (loop for p in packages-to-be-installed-list
	  when (not (package-installed-p p)) do (return nil)
	  finally (return t)))

  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p packages-to-be-installed-list)
      (when (not (package-installed-p p))
	(package-install p))))
  
  
  (unless package-archive-contents
    ;; Refresh the packages descriptions
    (package-refresh-contents))

  
  (unless (package-installed-p 'org)  ;; Make sure the Org package is
    (package-install 'org))
  
  );when
  ;(unless (package-installed-p 'org)  ;; Make sure the Org package is
   ; (package-install 'org))           ;; installed, install it if not







 ;(add-to-list 'package-archives
 ;	       '("melpa" . "http://melpa.org/packages/") t)

