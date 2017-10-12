(provide 'java_config)

(fzl_log "java_config loaded sucessfully!!!")

;;all **GLOBAL_VARIABLES** is defined in global_variables_setup.el *

(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk1.8.0_65"))          
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME**   "/bin"))))

