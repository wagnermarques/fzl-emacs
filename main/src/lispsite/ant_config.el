;;; package --- summary
;;; Commentary:
;;; Code:

(fzl/log "maven_config.el loaded sucessfully!!!")
(message "maven_config.el loaded sucessfully!!!")

;;**DEV_TOOLS_BASEDIR** defined in global_variables_setup.el *

(setenv "ANT_HOME"   **ANT_HOME** )
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **ANT_HOME**   "/bin"))))
(message (getenv "PATH"))
(provide 'ant_config)

