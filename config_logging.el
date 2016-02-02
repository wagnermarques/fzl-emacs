(provide 'config_logging)
(message "config_login loaded sucessfully....")

(defun touch_emacsinitfile_logfile()
  "touch emacsinitfile.log file"
  (shell-command (concat "touch " **EMACSINITFILE_LOG_FILE**)))


(touch_emacsinitfile_logfile)
(fzl-open-log-emacsinitfile-logs) ;defined in fzl_functions.el
