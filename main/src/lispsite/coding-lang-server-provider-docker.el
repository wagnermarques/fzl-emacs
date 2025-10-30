;; lsp-docker-setup.el
;; This file sets up lsp-docker and provides interactive functions to manage Docker containers.

(use-package lsp-docker
  :ensure t
  :commands (lsp-docker-start-container
             lsp-docker-stop-container
             lsp-docker-restart-container
             lsp-docker-logs
             lsp-docker-exec)
  :config
  ;; Define interactive functions to manage Docker containers
  (defun lsp-docker-start-container ()
    "Start the Docker container for the current project."
    (interactive)
    (lsp-docker--start-container))

  (defun lsp-docker-stop-container ()
    "Stop the Docker container for the current project."
    (interactive)
    (lsp-docker--stop-container))

  (defun lsp-docker-restart-container ()
    "Restart the Docker container for the current project."
    (interactive)
    (lsp-docker--restart-container))

  (defun lsp-docker-logs ()
    "Show logs of the Docker container for the current project."
    (interactive)
    (lsp-docker--logs))

  (defun lsp-docker-exec (command)
    "Execute a COMMAND in the Docker container for the current project."
    (interactive "sCommand to execute: ")
    (lsp-docker--exec command))

  ;(defun fzl-lsp-docker-clone-repo (repo-url, &optional dir)
  ;  "Clone a REPO-URL in the Docker container for the current project."
  ;  (interactive "sRepository URL to clone: ")
  ;  (lsp-docker-exec (format "git clone %s" repo-url)))
  
  ;; Keybindings for convenience
  :bind (("C-c d s" . fzl-lsp-docker-start-container)
         ("C-c d x" . fzl-lsp-docker-stop-container)
         ("C-c d r" . fzl-lsp-docker-restart-container)
         ("C-c d l" . fzl-lsp-docker-logs)
         ("C-c d e" . fzl-lsp-docker-exec)))



(provide 'coding-lang-server-provider-docker)
