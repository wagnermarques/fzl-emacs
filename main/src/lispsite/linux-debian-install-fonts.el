(defun fzl-linux-debian-install-fonts ()
  "Install FiraCode Nerd Font on Debian/Ubuntu/Zorin."
  (interactive)
  (if (y-or-n-p "This will install FiraCode Nerd Font by downloading it from GitHub. Do you want to continue?")
      (let ((font-dir "/usr/local/share/fonts/NerdFonts")
            (temp-zip "/tmp/FiraCode.zip")
            (download-url "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"))
        
        ;; Install dependencies first
        (message "Checking/Installing dependencies (wget, unzip)...")
        (shell-command "sudo apt update && sudo apt install -y wget unzip")

        ;; Create directory
        (message "Creating font directory...")
        (shell-command (format "sudo mkdir -p %s" font-dir))

        ;; Download
        (message "Downloading FiraCode Nerd Font...")
        (shell-command (format "wget -O %s %s" temp-zip download-url))

        ;; Unzip
        (message "Unzipping fonts...")
        (shell-command (format "sudo unzip -o -j %s -d %s" temp-zip font-dir))

        ;; Clean up
        (message "Cleaning up...")
        (shell-command (format "rm -f %s" temp-zip))

        ;; Update cache
        (message "Updating font cache...")
        (shell-command "fc-cache -fv")

        (message "FiraCode Nerd Font installed successfully. Please restart Emacs for the changes to take effect."))
    (message "Font installation cancelled.")))

(provide 'linux-debian-install-fonts)
