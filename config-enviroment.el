(provide 'config-enviroment)
(message "config-enviroment loaded sucessfully!")

(setq *M2_HOME*    "/home/administrador/progsativos/fzlbpms/integrated/builds/apache-maven-3.3.3")
(setq *JAVA_HOME*  "/home/administrador/progsativos/fzlbpms/integrated/jdks/jdk1.8.0_65")


(setenv "M2_HOME"   *M2_HOME* )
(setenv "JAVA_HOME" *JAVA_HOME*)


(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat *M2_HOME*   "/bin"))))         
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat *JAVA_HOME* "/bin")))) 





