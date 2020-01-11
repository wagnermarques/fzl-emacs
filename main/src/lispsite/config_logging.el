;;; package --- Summary

;;; Commentary:
;;; makes emacsfile.log opens and revert sequencially to reflect its changes

;;; Code:
(message " --- config_loggin.el loaded sucessfully!!!")

(defun fzl/create_logfile()
  (progn
    (shell-command-to-string "touch emacsinitfile.log")
    (shell-command-to-string "chmod 777 emacsinitfile.log"))) ;;fix 777 perm

(defun fzl/log(str)
  "Log STR in emacsinitfile.log."
  (progn
    (setq cmd (concat  (concat "echo '### " str) (concat "' >> " (concat  **EMACSINITFILE_HOME** "/emacsinitfile.log"))))
    (shell-command-to-string cmd)
    (message str)))


;; the auto-revert-set-timer function needs it
(require 'timer)

;; when visit .log files turn on fzl-hooked auto-revert-tail-mode
;; credits in http://emacs.stackexchange.com/questions/13005/is-there-a-decent-log-viewing-mode-for-large-log-files
;; TODO: Incluide .out files to rever tomcat catalina.out log file
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\_log\\'" . auto-revert-tail-mode))

(defun fzl/hook-for-auto-revert-tail-mode ()
  (end-of-buffer)
  (make-variable-buffer-local 'auto-revert-interval)
  (setq auto-revert-interval 1)
  (auto-revert-set-timer)
  (make-variable-buffer-local 'auto-revert-verbose)
  (setq auto-revert-verbose nil)
  ;(read-only-mode t)
  (font-lock-mode 0)
  (when (fboundp 'show-smartparens-mode)
    (show-smartparens-mode 0)))

(defun fzl/open-emacsinitfile-log()  
  "Open emacsinitfile log file."
  (interactive)
  (find-file  "/emacsinitfile.log"))


(add-hook 'auto-revert-tail-mode-hook 'fzl/hook-for-auto-revert-tail-mode)

(fzl/create_logfile)
(fzl/log "config_login loaded sucessfully....")
(find-file "emacsinitfile.log")

(provide 'config_logging)
;;; config_logging.el file ends here
