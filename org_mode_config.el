;;; package --- Summary
;;; Code:
;;; Commentary:

(provide 'org_mode_config)

;;Do not evaluate babel block codes during exportation process
;;each block codes needs be executed with C-c C-c before exportation
(setq org-export-babel-evaluate nil)

;;http://orgmode.org/worg/org-configs/org-customization-guide.html
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)


;;;;;;;;;;;;;;;;;;PUBLISHING;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;

;;;;;;;;;;;;;;;;;;BABEL;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;do not confirm when C-c C-c for code evaluation
(setq org-confirm-babel-evaluate nil)

;;BABEL LANGUAGES
;;http://orgmode.org/worg/org-contrib/babel/languages.html

;; active Babel languages
;; active Baral languages deps
;;(require 'ess_config);;needed for R language code blocks
;;(slime)  ;;slime is needed for lisp language code blocks
;;TODO:How to enable slime automatically for lisp blocks?
;;for now lets use emacs-lisp :)
(setq org-babel-python-command "python3") ;;needed for python3 interpreter

(require 'ob-python)
(require 'ob-lisp)
(require 'ob-shell)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t) ;;http://thread.gmane.org/gmane.emacs.orgmode/102877
   (python . t)
   (java . t)
   (ditaa . t)
   (R . t)
   (restclient . t)
   ))
;;   (ruby . t)

;;   (dot . t)
;;   (octave . t)
;;   (sqlite . t)
;;   (perl . t)

;;   (C . t)
;;   (awk . t)
;;   (js . t)
;;   (plantuml . t)
;;   (sql . t)
;;   (groovy . t)
;;   (browser . t)
;;   (http . t)
;;   (R . t)  ;; to wokrs, just delete ob-R.elc from your emacs.d ->  https://github.com/syl20bnr/spacemacs/issues/4618 in my case: rm ./elpa/org-20171009/ob-R.elc

;;(org-babel-do-load-languages
; 'org-babel-load-languages
; '(
;   
;  





;; USE ESC t to toggle toggle image view
(global-set-key (kbd "\et") 'org-toggle-iimage-in-org)


;;;;;;;;;;;;;;;;;;Default directories for notes and website;;;;;;;;;;;;;;;;;
;;http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
(setq org-directory (expand-file-name **ORG-DIRECTORY**))
(setq org-default-notes-file (concat org-directory "/default-org-notes.org"))

(setq org-agenda-files '((concat org-directory "todos.org")
                         (concat org-directory "events.org")
                         (concat org-directory "default-org-notes.org")))

;;;;;;;;;;;;;;;;;;IIMAGE;;;;;;;;;;;;;;;;;
;; add the org file link format to the iimage mode regex
;;(add-to-list 'iimage-mode-image-regex-alist
;;(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))
;;https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode
(setq org-image-actual-width nil) ;;Resize image with #+ATTR_ORG: :width 50

;; add a hook so we can display images on load
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))

;; function to setup images for display on load
(defun org-turn-on-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (turn-on-iimage-mode)
  (set-face-underline-p 'org-link nil))

;; function to toggle images in a org bugger
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  
  (call-interactively 'iimage-mode))

;; Easy Templates
;; https://emacs.stackexchange.com/questions/34651/how-can-i-create-custom-org-mode-templates
;; https://orgmode.org/manual/Easy-templates.html
(add-to-list 'org-structure-template-alist
             '("textSession" "* write tile here
                      #+BIND: org-export-use-babel nil
                      :PROPERTY:
                      :someAnotherProperty:"))	

(add-to-list 'org-structure-template-alist
             '("sR" "
   #+NAME:                     
   #+BEGIN_SRC R :session s1 :results output :exports both  
      #starts code
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sHTML" "
   #+NAME:                     
   #+BEGIN_SRC html :session s1 :results output :exports both  
      #starts code

   #+END_SRC

   #+NAME:
   #+BEGIN_EXPORT html
   
   #+END_EXPORT"
               ))	


(add-to-list 'org-structure-template-alist
             '("sRestclient" "
   #+NAME:    
   #+BEGIN_SRC restclient :session s1 :results output :exports both  
      #starts code
     POST --header 'Content-Type: application/json' 
     http://localhost:8081/service/rest/v1/script
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sShell" "
   #+NAME:                     
   #+BEGIN_SRC shell :session s1 :results output :exports both
      #starts code
   #+END_SRC"))	

(add-to-list 'org-structure-template-alist
             '("img" "
   #+NAME:figX                     
   #+CAPTION: figX
   #+attr_ORG: :width 500px
   #+attr_html: :width 500px
   #+attr_latex: :width 500px
   [[./imgs/XXX]]"))	



;;;;;;;;;;;;;;;;;;PHANTONJS;;;;;;;;;;;;;;;;;
;;babel browser phantom dependency
;;https://github.com/krisajenkins/ob-browser
;;(add-to-list 'exec-path "/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/envs/env-dev/sources/emacsinitfile/node_modules/")
;(setenv "PATH" (mapconcat 'identity exec-path ":"))


;;;SYNTAX HIGHLIGHTING IN ORG-BABEL
;;http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
;(setq org-confirm-babel-evaluate nil)
;(setq org-src-fontify-natively t)
;(setq org-src-tab-acts-natively t)
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((lisp . t)))
;; '(emacs-lisp . t)
;; '(R . t)
;; '(java .t)
; '(sh . t)
;; '(js . t)
;; '(css . t)
;; '(C++ . t)
;; '(clousure . t)
;; '(sqlite . t)
;; '(sed . t)))
;;(setq org-src-fontify-natively t)
;; (setq org-html-htmlize-output-type 'inline-css) ;; default
;;(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
;;(setq org-html-htmlize-font-prefix "org-")


;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
 ;;    ;(require 'ess-site)
;;     ;(require 'ob-R)

;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
;;     (require 'ess-site)
;;     ;(require 'ob11-R)

;;     ;(require 'ob-emacs-lisp)
;;     ;(require 'ob-latex)
;;     ;(require 'octave)
;;     ;(require 'ob-python)
;;     ;(require 'ob-sql)
;;     ;(require 'ob-shell)
     ;(require 'ob-sqlite)
     ;;(require 'ob-julia);"arquivo ou diretório não encontrado" "ob-julia")
     ;(require 'ob-perl)
     ;(require 'ob-org)
     ;(require 'ob-awk)
        ;(require 'ob-sed);(file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-sed")
     ;(require 'ob-css)
     ;(require 'ob-js)
        ;(require 'ob-stata); (file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-stata")
;;     (setq org-export-babel-evaluate nil)
;;     (setq org-startup-indented t)
;;     ;; increase imenu depth to include third level headings
;;     (setq org-imenu-depth 3)
;;     ;; Set sensible mode for editing dot files
;;     (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
     ;; Update images from babel code blocks automatically
;;     (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;;     (setq org-src-fontify-natively t)
;;     (setq org-src-tab-acts-natively t)

;;     (setq org-confirm-babel-evaluate nil)))


;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;(require 'org-latex)
;(unless (boundp 'org-export-latex-classes)
;  (setq org-export-latex-classes nil))
;(add-to-list 'org-export-latex-classes
;             '("article"
;               "\\documentclass{book}"
;               ("\\section{%s}" . "\\section*{%s}")))  




;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;;(require 'org-latex)
;;(unless (boundp 'org-export-latex-classes)
;;  (setq org-export-latex-classes nil))
;;(add-to-list 'org-export-latex-classes
;;             '("article"
;;               "\\documentclass{book}"
;;               ("\\section{%s}" . "\\section*{%s}")))  


;;http://orgmode.org/worg/dev/org-export-reference.html
;;http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-LaTeX.html
;;(setq exec-path (append exec-path '("/usr/tex")))
;;TODO (load "auctex.el" nil t t)
;;TODO (add-hook 'LaTeX-mode-hook 'turn-on-reftex)



;;;LaTeX Export for Org Mode < 8.0
;;;http://orgmode.org/worg/org-tutorials/org-latex-export.html
;(require 'ox-latex)
;(unless (boundp 'org-latex-classes)
;  (setq org-latex-classes nil))
;(add-to-list 'org-latex-classes
;             '("article"
;               "\\documentclass{article}"
;               ("\\section{%s}" . "\\section*{%s}")))

;(add-to-list 'org-latex-classes
;          '("abntex2"
;            "\\documentclass{abntex2}"
;
;
;            "\\usepackage{lmodern}"
;            "\\usepackage[T1]{fontenc}"
;            "\\usepackage[utf8]{inputenc}"
;            "\\usepackage{indentfirst}"
;            "\\usepackage{nomencl}"
;            "\\usepackage{color}"
;            "\\usepackage{graphicx}"
;            "\\usepackage{microtype}"
;            
;            ("\\section{%s}" . "\\section*{%s}")
;            ("\\subsection{%s}" . "\\subsection*{%s}")
;            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;            ("\\paragraph{%s}" . "\\paragraph*{%s}")
;            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")));
;
;

;;CONFIG ORG-MODE/CONTRIB BY GIT REPO
;;http://orgmode.org/manual/Installation.html

