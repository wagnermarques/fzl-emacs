(provide 'org_mode_config)
(require 'org_mode_export_odt_styles)
(require 'ob-sh)

;;http://ebib.sourceforge.net/manual/ebib-manual.html#orgmode-and-markdown
;(org-add-link-type "ebib" 'ebib)

;https://lists.gnu.org/archive/html/emacs-orgmode/2012-08/msg01402.html
;(setq org-image-actual-width '(400))

;;CONFIGURING ORG-MODE
;;https://email.esm.psu.edu/pipermail/macosx-emacs/2011-October/003027.html
;; Conventional selection/deletion
;(setq org-support-shift-select t)

; thanks to PT (org-mode list)
;;(defun my-org-mode-stuff ()
;;  "define selection by keyboard similar to Mac and Windows"
;;  (require 'pc-select)
;;  (local-set-key (kbd "C-S-<right>") 'forward-word)
;;  (local-set-key (kbd "C-S-<left>") 'backward-word)
;;  (local-set-key (kbd "S-<right>") 'forward-char)
;;  (local-set-key (kbd "S-<left>") 'backward-char)
;;  (local-set-key (kbd "S-<up>") 'previous-line)
;;  (local-set-key (kbd "S-<down>") 'next-line))

;;(add-hook 'org-mode-hook 'my-org-mode-stuff)





;http://floatsolutions.com/blog/2010/10/displaying-inline-images-in-emacs-org-mode/
;; -- Display images in org mode
;; enable image mode first
(iimage-mode)
;; USE ESC t to toggle toggle image view
(global-set-key (kbd "\et") 'org-toggle-iimage-in-org)

;; add the org file link format to the iimage mode regex
(add-to-list 'iimage-mode-image-regex-alist
(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))

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


;;;;14 Working with source code
;;#+BEGIN_SRC emacs-lisp
;;(+ 1 2 3 4)
;;#+END_SRC
;;Use C-c C-c to evaluate the current code block and insert its results in the Org-mode buffer

;;;;http://orgmode.org/guide/Working-With-Source-Code.html
;;;;http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-lisp.html
;;(require 'ess-site) ;;for R
(require 'ob-sh)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   ))

;;;SYNTAX HIGHLIGHTING IN ORG-BABEL
;;http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((lisp . t)\
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

 (eval-after-load 'org
   (lambda()
;;     ;(require 'ob-tangle)
     (require 'ess-site)
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
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{book}"
               ("\\section{%s}" . "\\section*{%s}")))  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;PUBLISHING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


     (setq org-confirm-babel-evaluate nil)))


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
(setq exec-path (append exec-path '("/usr/tex")))
;;TODO (load "auctex.el" nil t t)
;;TODO (add-hook 'LaTeX-mode-hook 'turn-on-reftex)



;;;LaTeX Export for Org Mode < 8.0
;;;http://orgmode.org/worg/org-tutorials/org-latex-export.html
(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))

(add-to-list 'org-latex-classes
          '("abntex2"
            "\\documentclass{abntex2}"


            "\\usepackage{lmodern}"
            "\\usepackage[T1]{fontenc}"
            "\\usepackage[utf8]{inputenc}"
            "\\usepackage{indentfirst}"
            "\\usepackage{nomencl}"
            "\\usepackage{color}"
            "\\usepackage{graphicx}"
            "\\usepackage{microtype}"
            
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



;;CONFIG ORG-MODE/CONTRIB BY GIT REPO
;;http://orgmode.org/manual/Installation.html

