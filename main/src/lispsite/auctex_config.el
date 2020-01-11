;;; package --- Summary
;;; Commentary:
;;; https://piotr.is/2010/emacs-as-the-ultimate-latex-editor/
;;; https://gist.github.com/pkazmierczak/4331666
;;; https://www.gnu.org/software/auctex/manual/auctex/Installation.html#Installation
;;;https://piotr.is/2010/emacs-as-the-ultimate-latex-editor/
;;; Code:

(require 'flymake) ;;; maybe its still not load, so lets require

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
                                        
(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)

; could be ispell as well, depending on your preferences
(setq ispell-program-name "aspell") 
; this can obviously be set to any language your spell-checking program supports
(setq ispell-dictionary "english") 

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)


(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else


(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"/usr/share/emacs21/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))
load "auctex.el" nil t t)

(provide 'auctex_config)

;;; auctex_config.el ends here
