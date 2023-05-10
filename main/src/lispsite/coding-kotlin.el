(use-package kotlin-mode
  :ensure t
  :mode "\\.kt\\'")

(use-package flycheck-kotlin
  :ensure t
  :after kotlin-mode
  :config
  (flycheck-kotlin-setup))

(provide 'coding-kotlin)

