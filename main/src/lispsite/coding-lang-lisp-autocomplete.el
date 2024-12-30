;; Configuração para Emacs Lisp (Elisp)
(use-package company
  :config
  (add-hook 'emacs-lisp-mode-hook 'company-mode))

;; Configuração para PHP
(use-package php-mode
  :mode ("\\.php\\'" . php-mode)
  :config
  (add-hook 'php-mode-hook 'company-mode))

;; Configuração para Java
(use-package lsp-java
  :config
  (add-hook 'java-mode-hook #'lsp))

;; Configuração para R
(use-package ess
  :mode ("\\.R\\'" . R-mode)
  :config
  (add-hook 'R-mode-hook 'company-mode))


(provide 'coding-lang-lisp-autocomplete)
