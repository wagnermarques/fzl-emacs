(defun fzl-dnf-install-package (package-name)  
  "Install a Fedora package using 'sudo dnf install PACKAGE-NAME' via TRAMP.
Prompts for PACKAGE-NAME if called interactively.
Opens the command output in a separate buffer."
  (interactive "sPackage to install (dnf): ")
  (let ((command (format "dnf install -y %s" (shell-quote-argument package-name)))
        (tramp-root-dir "/sudo::/"))
    (message "Attempting to install package: %s" package-name)
    (with-temp-buffer
      ;; Change the default directory to a TRAMP root path.
      ;; This tricks Emacs into running the subsequent shell command with sudo,
      ;; handled by TRAMP, which will prompt for the root password in the minibuffer.
      (cd tramp-root-dir)

      ;; Execute the command asynchronously to avoid freezing Emacs
      (async-shell-command command "*dnf-install-output*")

      ;; Notify the user that the output is in a buffer
      (message "Installation started. Output in buffer *dnf-install-output*."))
    t))

(provide 'linux-fedora)
;;; linux-fedora.el ends here
