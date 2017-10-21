(provide 'config_package_system)

;;http://ergoemacs.org/emacs/emacs_package_system.html
;;http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name

;;(log (concat (expand-file-name "./config_package_system.el") " --> loaded sucessfully"))

(when (>= emacs-major-version 24)
  (require 'package)

  (setq packages-to-be-installed-list '(;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; NON PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;    DEALING WITH FILES      ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ;;Dealing with files
                                        ;elpy depends on find-file-in-project
                                        ;https://melpa.org/#/find-file-in-project
                                        find-file-in-project ;20170531.2054 dependency            Find file/directory and review Diff/Patch/Commit efficiently everywhere

                                        ;https://www.youtube.com/watch?v=AfZX39jd6cw
                                        ;https://www.youtube.com/watch?v=lsgPNVIMkIE
                                        ;ido
                                        ;elpy depends on idomenu
                                        idomenu ;20141123.1320 available  melpa      imenu tag selection a la ido


                                        ;https://github.com/auto-complete/popup-el
                                        ;elpy depends on popup
                                        popup ;             20160709.729  dependency            Visual Popup User Interface

                                        ;https://github.com/skeeto/emacs-web-server
                                        ;elpy dependes on it and many others
                                        ;TODO: define config_simple-httpd.el file
                                        ;simple-httpd       ;20170125.1910 dependency            pure elisp HTTP server
                                        
                                        ;https://www.youtube.com/watch?v=jNa3axo40qM
                                        ;https://www.emacswiki.org/emacs/Iedit
                                        ;C- and corespondently multimple selections will take place. edit and all will be edited too. C- to finish
                                        ;elpy depends on iedit
                                        iedit ;multiple-cursors
                                                                                
                                        ;feed reader
                                        elfeed
                                        elfeed-org
                                        elfeed-goodies     ;20160926.209  available  melpa      Elfeed goodies
                                        elfeed-org         ;20160814.314  available  melpa      Configure elfeed with one or more org-mode files
                                        elfeed-web         ;1.1.0         available  marmalade  web interface to Elfeed
                                        elfeed-web         ;20160904.1131 available  melpa      web interface to Elfeed
                                        
                                        ;the greate org-mode
                                        org
                                        ;org-plus-contrib
                                        ;;https://github.com/krisajenkins/ob-browser
                                        ob-browser
                                        ;;https://github.com/zweifisch/ob-http
                                        ob-http
                                        ;;https://github.com/krisajenkins/ob-translate/blob/master/ob-translate.el
                                        ob-translate

                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; BASIC PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;cedet              ;2.0           built-in   Setup CEDET environment
                                        ;eieio              ;1.4           built-in   Enhanced Implementation of Emacs Interpreted Objects
                                        ;eieio-core         ;1.4           built-in   Core implementation for eieio
                                        ;ede                ;1.2           built-in   Emacs Development Environment gloss
                                        slime                            ;20170828.451  available  melpa      Superior Lisp Interaction Mode for Emacs
                                        auto-complete
                                        
                                        ;;https://github.com/mooz/auto-complete-c-headers
                                        auto-complete-c-headers

                                        yasnippet
                                        
                                        ;;[f3] 'flymake-display-err-menu-for-current-line)
                                        ;;[f4] 'flymake-goto-next-error)
                                        flycheck


                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; HTML PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;elpy depends on this htmlize package
                                        ;https://melpa.org/#/htmlize
                                        ;TODO: Opens htmlized file in html buffer for C-c C-v usage
                                        htmlize ;           20161211.1019 available  melpa      Convert buffer text and decorations to HTML.

                                        ;impatient-mode
                                        ;https://melpa.org/#/impatient-mode
                                        ;https://www.youtube.com/watch?v=mnfPRLlsXqU
                                        ;https://www.youtube.com/watch?v=QV6XVyXjBO8&feature=youtu.be
                                        ;elpy depends on impatient-mode
                                        ;TODO: start httpd whenerve a html file is visited
                                        impatient-mode     ;20170505.1921 available  melpa      Serve buffers live over HTTP
                                        
                                        
					;cl-generic         ;        1.0           built-in   CLOS-style generic functions for Elisp
					;cl-lib             ;            1.0           built-in   Common Lisp extensions for Emacs
                                        
					

                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; PYTHON PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;https://github.com/jorgenschaefer/pyvenv
                                        pyvenv             ;20170826.812  available  melpa      Python virtual environment interface
                                        elpy
                                        fuzzy              ;20150729.2037 available  melpa      Fuzzy Matching
                                        highlight-indent-guides ;20170531.2054 dependency            Find file/directory and review Diff/Patch/Commit efficiently everywhere
                                        nose               ;20140520.948  available  melpa      Easy Python test running in Emacs
                                        

                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; TYPESCRIPT PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                        
                                        tide               ;20170303.1211 available  melpa      Typescript Interactive Development Environment
                                        ob-typescript      ;20150804.530  available  melpa      org-babel functions for typescript evaluation
                                        typescript-mode    ;20161130.1944 installed             Major mode for editing typescript
                                        tss                ;20150913.708  available  melpa      provide a interface for auto-complete.el/flymake.el on typescript-mode.
                                        
                                        ;https://github.com/josteink/ts-comint
                                        ;20161006.1034 available  melpa      Run a Typescript interpreter in an inferior process windowx.
                                        ;ts-comint          
                                        


                                        ;esqlite            ;20151206.406  available  melpa      Manipulate sqlite file from Emacs
                                        ;esqlite-helm       ;20151116.50   available  melpa      Define helm source for sqlite database
                                        ;eslint-fix         ;20160819.36   available  melpa      Fix JavaScript files using ESLint
                                        ;ess                ;20170118.232  available  melpa      Emacs Speaks Statistics
                                        ;ess-R-data-view    ;20130509.458  available  melpa      Data viewer for GNU R
                                        ;ess-R-object-popup ;20130302.336  available  melpa      popup description of R object
                                        ;ess-smart-equals   ;20150201.2201 available  melpa      better smart-assignment with =-key in R and S
                                        ;ess-view           ;20160309.1315 available  melpa      View R dataframes in a spreadsheet software
                                        ;auctex
                                        ;ebib
                                        ;org-ref
                                        ;org-plus-contrib
                                        ;reftex
                                        ;php-mode
                                        ;markdown-mode

                                        
                                        ;gist

                                        ;el-autoyas         ;20120918.617  available  melpa      Automatically create Emacs-Lisp Yasnippets
                                        ;yatemplate         ;20161108.1305 available  melpa      File templates with yasnippet
                                        ;java-snippets      ;20160626.1952 installed             Yasnippets for Java
                                        ;angular-snippets   ;20140513.2223 available  melpa      Yasnippets for AngularJS
                                        ;auto-yasnippet     ;20160925.225  available  melpa      Quickly create disposable yasnippets
                                        ;clojure-snippets   ;20161024.16   available  melpa      Yasnippets for clojure
                                        ;common-lisp-snippets ;20161231.1557 available  melpa      Yasnippets for Common Lisp
                                        ;java-snippets
                                        ;eclim
                                        ;ac-emacs-eclim
                                        ;company-emacs-eclim
                                        ;company
                                        ))
  

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
			   ;("marmalade" . "http://marmalade-repo.org/packages/")
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

