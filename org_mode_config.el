(provide 'org_mode_config)

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
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)))

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
(require 'org-latex)
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


