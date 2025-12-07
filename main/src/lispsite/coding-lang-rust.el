
;;; Package -- Summary: Rust Language Support
;;; Commentary:
;;; Provides a comprehensive setup for Rust development using lsp-mode, lsp-ui, and cargo.
;;; Code:

(use-package rust-mode
  :ensure t
  :hook (rust-mode . (lambda ()
                       (setq lsp-rust-analyzer-server-display-inlay-hints t)
                       (lsp))))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(defun fzl/install-rust-analyzer ()
  "Install rust-analyzer using rustup."
  (interactive)
  (let ((command "source ~/.cargo/env && rustup component add rust-analyzer"))
    (async-shell-command command "*rust-analyzer-installation*")))

(provide 'coding-lang-rust)
