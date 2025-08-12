;; Ensure use-package is initialized
(require 'use-package)

;; Install and configure undo-tree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode)
  :bind (("C-z" . undo-tree-undo)         ;; Undo with Ctrl + z
         ("C-S-z" . undo-tree-redo)       ;; Redo with Ctrl + Shift + z
         ("C-/" . undo-tree-undo)         ;; Undo with Ctrl + /
         ("M-/" . undo-tree-redo))        ;; Redo with Alt + /
  :config
  ;; Optional settings
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo-tree-history")))
  (setq undo-tree-auto-save-history t))

(provide 'pkgconfig-undo-tree)
