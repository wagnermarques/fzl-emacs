;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-


;;http://ergoemacs.org/emacs/emacs_package_system.html
;;http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
;;(fzl/log (concat (expand-file-name "./config_package_system.el") " --> loaded sucessfully"))
(require 'fzl_utils_package)

(setq packages-to-be-installed-list '(;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      ;;;;;;;;;; NON PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      use-package
                                      ;helm
                                      
                                      ;;;https://github.com/politza/pdf-tools
                                      ;;;Support library for PDF documents.
                                      ;;;Issue M-x pdf-tools-install RET once
                                      ;;pdf-tools
                                      
                                      ;;helm-firefox
                                      
                                      ;;company-restclient ;20151202.1201 available  melpa      company-mode completion back-end for restclient-mode

                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      ;;;;;;;;;;:::::::       ORG-MODE      ;;;;;;;;;;;;;;;;
                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      ;;https://github.com/krisajenkins/ob-browser
                                      ob-browser

                                      ;;ob-restclient      ;20180904.709  available  melpa      org-babel functions for restclient-mode
                                      ;;restclient         ;20190122.942  available  melpa      An interactive HTTP client for Emacs
                                      ;;restclient-test    ;20180106.2046 available  melpa      Run tests with restclient.el
                                      ;;org
                                      ;;org-ref                                        
                                      ;;org-plus-contrib

                                      ;;https://github.com/zweifisch/ob-http
                                      ob-http

                                      ;;https://github.com/krisajenkins/ob-translate/blob/master/ob-translate.el
                                      ;;ob-translate

                                      ob-restclient

                                      ;;ox-twbs

                                      
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;    DEALING WITH FILES      ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ;;Dealing with files
                                        ;elpy depends on find-file-in-project
                                        ;https://melpa.org/#/find-file-in-project
                                        ;find-file-in-project ;20170531.2054 dependency            Find file/directory and review Diff/Patch/Commit efficiently everywhere

                                        ;https://www.youtube.com/watch?v=AfZX39jd6cw
                                        ;https://www.youtube.com/watch?v=lsgPNVIMkIE
                                        ;ido
                                        ;elpy depends on idomenu

                                        ;using helm wihtou ido
                                        ;idomenu ;20141123.1320 available  melpa      imenu tag selection a la ido

                                        ;https://github.com/auto-complete/popup-el
                                        ;elpy depends on popup
                                        

                                        ;https://github.com/skeeto/emacs-web-server
                                        ;elpy dependes on it and many others
                                        ;TODO: define config_simple-httpd.el file
                                        simple-httpd       ;20170125.1910 dependency            pure elisp HTTP server
                                        
                                        ;https://www.youtube.com/watch?v=jNa3axo40qM
                                        ;https://www.emacswiki.org/emacs/Iedit
                                        ;C- and corespondently multimple selections will take place. edit and all will be edited too. C- to finish
                                        ;elpy depends on iedit
                                        ;iedit ;multiple-cursors
                                                                                
                                        ;feed reader
                                        ;elfeed
                                        ;elfeed-org
                                        ;elfeed-goodies     ;20160926.209  available  melpa      Elfeed goodies
                                        ;elfeed-org         ;20160814.314  available  melpa      Configure elfeed with one or more org-mode files
                                        ;elfeed-web         ;1.1.0         available  marmalade  web interface to Elfeed
                                        ;elfeed-web         ;20160904.1131 available  melpa      web interface to Elfeed
                                        

                                        
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;          D A T A B A S E         ;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;esqlite            ;20151206.406  available  melpa      Manipulate sqlite file from Emacs
                                        ;esqlite-helm       ;20151116.50   available  melpa      Define helm source for sqlite database


                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; BASIC PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        popup               ;20160709.729  dependency            Visual Popup User Interface
                                        ac-helm                        ;20160319.233  available  melpa      Helm interface for auto-complete
                                        ;cedet              ;2.0           built-in   Setup CEDET environment
                                        ;eieio              ;1.4           built-in   Enhanced Implementation of Emacs Interpreted Objects
                                        ;eieio-core         ;1.4           built-in   Core implementation for eieio
                                        ;ede                ;1.2           built-in   Emacs Development Environment gloss
                                        magit                              ;markdown-mode marmalade nodejs-repl nrepl o-blog org paredit
                                        
                                        ;slime                            ;20170828.451  available  melpa      Superior Lisp Interaction Mode for Emacs
                                        auto-complete
                                        
                                        ;;https://github.com/mooz/auto-complete-c-headers
                                        auto-complete-c-headers

                                        yasnippet
                                        yatemplate         ;20161108.1305 available  melpa      File templates with yasnippet
                                        java-snippets      ;20160626.1952 installed             Yasnippets for Java
                                        angular-snippets   ;20140513.2223 available  melpa      Yasnippets for AngularJS
                                        auto-yasnippet     ;20160925.225  available  melpa      Quickly create disposable yasnippets
                                        clojure-snippets   ;20161024.16   available  melpa      Yasnippets for clojure
                                        common-lisp-snippets ;20161231.1557 available  melpa      Yasnippets for Common Lisp
                                        java-snippets
                                        el-autoyas         ;20120918.617  available  melpa      Automatically create Emacs-Lisp Yasnippets
                                        
                                        flycheck           ;20190425.816  available  melpa      On-the-fly syntax checking
                                        flycheck-tip       ;20171020.1048 available  melpa      Show flycheck/flymake errors by tooltip
                                        flycheck-popup-tip ;20170812.2351 available  melpa      Display Flycheck error messages using popup.el

                                        flycheck-yamllint  ;20170325.1735 available  melpa      Flycheck integration for YAMLLint
                                        
                                        ;flycheck-cask      ;20160928.926  available  melpa      Cask support in Flycheck
                                        
                                        flycheck-clang-analyzer ;20180917.1425 available  melpa      Integrate Clang Analyzer with flycheck
                                        flycheck-clang-tidy ;20171024.808  available  melpa      Flycheck syntax checker using clang-tidy
                                        flycheck-clangcheck ;20150712.710  available  melpa      A Flycheck checker difinition for ClangCheck.
                                        ;flycheck-clj-kondo ;20190410.1515 available  melpa      Add clj-kondo linter to flycheck
                                        ;flycheck-clojure   ;20180721.1412 available  melpa      Flycheck: Clojure support
                                        flycheck-color-mode-line ;20171122.707  available  melpa      Change mode line color with Flycheck status
                                        
                                        flycheck-css-colorguard ;20161031.1122 available  melpa      Detect similar colors in CSS
                                        flycheck-cstyle    ;20160905.2341 available  melpa      Integrate cstyle with flycheck
                                        
                                        flycheck-gradle    ;20190315.234  available  melpa      Flycheck extension for Gradle.
                                        ;flycheck-inline    ;20190320.1611 available  melpa      Display Flycheck errors inline
                                        ;flycheck-irony     ;20180604.2152 available  melpa      Flycheck: C/C++ support via Irony
                                        ;flycheck-joker     ;20180913.504  available  melpa      Add Clojure syntax checker (via Joker) to flycheck
                                        flycheck-kotlin    ;20170122.1137 available  melpa      Support kotlin in flycheck

                                        ;;https://github.com/purcell/package-lint
                                        flycheck-package   ;20161111.2251 available  melpa      A Flycheck checker for elisp package authors
                                        ;flycheck-phpstan   ;20190227.1642 available  melpa      Flycheck integration for PHPStan
                                        
                                        ;flycheck-pos-tip   ;20180610.1615 available  melpa      Display Flycheck errors in GUI tooltips
                                        ;flycheck-pycheckers ;20190409.2335 available  melpa      multiple syntax checker for Python, using Flycheck
                                        ;flycheck-pyflakes  ;20170330.2311 available  melpa      Support pyflakes in flycheck
                                        ;flycheck-pyre      ;20190215.1222 available  melpa      Support Pyre in flycheck
                                        
                                        ;flycheck-rtags     ;20180619.824  available  melpa      RTags Flycheck integration.
                                        ;flycheck-soar      ;20181106.852  available  melpa      Analyze the SQL statements using mi soar.
                                        
                                        
                                        ;flycheck-title     ;20170216.2346 available  melpa      show flycheck errors in the frame title
                                        
                                        
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; HTML PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;elpy depends on this htmlize package
                                        ;https://melpa.org/#/htmlize
                                        ;TODO: Opens htmlized file in html buffer for C-c C-v usage
                                        ;htmlize ;           20161211.1019 available  melpa      Convert buffer text and decorations to HTML.

                                        impatient-mode     ;20200723.2117 available  melpa      Serve buffers live over HTTP
                                        ;https://melpa.org/#/impatient-mode
                                        ;https://www.youtube.com/watch?v=mnfPRLlsXqU
                                        ;https://www.youtube.com/watch?v=QV6XVyXjBO8&feature=youtu.be
                                        ;elpy depends on impatient-mode
                                        ;TODO: start httpd whenerve a html file is visited
                                        ;impatient-mode     ;20170505.1921 available  melpa      Serve buffers live over HTTP
                                        
                                        
					;cl-generic         ;        1.0           built-in   CLOS-style generic functions for Elisp
					;cl-lib             ;            1.0           built-in   Common Lisp extensions for Emacs
                                        
					
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; PYTHON PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        elpy                                ;20200329.1830 available  melpa      Emacs Python Development Environment
                                        ;ac-python             ;         20110519      available  marmalade  Simple Python Completion Source for Auto-Complete
                                        
                                        ;https://github.com/jorgenschaefer/pyvenv
                                        ;pyvenv             ;20170826.812  available  melpa      Python virtual environment interface
                                        ;fuzzy              ;20150729.2037 available  melpa      Fuzzy Matching
                                        ;highlight-indent-guides ;20170531.2054 dependency            Find file/directory and review Diff/Patch/Commit efficiently everywhere
                                        ;nose               ;20140520.948  available  melpa      Easy Python test running in Emacs
                                        

                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; TYPESCRIPT PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                        
                                        ;tide               ;20170303.1211 available  melpa      Typescript Interactive Development Environment
                                        ;ob-typescript      ;20150804.530  available  melpa      org-babel functions for typescript evaluation
                                        ;typescript-mode    ;20161130.1944 installed             Major mode for editing typescript
                                        ;tss                ;20150913.708  available  melpa      provide a interface for auto-complete.el/flymake.el on typescript-mode.
                                        
                                        ;https://github.com/josteink/ts-comint
                                        ;20161006.1034 available  melpa      Run a Typescript interpreter in an inferior process windowx.
                                        ;ts-comint
                                        


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

                                        ;ac-php ;            20190424.222  available  melpa      Auto Completion source for PHP.
                                        ;ac-php-core ;       20190424.1017 available  melpa      The core library of the ac-php.
					;company-php        ;20190424.222  available  melpa      A company back-end for PHP.
					;company-phpactor   ;20190403.216  available  melpa      company-mode backend for Phpactor
					;flycheck-phpstan   ;20190227.1642 available  melpa      Flycheck integration for PHPStan
  

                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;               P H P        ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        php-mode


                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; ARDUINO PROGRAMMING PACKAGES   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;arduino-mode        ;      20180509.36   available  melpa      Major mode for editing Arduino code.
                                        ;company-arduino     ;   20160306.1739 available  melpa      company-mode for Arduino
                                        
                                        ;rtags                             ;20190410.1615 dependency            A front-end for rtags
					  
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;; J A V A / Kotlin / Groovy / Gradle                   ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;eclim
                                        ;company-emacs-eclim
                                        ;ac-emacs-eclim
                                        groovy-mode                  ;20191031.2256 available  melpa      Major mode for Groovy source files
                                        gradle-mode                  ;20150313.1905 available  melpa      Gradle integration with Emacs' compile
                                        ;kotlin-mode

                                        
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;             DOCKER         ;;;;;;;;;;;;;;;;
                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        docker                 ;20191222.939  available  melpa      Emacs interface to Docker

                                        ;;https://github.com/Silex/docker-api.el
                                        docker-api             ;20160525.720  available  melpa      Emacs interface to the Docker API

                                        ;;https://stackoverflow.com/questions/16840409/how-to-list-containers-in-docker
                                        ;;https://stackoverflow.com/questions/27083182/running-emacs-in-a-docker-container
                                        ;;https://stackoverflow.com/questions/27083182/running-emacs-in-a-docker-container?noredirect=1
                                        ;;https://stackoverflow.com/questions/57081352/docker-command-line-to-switch-to-running-linux-containers-on-windows-core-machin
                                        ;;https://dev.to/bosko/docker-cli-emacs-package-53e7
                                        ;;https://www.aquasec.com/wiki/display/containers/Docker+CLI+Commands
                                        docker-cli             ;20190524.1624 available  melpa      Running various commands in docker containers

                                        ;;https://github.com/meqif/docker-compose-mode
                                        docker-compose-mode    ;20180324.1752 available  melpa      Major mode for editing docker-compose files

                                        ;;https://github.com/emacs-pe/docker-tramp.el
                                        docker-tramp           ;20170207.325  available  melpa      TRAMP integration for docker containers
                                        dockerfile-mode
					yaml-mode
					;soap-client ;https://github.com/alex-hhh/emacs-soap-client

                                        ;markdown-mode
                                        ;gist
                                        ))

(fzl/install-list-of-packages packages-to-be-installed-list)
  
  ;;ANOTHER INTERESINTG PACKAGES
  ;;ac-slime auto-complet autopair clojure-mode clojure-test- coffee-mode
  ;;csharp-mode deft erlang feature-mode haml-mode
  ;;haskell-mode htmlize

  ;;php-mode puppet-mode
  ;;restclient
  ;;rvm scala-mode
  ;;https://github.com/nonsequitur/smex smex
  ;;http://www.emacswiki.org/emacs/SMLMode sml-mode 
  ;;solarized-theme
  ;;http://web-mode.org/ web-mode
  ;;https://github.com/bnbeckwith/writegood-mode writegood-mode 
  


  
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  ;:(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  ;;list the repositories containing them
  ;;("elpa" . "http://tromey.com/elpa/")
  

;;  (setq package-load-list '(all))     ;; List of packages to load
;;  (package-initialize)                ;; Initialize & Install Package

  
  
;;  (defun prelude-packages-installed-p ()
;;    (cl-loop for p in packages-to-be-installed-list
;;	  when (not (package-installed-p p)) do (return nil)
;;	  finally (return t)))

;  (defun prelude-packages-installed-p()
;    (setq pkgsList packages-to-be-installed-list)
;    (while pkgsList
;      (message (car pkgsList))))
  
;  (prelude-packages-installed-p)
  
;  (unless (prelude-packages-installed-p)
;    (message "%s" "Emacs Prelude is now refreshing its package database...")
;    (package-refresh-contents)
;    (message "%s" " done.")
;    ;; install the missing packages
;    (dolist (p packages-to-be-installed-list)
;      (when (not (package-installed-p p));
;	(package-install p))))
  
  
;  (unless package-archive-contents
    ;; Refresh the packages descriptions
;    (package-refresh-contents))

  
;  (unless (package-installed-p 'org)  ;; Make sure the Org package is
;    (package-install 'org))
  
;  );when
  ;(unless (package-installed-p 'org)  ;; Make sure the Org package is
   ; (package-install 'org))           ;; installed, install it if not







 ;(add-to-list 'package-archives
 ;	       '("melpa" . "http://melpa.org/packages/") t)

(provide 'config_package_system)
