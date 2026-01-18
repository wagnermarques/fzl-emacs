(defun fzl-apt-install-package (package-name)  
  "Install a Debian/Ubuntu package using 'sudo apt install PACKAGE-NAME' via TRAMP.
Prompts for PACKAGE-NAME if called interactively.
Opens the command output in a separate buffer."
  (interactive "sPackage to install (apt): ")
  (let ((command (format "apt install -y %s" (shell-quote-argument package-name)))
        (tramp-root-dir "/sudo::/"))
    (message "Attempting to install package: %s" package-name)
    (with-temp-buffer
      ;; Change the default directory to a TRAMP root path.
      ;; This tricks Emacs into running the subsequent shell command with sudo,
      ;; handled by TRAMP, which will prompt for the root password in the minibuffer.
      (cd tramp-root-dir)

      ;; Execute the command asynchronously to avoid freezing Emacs
      (async-shell-command command "*apt-install-output*")

      ;; Notify the user that the output is in a buffer
      (message "Installation started. Output in buffer *apt-install-output*."))
    t))

(provide 'linux-debian)
;;; linux-debian.el ends here
