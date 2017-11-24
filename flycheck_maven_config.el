;;; package --- summary
;;; Commentary:
;;; Code:
(fzl_log "maven_config.el loaded sucessfully!!!")
(message "maven_config.el loaded sucessfully!!!")

;;**DEV_TOOLS_BASEDIR** defined in global_variables_setup.el *

(setq **M2_HOME** (concat **FZL_HOME** "/integrated/build/apache-maven-3.5.0"))
(setenv "M2_HOME"   **M2_HOME** )
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **M2_HOME**   "/bin"))))
(message (getenv "PATH"))
(provide 'maven_config)
