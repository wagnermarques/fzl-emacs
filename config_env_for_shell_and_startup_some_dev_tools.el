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
;;; Logs
;;;________________________________________
(defun fzl-fzlbpms-log()
  (find-file (concat **FZL_HOME** "/logs/fzlbpms.log")))


;;;________________________________________
;;;
;;; Eclipse
;;;________________________________________
(defun fzl-start-eclipse-modeling()
    ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
    (start-process
     "PROCESS-fzl-start-eclipse-modelling"
     "PROCESS-fzl-start-eclipse-modelling"
      (concat **FZL_HOME** "bin/fzl_start_eclipse.sh")))



;;;________________________________________
;;;
;;; Exo Plataform
;;;________________________________________


(defun fzl-exo-settings-example()
  (progn
    ;;(split-window-below)
    (find-file (concat **EXO_HOME** "gatein/conf/exo-sample.properties"))))


(defun fzl-exo-logging-properties()
  (progn
    (split-window-below)    
    (find-file (concat **EXO_HOME** "conf/logging.properties"))))

(defun fzl-exo-configuration-xml()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "gatein/conf/configuration.xml"))))

(defun fzl-exo-setenv-customize-sample-sh()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "bin/setenv-customize.sample.sh"))))

(defun fzl-exo-idm-configuration-xml()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "webapps/platform-extension/WEB-INF/conf/organization"))))

(defun fzl-exo-platform-log()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "logs/platform.log"))))


(defun fzl-start-exo()
  (progn
    ;;(split-window-below)
    (fzl-exo-platform-log)    
    (start-process
     "PROCESSfzl-start-exo-process"
     "PROCESSfzl-start-exo-process"
     (concat **FZL_HOME_SERVER** "bin/fzl-exo-run.sh"))))

(defun fzl-exo-open-in-browser()
(sys:open-url "http://localhost:8080/portal/"))




;;EXO_DATA_DIR=/mnt/nfs/shared/exo/data
;;The property exo.base.url is used to generate links in some cases,
;;like a topic link in an email notification.
;;Generally you need to configure it to the base URL that
;;users use to access eXo Platform.
;;For example, if you use a reverse proxy,
;;the URL should be the proxy's host.
;;The following is the default configuration.
;;To change it, edit exo.properties.
;;See Configuration overview if you have not created this file yet. 
;;exo.base.url=http://localhost:8080

;;exo.accountsetup.skip=true

;;;________________________________________
;;;
;;; emacsinitfile
;;;________________________________________

(defun fzl-speedbar-change-dir-to-emacsinitifle()
  "todo"
  (progn
    ()))

(defun fzl-speedbar-change-dir-to-fzlStudio-bin()
  "todo"
  (progn
    ()))
(defun fzl-speedbar-change-dir-to-fzlServer-bin()
  "todo"
  (progn
    ()))



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


;;;________________________________________
;;;
;;; APACHEDS COMMANDS
;;;________________________________________

(defun fzl-start-apacheds()
  (interactive)
  (progn
    (shell-command (concat (concat (concat "cd '" **APACHEDS_HOME**) "'") " && ./bin/apacheds.sh start"))
    (split-window-below)
    (find-file (concat **APACHEDS_HOME** "/instances/default/log/apacheds.out"))
    (split-window-below)
    (find-file (concat **APACHEDS_HOME** "/instances/default/log/apacheds.log"))))

(defun fzl-stop-apacheds()
  (interactive)
  (progn
    (shell-command (concat (concat (concat "cd '" **APACHEDS_HOME**) "'") " && ./bin/apacheds.sh stop"))
    (split-window-below)
    (find-file (concat **APACHEDS_HOME** "/instances/default/log/apacheds.out"))
    (split-window-below)
    (find-file (concat **APACHEDS_HOME** "/instances/default/log/apacheds.log"))))

(defun fzl-start-apacheds-studio()
  (interactive)
  (progn
    (shell-command (concat (concat (concat "cd '" **APACHEDS_STUDIO_HOME**) "'") " && ./ApacheDirectoryStudio"))))



(defun fzl_start_firefox_at_fzl_welcome_page()
  (interactive)
  (shell-command "firefox http://www.google.com")
);;(defun fzl_start_firefox_at_fzl_welcome_page



  








