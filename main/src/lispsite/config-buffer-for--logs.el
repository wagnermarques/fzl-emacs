(defun my-auto-revert-tail-for-log-files ()
  "Enable `auto-revert-tail-mode` for `.log` files."
  (when (string-match "\\.log\\'" buffer-file-name)
    (auto-revert-tail-mode)))

(add-hook 'find-file-hook 'my-auto-revert-tail-for-log-files)
(provide 'config-buffer-for--logs)
