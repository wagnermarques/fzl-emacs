(provide 'config_env_for_shell_and_startup_some_dev_tools)

(setenv "M2_HOME"   **M2_HOME** )
(setenv "JAVA_HOME" **JAVA_HOME**)


(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **M2_HOME**   "bin"))))         
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME** "bin")))) 

;;let((cmdLs )
;;
;;    );


(log (shell-command-to-string "java -version"))
(log (shell-command-to-string "echo $PATH"))


(defun fzl_shell_command(CMD)
  "Like shell-command-to-string but save output in cmdOutput variable and returns its. (fzl_shell_command 'echo $(pwd)'"
  (interactive)
  (progn
    (setq cmdOutput
          (substring 
           (shell-command-to-string CMD) 
           0 -1))
    (message cmdOutput)))

;;;________________________________________
;;;
;;; NEXUS COMMANDS
;;;________________________________________
(defun fzl_start_nexus()
  (interactive)
  (progn
    (shell-command-to-string (concat (concat (concat "cd '" **NEXUS_HOME**) "'") " && ./bin/nexus start"))
    (find-file (concat **NEXUS_HOME** "data/log/karaf.log"))
    (find-file (concat **NEXUS_HOME** "data/log/nexus.log"))
    (shell-command "firefox http://localhost:8081/#browse/welcome")));;(defun fzl_start_nexus()

(defun fzl_stop_nexus()
  (interactive)
  (progn
    (shell-command-to-string (concat (concat (concat "cd '" **NEXUS_HOME**) "'") " && ./bin/nexus stop"))
));;(defun fzl_stop_nexus()
(fzl_start_nexus)


(defun fzl_start_firefox_at_fzl_welcome_page()
  (interactive)
  (shell-command "firefox http://www.google.com")
);;(defun fzl_start_firefox_at_fzl_welcome_page



  








