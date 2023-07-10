(message "coding-dockerfile.el loaded sucessfully!!!")



;;dockerfile-mode    20220822.2021 available  melpa      Major mode for editing Docker's Dockerfiles

(use-package  dockerfile-mode
  :ensure t
  :mode ("\\Dockerfile\\'" . dockerfile-mode))

(provide 'coding-dockerfile)
