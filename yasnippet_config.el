;;y a s n i p p e t
;https://github.com/capitaomorte/yasnippet
;http://capitaomorte.github.io/yasnippet/snippet-reference.html
;https://github.com/jney/yasnippet/blob/master/doc/snippet-organization.rst
;http://capitaomorte.github.com/yasnippet/snippet-organization.html#loading-snippets
;https://github.com/jney/yasnippet-js-mode
;;https://www.emacswiki.org/emacs/Yasnippet
;;https://www.emacswiki.org/emacs/yasnippet-config.el
;;
;;https://joaotavora.github.io/yasnippet/snippet-development.html

;; Completing point by some yasnippet key

;;; Comentary:
;;; Code:
(fzl/log "yasnippet_config.el loaded sucessfully!!!")






;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;(setq yas/root-directory *fzl_emacs_yasnippets_snippets*)

;; Load the snippets
;(yas/load-directory yas/root-directory)


;(setq yas/root-directory '(


;;*fzl_emacs_yasnippets_snippets*))


;;(mapc 'yas/load-directory yas/root-directory)
; Load the snippets

;; Let's have snippets in the auto-complete dropdown
;(add-to-list 'ac-sources 'ac-source-yasnippet)

(yas-global-mode 1)

(require 'yasnippet)
(provide 'yasnippet_config)
