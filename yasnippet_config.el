;y a s n i p p e t
;https://github.com/capitaomorte/yasnippet
;http://capitaomorte.github.io/yasnippet/snippet-reference.html
;https://github.com/jney/yasnippet/blob/master/doc/snippet-organization.rst
;http://capitaomorte.github.com/yasnippet/snippet-organization.html#loading-snippets
;https://github.com/jney/yasnippet-js-mode


(provide 'yasnippet_config)


(yas-global-mode 1)

;; Load the snippets
;(yas/load-directory yas/root-directory)

;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;(setq yas/root-directory (concat *FZL_HOME* "/etc/emacs/yasnippets_defined_for_fzlbpms"))

(message (concat *fzl_dot_emacs_dir* "/snippets"))

(setq dot_emacs_yasnippets_snippets (format "%s" (concat *fzl_dot_emacs_dir* "/snippets")))
(setq fzlbpms_yasnippets_snippets (format "%s" (concat *fzl_emacs_config_dir* "/yasnippets_defined_for_fzlbpms")))
(setq checkouts_yasnippet_js_mode (format "%s" (concat *fzl_emacs_config_dir* "/checkouts/yasnippet-js-mode")))

(setq yas/root-directory '(
                           "/home/administrador/fzlbpms/fzlbpms/etc/emacs/lisp/yasnippets_snippets"
                           "/home/administrador/fzlbpms/fzlbpms/etc/emacs/yasnippets_defined_for_fzlbpms"
                           "/home/administrador/fzlbpms/fzlbpms/etc/emacs/checkouts/yasnippet-js-mode"))

;;https://github.com/jney/yasnippet-js-mode.git    
;;(add-to-list 'yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/emacsinitfile/svt-yasnippets"))
;;(add-to-list 'yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/checkouts/jney_yasnippet/snippets"))


(mapc 'yas/load-directory yas/root-directory)
; Load the snippets

;(setq yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/checkouts/jney_yasnippet/snippets")
;(yas/load-directory yas/root-directory)
;;(yas/load-directory "~/.emacs.d/plugins/yas/snippets")
;(yas/load-directory yas/root-directory)



;; Let's have snippets in the auto-complete dropdown
;(add-to-list 'ac-sources 'ac-source-yasnippet)

(require 'yasnippet)

