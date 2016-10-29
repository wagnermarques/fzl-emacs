(provide 'config-enviroment)

(message "config-enviroment loaded sucessfully!")



(setenv "M2_HOME"   **M2_HOME** )
(setenv "JAVA_HOME" **JAVA_HOME**)


(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **M2_HOME**   "/bin"))))         
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME** "/bin")))) 


;; when visit .log files turn on fzl-hooked auto-revert-tail-mode
;; credits in http://emacs.stackexchange.com/questions/13005/is-there-a-decent-log-viewing-mode-for-large-log-files
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(defun fzl-hook-for-auto-revert-tail-mode ()
  (end-of-buffer)
  (make-variable-buffer-local 'auto-revert-interval)
  (setq auto-revert-interval 1)
  (auto-revert-set-timer)
  (make-variable-buffer-local 'auto-revert-verbose)
  (setq auto-revert-verbose nil)
  (read-only-mode t)
  (font-lock-mode 0)
  (when (fboundp 'show-smartparens-mode)
    (show-smartparens-mode 0)))
(add-hook 'auto-revert-tail-mode-hook 'fzl-hook-for-auto-revert-tail-mode)



;;let((cmdLs )
;;
;;    );
(shell-command (concat **NEXUS_HOME** "/bin/nexus start"))
(shell-command (concat (concat "cd " **NEXUS_HOME**) " && $(pwd)"))

(find-file (concat **NEXUS_HOME** "/logs/wrapper.log"))
(shell-command "firefox http://localhost:8081/nexus/#welcome")







