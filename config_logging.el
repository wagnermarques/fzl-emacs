;;; makes emacsfile.log opens and revert sequencially to reflect its changes 
(provide 'config_logging)

(defun create_emacsinitfile_logfile()
  (progn
    (shell-command-to-string "> emacsinitfile.log")
    (shell-command-to-string "chmod 777 emacsinitfile.log"))) ;;fix 777 perm
(create_emacsinitfile_logfile)

(defun create_fzlbpms_logfile()
  (progn
    (shell-command-to-string "> fzlbpms.log")
    (shell-command-to-string "chmod 777 fzlbpms.log")));; fix 777 perm

(defun fzl_log(str)
  "log in emacsinitfile.log"
  (progn    
    (setq cmd (concat (concat "echo " str) " >> emacsinitfile.log"))
    (shell-command-to-string cmd)
    (message str)))
(fzl_log "config_login loaded sucessfully....")

(defun fzl_bpms_log(str)
  "log in emacsinitfile.log"
  (progn
    (setq cmd (concat (concat "echo " str) " >> fzlbpms.log"))
    (shell-command-to-string cmd)))

;; the auto-revert-set-timer function needs it
(require 'timer)

(create_emacsinitfile_logfile)


;; when visit .log files turn on fzl-hooked auto-revert-tail-mode
;; credits in http://emacs.stackexchange.com/questions/13005/is-there-a-decent-log-viewing-mode-for-large-log-files
;; TODO: Incluide .out files to rever tomcat catalina.out log file
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\_log\\'" . auto-revert-tail-mode))

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


(defun fzl-open-emacsinitfile-log()  
  "open emacsinitfile log file"
  (interactive)
  (find-file  "/emacsinitfile.log"))
