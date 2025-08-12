;;(use-package devcontainer
;;  :ensure t
;;  :config
;;  ;; Common configurations for devcontainer
;;  (setq devcontainer-configuration-directory "~/.devcontainer")
;;  (setq devcontainer-default-image "mcr.microsoft.com/vscode/devcontainers/base:ubuntu")
;;  (setq devcontainer-default-shell "/bin/bash"))

;; Function to install devcontainer CLI using npm
(defun install-devcontainer-cli ()
  "Install devcontainer CLI using npm."
  (interactive)
  (shell-command "npm install -g @devcontainers/cli"))

;; Install devcontainer CLI if not already installed
(unless (executable-find "devcontainer")
  (install-devcontainer-cli))

