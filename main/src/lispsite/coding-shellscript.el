;;It provides a minor mode that automatically sets the executable permission on a file when it has a shebang line (e.g., #!/bin/sh) and is saved in Emacs.
(use-package bash-completion
  :ensure t)

(use-package sh-script
  :ensure t
  :mode ("\\.sh\\'" . sh-mode)
  :config
  ;; Set indentation style
  (setq sh-basic-offset 2
        sh-indentation 2)

  ;; Add custom key bindings
  (define-key sh-mode-map (kbd "C-f C-r") 'sh-execute-region)
  (define-key sh-mode-map (kbd "C-f C-e") 'sh-execute-buffer)
  (define-key sh-mode-map (kbd "C-f C-f") 'sh-set-shell))


(defun fzl-shellscript-make-script-executable-after-saving ()
  "Make the shell script executable after saving."
  (when (string= (file-name-extension buffer-file-name) "sh")
    (chmod buffer-file-name #o755))) ; Set file permissions to 755
(add-hook 'after-save-hook #'fzl-shellscript-make-script-executable-after-saving)


;; bshell             20201219.139  available  melpa      Manage and track multiple inferior shells
;; better-shell       20191025.1737 available  melpa      Better shell management
;; buffer-watcher     20170913.839  available  melpa      Easily run shell scripts per filetype/directory when a buffer is saved
;; chatgpt-shell      20230521.1229 available  melpa      ChatGPT shell + buffer insert commands
;; command-queue      20160328.1725 available  melpa      shell command queue
;; company-shell      20230106.1532 available  melpa      Company mode backend for shell functions
;; dall-e-shell       20230513.1256 available  melpa      Interaction mode for DALL-E
;; equake             20220627.2248 available  melpa      Drop-down console for (e)shell & terminal emulation

        
(provide 'coding-shellscript)
