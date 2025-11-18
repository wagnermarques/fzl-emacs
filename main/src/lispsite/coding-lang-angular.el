;;; coding-lang-angular.el --- Configuration for Angular development using lsp-mode

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((typescript-mode . lsp-deferred))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode)

(use-package lsp-treemacs
  :ensure t
  :after (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

(with-eval-after-load 'lsp-mode
  (setq lsp-clients-angular-language-server-command
        '("ngserver" "--stdio" "--tsdk" "node_modules/typescript/lib")))

(provide 'coding-lang-angular)

;;; coding-lang-angular.el ends here
