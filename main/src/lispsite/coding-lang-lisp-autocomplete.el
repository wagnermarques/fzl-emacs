;;; coding-lang-lisp-autocomplete.el --- Autocomplete hooks -*- lexical-binding: t -*-

;; Configuração para Emacs Lisp (Elisp)
(use-package company
  :defer t
  :hook (emacs-lisp-mode . company-mode))

;; Configuração para PHP
(use-package php-mode
  :defer t
  :mode ("\\.php\\'" . php-mode)
  :hook (php-mode . company-mode))

;; Configuração para Java
(use-package lsp-java
  :defer t
  :hook (java-mode . lsp))

;; Configuração para R
(use-package ess
  :defer t
  :mode ("\\.R\\'" . R-mode)
  :hook (R-mode . company-mode))

(provide 'coding-lang-lisp-autocomplete)
;;; coding-lang-lisp-autocomplete.el ends here
