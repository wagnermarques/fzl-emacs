(provide 'config_dockerfile)

;;https://github.com/spotify/dockerfile-mode

(add-to-list 'load-path "./dockerfile-mode")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

