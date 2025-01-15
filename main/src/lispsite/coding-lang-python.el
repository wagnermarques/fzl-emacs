(use-package python-mode
  :ensure t
  :mode "\.py\'"
  :hook (python-mode . (lambda ()
                         (electric-indent-mode 1)
                         (lsp)))) ; Enable auto-indentation and LSP


(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (python-mode . lsp) ; Ensure lsp-mode is started for Python files
  :init
  (setq lsp-keymap-prefix "C-c l")) ; Customize the keymap prefix if needed

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :hook (python-mode . company-mode)
  :config
  (setq company-idle-delay 0.2)) ; Adjust idle delay as needed

(provide 'coding-lang-python)
