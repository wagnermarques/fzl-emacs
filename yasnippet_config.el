;y a s n i p p e t
;https://github.com/capitaomorte/yasnippet
;http://capitaomorte.github.io/yasnippet/snippet-reference.html
;https://github.com/jney/yasnippet/blob/master/doc/snippet-organization.rst
;http://capitaomorte.github.com/yasnippet/snippet-organization.html#loading-snippets


(require 'yasnippet)
(yas-global-mode 1)

;; Load the snippets
;(yas/load-directory yas/root-directory)

;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;(setq yas/root-directory (concat *FZL_HOME* "/etc/emacs/yasnippets_defined_for_fzlbpms"))


(setq yas/root-directory '("~/.emacs.d/snippets"
			   (concat *FZL_HOME* "/etc/emacs/yasnippets_defined_for_fzlbpms")
			   "/home/wagner/dev_env/svtbpms-apps/etc/emacs/sitelisp/emacsinitfile/svt-yasnippets"
			   "/home/wagner/dev_env/svtbpms-apps/etc/emacs/sitelisp/checkouts/jney_yasnippet/snippets"))

;(add-to-list 'yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/emacsinitfile/svt-yasnippets"))
;(add-to-list 'yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/checkouts/jney_yasnippet/snippets"))



(mapc 'yas/load-directory yas/root-directory)
; Load the snippets

;(setq yas/root-directory (concat *SVT_HOME* "etc/emacs/sitelisp/checkouts/jney_yasnippet/snippets")
;(yas/load-directory yas/root-directory)
;;(yas/load-directory "~/.emacs.d/plugins/yas/snippets")
;(yas/load-directory yas/root-directory)



(provide 'yasnippet_config)
