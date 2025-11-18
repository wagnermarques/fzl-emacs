
;;; Package -- Summary:
;;; Commentary:
;;; Code:

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (lsp-mode . lsp-enable-which-key-integration))

(defun +rust-project-p (workspace)
  (when-let ((root (lsp--workspace-root workspace)))
    (message "LSP Rust check: checking for Cargo.toml in %s" root)
    (let ((cargo-toml-exists (file-exists-p (expand-file-name "Cargo.toml" root))))
      (message "LSP Rust check: Cargo.toml exists? %s" cargo-toml-exists)
      cargo-toml-exists)))

(use-package rust-mode
  :ensure t)

(eval-after-load 'rust-mode
  '(progn
     (lsp-register-client
      (make-lsp-client :new-connection (lsp-stdio-connection '("~/.cargo/bin/rust-analyzer"))
                       :major-modes '(rust-mode)
                       :server-id 'rust-analyzer
                       :activation-fn #'+rust-project-p))))

(defun fzl/install-rust-analyzer ()
  "Install rust-analyzer using rustup."
  (interactive)
  (let ((command "source ~/.cargo/env && rustup component add rust-analyzer"))
    (async-shell-command command "*rust-analyzer-installation*")))

(provide 'coding-lang-rust)
