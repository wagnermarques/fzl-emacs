;;; Code:

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))



(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode t))

(use-package yasnippet-snippets
  :ensure t)



(provide 'autocomplete)

