;;; package --- Summary

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

;;y a s n i p p e t
;https://github.com/capitaomorte/yasnippet
;http://capitaomorte.github.io/yasnippet/snippet-reference.html
;https://github.com/jney/yasnippet/blob/master/doc/snippet-organization.rst
;http://capitaomorte.github.com/yasnippet/snippet-organization.html#loading-snippets
;https://github.com/jney/yasnippet-js-mode
;;https://www.emacswiki.org/emacs/Yasnippet
;;https://www.emacswiki.org/emacs/yasnippet-config.el
;;https://joaotavora.github.io/yasnippet/snippet-development.html

;; Completing point by some yasnippet key

;;; Comentary:
;;; Code:
(fzl/log " ### yasnippet_config.el loaded sucessfully!!!")

(require 'yasnippet)

;;https://www.emacswiki.org/emacs/Yasnippet
;;https://joaotavora.github.io/yasnippet/
;;https://joaotavora.github.io/yasnippet/snippet-expansion.html
;;https://joaotavora.github.io/yasnippet/snippet-organization.html

;;https://joaotavora.github.io/yasnippet/snippet-organization.html
;; OR, keeping YASnippet defaults try out ~/Downloads/interesting-snippets
;;(setq yas-snippet-dirs "./snippets")

;;yas-load-directory
;;(add-hook 'python-mode-hook '(lambda ()
;;                               (yas-minor-mode)))

;; Develop and keep personal snippets under ~/emacs.d/mysnippets
;(setq yas/root-directory *fzl_emacs_yasnippets_snippets*)

;; Load the snippets
;(yas/load-directory yas/root-directory)
;(setq yas/root-directory '(
;;*fzl_emacs_yasnippets_snippets*))


;; Let's have snippets in the auto-complete dropdown
;;(add-to-list 'ac-sources 'ac-source-yasnippet)

;; Load the snippets
;(mapc 'yas/load-directory yas/root-directory)
;;(mapc 'yas/load-directory yas-snippet-dirs)


;;https://github.com/joaotavora/yasnippet
;;Use yas-minor-mode on a per-buffer basis
;;To use YASnippet as a non-global minor mode, don't call yas-global-mode;
;;instead call yas-reload-all to load the snippet tables and then call yas-minor-mode
;;from the hooks of major-modes where you want YASnippet enabled.
;;(yas-reload-all)
;;(add-hook 'prog-mode-hook #'yas-minor-mode)


(yas-global-mode 1)

(yas/initialize)
(provide 'yasnippet_config)
;;; yasnippet_config.el ends here
