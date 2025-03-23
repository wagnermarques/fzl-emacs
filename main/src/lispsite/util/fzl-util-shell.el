(use-package shell-maker
  :ensure t)

(defun fzl-new-shell ()
  "Create a new shell buffer and switch to it."
  (interactive)
  (let ((buffer-name "*new-shell*"))
    (shell buffer-name)))

(global-set-key (kbd "C-c C-f C-n C-s") 'fzl-new-shell)

(provide 'fzl-util-shell)
