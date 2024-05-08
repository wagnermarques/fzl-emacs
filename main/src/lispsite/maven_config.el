
;;; package --- summary
;;; Commentary:
;;; Code:

(provide 'maven_config)
(message "############################################### maven_config.el")

(fzl/log "maven_config.el loaded sucessfully!!!")
(message "maven_config.el loaded sucessfully!!!")

;;**DEV_TOOLS_BASEDIR** defined in global_variables_setup.el *

(setenv "M2_HOME"   **M2_HOME** )
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **M2_HOME**   "/bin"))))
(message (getenv "PATH"))

