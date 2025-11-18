
(defun fzl-linux-fedora-install-fonts ()
  "Install FiraCode Nerd Font on Fedora."
  (interactive)
  (if (y-or-n-p "This will install FiraCode Nerd Font using a Copr repository. Do you want to continue?")
      (progn
        (shell-command "sudo dnf copr enable che/nerd-fonts -y")
        (shell-command "sudo dnf install nerd-fonts-firacode -y")
        (shell-command "fc-cache -fv")
        (message "FiraCode Nerd Font installed successfully. Please restart Emacs for the changes to take effect."))
    (message "Font installation cancelled.")))

(provide 'linux-fedora-install-fonts)
