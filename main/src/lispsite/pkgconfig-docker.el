(use-package docker
  :ensure t ;; Ensure the package is installed
  :defer t  ;; Defer loading until the package is needed
  :config
  ;; Add a keybinding to open the Docker interface
  (define-key global-map (kbd "C-c C-f C-d l") 'docker) ;; Bind `C-c d` to open Docker interface
  ;; Optionally, customize the Docker executable path if it's not in your PATH
  (setq docker-docker-executable "/usr/bin/docker"))

;; Install and configure `docker-api` package
(use-package docker-api
  :ensure t ;; Ensure the package is installed
  :defer t  ;; Defer loading until the package is needed
  :config
  ;; Example: Define a function to list all running containers using the Docker API
  (defun my/docker-api-list-containers ()
    "List all running Docker containers using the Docker API."
    (interactive)
    (message "Running containers: %s" (docker-api-containers :all nil))) ;; Fetch running containers
  ;; Bind the function to a keybinding
  (define-key global-map (kbd "C-S-c C-f C-d l") 'my/docker-api-list-containers))



;; Install and configure `docker-cli` package
(use-package docker-cli
  :ensure t ;; Ensure the package is installed
  :defer t  ;; Defer loading until the package is needed
  :config
  ;; Example: Define a function to run a Docker command interactively
  (defun my/docker-run-command (command)
    "Run a Docker COMMAND interactively."
    (interactive "sEnter Docker command: ") ;; Prompt for a Docker command
    (docker-cli-run command)) ;; Execute the commandyou
  ;; Bind the function to a keybinding
  (define-key global-map (kbd "C-S-c C-f C-d r") 'my/docker-run-command))

;; Install and configure `docker-compose-mode` package
(use-package docker-compose-mode
  :ensure t ;; Ensure the package is installed
  :mode ("docker-compose\\.yml\\'" . docker-compose-mode) ;; Associate with docker-compose.yml files
  :config
  ;; Enable syntax highlighting and indentation for docker-compose.yml files
  (add-hook 'docker-compose-mode-hook
            (lambda ()
              (yaml-mode) ;; Use YAML mode for syntax highlighting
              (setq indent-tabs-mode nil) ;; Use spaces instead of tabs
              (setq tab-width 2))) ;; Set indentation width to 2 spaces
  ;; Optionally, add a keybinding for formatting the file
  (define-key docker-compose-mode-map (kbd "C-S-c C-f C-d c") 'indent-region))

;; End of Docker-related configurations

(provide 'pkgconfig-docker)
