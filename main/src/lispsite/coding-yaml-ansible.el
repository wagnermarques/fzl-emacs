;; Ansible Mode
(use-package ansible
  :ensure t
  :hook (yaml-mode . ansible))


;; Function to run ansible-playbook on the current buffer
(defun fzl-ansible-playbook-run-on-current-buffer ()
  "Run ansible-playbook on the current buffer."
  (interactive)
  (let ((playbook (buffer-file-name)))
    (if (and playbook (string-match "\.yml\'" playbook))
        (compile (format "ansible-playbook %s" playbook))
      (message "Not a valid Ansible playbook file!"))))



;; Bind the function to a key combination, e.g., C-c C-r
(add-hook 'yaml-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-r") 'fzl-ansible-playbook-run-on-current-buffer)))

(provide 'coding-yaml-ansible)
