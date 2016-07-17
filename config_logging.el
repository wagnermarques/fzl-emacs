(provide 'config_logging)
(message "config_login loaded sucessfully....")

(defun touch_emacsinitfile_logfile()
  (shell-command-to-string "touch emacsinitfile.log"))

(defun log(str)
  "log in emacsinitfile.log"
  (progn
    (setq cmd (concat (concat "echo " str) " >> emacsinitfile.log"))
    (shell-command-to-string cmd)))

(touch_emacsinitfile_logfile)

;(find-file **EMACSINITFILE_LOG_FILE**)

