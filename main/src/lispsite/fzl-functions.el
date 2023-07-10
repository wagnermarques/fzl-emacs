;;; package --- Summary

;;; Commentary:
;;**GLOBAL_VARS** is all defined in  global_variables_setup.el file

;;; Code:

;;; Open dired at a specific dir
(defun fzl-dired-open-dir (&optional dir)
  "Open dired at DIR if it is specified, or at the default directory otherwise."
  (interactive "DOpen Dired at directory: ")
  (setq default-directory "/run/media/wgn/nfts/env-Projetos")
  (setq _directory (or dir default-directory))
  (dired _directory))


(defun fzl-list-major-modes-active-current-buffer ()
  "List the major mode active in the current buffer using Helm."
  (interactive)
  (helm :sources (helm-build-sync-source "Major Modes"
                   :candidates (list (format "%s (%s)" mode-name major-mode))
                   :action (helm-make-actions
                            "Copy Mode Name" #'kill-new))))

(defun fzl-list-active-modes-in-current-buffer ()
  "List all active modes in the current buffer in a new buffer."
  (interactive)
  (let ((modes (buffer-local-value 'minor-mode-list (current-buffer))))
    (with-help-window "*Active Modes*"
      (with-current-buffer "*Active Modes*"
        (dolist (mode modes)
          (princ (format "%s\n" mode)))))))


;;(global-set-key (kbd "C-c d") 'fzl-dired-open-dir)


;;;;________________________________________
;;;
;;; org-mode
;;; 
;;; 
;;;________________________________________

;;https://orgmode.org/manual/Beamer-export-commands.html#Beamer-export-commands
;;funciona porque uso essa funcao como item de menu
;;com o buffer que quero exportar aberto
(defun fzl-orgmode-export-beamer-to-pdf()
  (interactive)
  (org-beamer-export-to-pdf))




;;;________________________________________
;;;
;;; FZLServer functions
;;;________________________________________
;;;TODO fix ssh without password
(defun fzl/camunda-server-ls-deployed-apps()
  (start-process
   "PROCESS-ls-camunda-server-deployed-apps"
   "PROCESS-ls-camunda-server-deployed-apps"
   "ssh sin5009@45.79.225.175 \"ls -l /home/sin5009/fzlbpms/integrated/camunda_bpm/server/apache-tomcat-9.0.24/webapps/\""))


;;;________________________________________
;;;
;;; find-files as root
;;; https://caiorss.github.io/Emacs-Elisp-Programming/Elisp_Snippets.html
;;; 
;;;________________________________________
(defun fzl-find-file-as-root (fileNameToOpen)
  "Utils func to open files as root, Provide FILENAMETOOPEN as full path."
  (find-file (concat "/sudo:root@localhost:"  fileNameToOpen)))

(defun fzl-find-file-as-root-selinuxconfig()
  "Opens /etc/selinux/config file as root."
  (interactive)
  (fzl-find-file-as-root "/etc/selinux/config"))



;;;________________________________________
;;;
;;; integrations
;;; KARAF
;;; 
;;; 
;;;________________________________________
(defun fzl-karaf-karaf-out()
  "Opens karaf.log file."
  (find-file (concat **KARAF_HOME** "/data/log/karaf.log"))
  )


;;;________________________________________
;;;
;;; integrations
;;; Bonita Studio
;;; 
;;; 
;;;________________________________________

(defun fzl-bonita-studio-tomcat-logs-dir()
  "Opens dired at tomcat logs dir."
  (dired "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/SIN5009WithBonitasoft/tomcat/server/logs")
  )

(defun fzl-bonita-studio-tomcat-metadata-tomcat-log()
  "Open .metadata/tomcat.log."
  (find-file
   "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/SIN5009WithBonitasoft/.metadata/tomcat.log")
  )
  


;;;________________________________________
;;;
;;; integrations
;;; Jekyll exportation
;;; 
;;; 
;;;________________________________________




;;;________________________________________
;;;
;;; shell utilities
;;; 
;;; 
;;;________________________________________

;;;SUPER UTILS FUNCTIONS
;;thanks: http://emacs-fu.blogspot.com.br/2008/12/running-console-programs-inside-emacs.html
(defun fzl-run-prg-in-ansi-term (prg)
  (ansi-term prg))

(defun fzl-mutt()
  "mutt email client withing ansi-term"
         (fzl-run-prg-in-ansi-term "/usr/bin/mutt"))

(defun fzl-html2pdf(htmlUrl)
  (interactive "shtmlUrl")
  "convert html to pdf file"
  (setq lastPartOfUrl (string-reverse (car (split-string (string-reverse htmlUrl) "/"))))
  (setq fName (concat lastPartOfUrl ".pdf"))
  (start-process
   "ProcessName_fzl-html2pdf"
   "ProcessName_fzl-html2pdf"
   "wkhtmltopdf"
   htmlUrl
   (concat "./generated-artifacts/wkhtmltopdf" fName)
   (switch-to-buffer "ProcessName_fzl-html2pdf")))


  

;;;________________________________________
;;;
;;; docker
;;; 
;;; 
;;;________________________________________

(defun fzl-journalctl-docker-service()
  (interactive)
  (start-process
   "ProcessName_Fzl-journalctl-docker-service"
   "BufferName__Fzl-journalctl-docker-service"
   "journalctl"
   "-fu"
   "docker.service"))


;;;________________________________________
;;;
;;; sqlite
;;; 
;;; 
;;;________________________________________

;(defun fzl-sqlite-open-in-shell-buffer()
;  (interactive)
;  (start-process
;   "ProcessName_FzlStartSqlite"
;   "BufferName__FzlStartSqlite"
;   "sqlite3"
;   (concat **FZL_HOME** "/integrated/dbs/sqlite")))


(defun fzl-open-url-in-browser(url)
  "Open url in browser"
  (interactive "s")
  (progn
    (start-process
     "ProcessNameForFzlOpenUrlInBroserFunction"
     nil
     "firefox"
     url)))

(defun fzl-open-buffer-file-in-browser()
  "Open buffer file in browser"
  (interactive)
  (start-process
   "ProcessName-fzl-open-buffer-file-in-browser"
   nil
   "firefox"
   (concat "file://" buffer-file-name)))


;;;________________________________________
;;;
;;; android sdk
;;; -process
;;;https://developer.android.com/studio/command-line/sdkmanager.html
;;;________________________________________

(defun fzl-android-show-environment-variables()
  (interactive)
  (progn
    (message ">>>")
    (message ">>> Android relevant environment variables")
    (message ">>> see: https://developer.android.com/studio/command-line/variables")
    (message (concat ">>>" (concat "$USER=" (getenv "USER"))))
    (message  (concat ">>>" (concat "$ANDROID_SDK_ROOT=" (getenv "ANDROID_SDK_ROOT"))))
    ))

(defun fzl-android-list-avds()
  (interactive)
  (start-process
   "ProcessName-android--list-avds"
   "BufferName-android--list-avds"
   "emulator "
   "-list-avds"
   )
  (switch-to-buffer "BufferName-android--list-avds")
  )

(defun fzl-start-android-studio()
  (interactive)
  (start-process
   "ProcessName-fzl-start-android-studio"
   "BufferName-fzl-start-android-studio"
   (concat **ANDROID_STUDIO_HOME** "/bin/studio.sh")
   ;;(concat **ANDROID_STUDIO_HOME** "/bin/idea.sh")
   ""
   )
  (switch-to-buffer "BufferName-fzl-start-android-studio")
  )

(defun fzl-android-sdkmanager-open()
  "open android sdk manager"
  (interactive)
  (start-process
   "ProcessNameAndroidSdkOpen"
   "BufferNameAndroidSdkOpen"
   (concat **ANDROID_HOME** "/tools/bin/sdkmanager")
   "--list"))


;;;________________________________________
;;;
;;; 

(defun fzl-httpd-start-and-open-browser()
  (start-process
   "PROCESS-fzl-httpd-start-and-open-browser"
   "PROCESS-fzl-httpd-start-and-open-browser"
   "firefox"
   "http://localhost:8080/"))


(defun shell-dir (name dir)
  (interactive "sShell name: \nDDirectory: ")
  (let ((default-directory dir))
    (shell name)))


(defun fzl-shell-maven-projects-workspace()
    (shell-dir "ShellDirInMvnProjectsWorkspace" **WKSP_MVN_PROJECTS**))
  

(defun fzl-github-open()
  (start-process
   "PROCESS-fzl-github-open"
   "PROCESS-fzl-github-open"
   "firefox"
   "http://github.com"))


(defun fzl-open-http-localhost-9191()
  (start-process
   "PROCESS-fzl-open-http-localhost-9191"
   "PROCESS-fzl-open-http-localhost-9191"
   "firefox"
   "http://localhost:9191"))

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
;;; nodejs
;;; 
;;; 
;;;________________________________________
;;https://docs.npmjs.com/cli/config



;;;________________________________________
;;;
;;; IDES
;;;________________________________________
;;;osgi.instance.area {-data}
;;;    the instance data location for this session.
;;;    Plug-ins use this location to store their data. For example, the Resources plug-in uses this as the default location for projects (aka the workspace).
;;;    See the section on locations for more details.
;;;    https://help.eclipse.org/neon/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Freference%2Fmisc%2Fruntime-options.html&anchor=osgiinstancearea
;(defun fzl/start-camunda-modeller()
;  "Open camunda modeller."
;  (start-process
;   "PROCESS-fzl/start-camunda-modeller"
;   "PROCESS-fzl/start-camunda-modeller"
;   (concat **FZL_HOME** "/integrated/ides/camunda-modeler-3.5.0-linux-x64/camunda-modeler")))


;(defun fzl/start-eclipse-modeling()
;  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
;  (start-process
;     "PROCESS-fzl-start-eclipse-modelling"
;     "PROCESS-fzl-start-eclipse-modelling"
;     (concat **FZL_HOME** "/integrated/ides/eclipse-modeling-2019-12-R-linux-gtk/eclipse")))
  
;(defun fzl/start-eclipse-java()
;  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
;  (start-process
;     "PROCESS-fzl-start-eclipse-java-oxigen"
;     "PROCESS-fzl-start-eclipse-java-oxigen"
;     (concat **FZL_HOME** "/integrated/ides/eclipse-java-2019-12-R-linux-gtk/eclipse")))

;(defun fzl/start-eclipse-jee()
;  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
;  (start-process
;     "PROCESS-fzl-start-eclipse-java-oxigen"
;     "PROCESS-fzl-start-eclipse-java-oxigen"
;     (concat **FZL_HOME** "/integrated/ides/eclipse-jee-2019-12-R-linux-gtk/eclipse")))
                                            


;;;________________________________________
;;;
;;; NEXUS COMMANDS
;;;________________________________________
(defun fzl-start-nexus()
  (interactive)
  (progn
    (start-process
     "PROCESS-fzl-start-nexus"
     "PROCESS-fzl-start-nexus"
     (concat (concat (concat "cd '" **FZL_HOME**) "'") " && ./bin/fzl_start_nexus.sh")
     (find-file (concat **NEXUS_HOME** "data/log/karaf.log"))
     (find-file (concat **NEXUS_HOME** "data/log/nexus.log"))
     (start-process
      "PROCESS-firefox"
      "PROCESS-firefox"
      "firefox"
      "http://localhost:8081/#browse/welcome"))));;(defun fzl_start_nexus()

;;TODO
(defun fzl-containers-maven-open-nexus-karaf-log()
  (interactive)
)
;;TODO
(defun fzl-containers-maven-open-nexus-log()
  (interactive)
)

(defun fzl-containers-maven-open-nexus-in-browser()
  (interactive)
  (progn
    (start-process
     "PROCESS-fzl-containers-maven-open-nexus-in-browser"
     "PROCESS-fzl-containers-maven-open-nexus-in-browser"
     "firefox"
     "http://localhost:8081/#browse/welcome")))


(defun fzl-containers-maven-ansi-term-in-mvnprojects-dir()
  (interactive)
  (let ((mvnprojects_dir (concat **maven_container_home** "/../data-dir-for-maven/mvnprojects"))                                
        (ansi-term "/bin/bash" mvnprojects_dir))))
  

;(message (concat (concat (concat "cd '" **FZL_HOME**) "'") " && ./bin/fzl_start_nexus.sh"))
(defun fzl-nexus-open-in-firefox()
  (start-process
   "PROCESS-fzl-nexus-open-in-firefox"
   "PROCESS-fzl-nexus-open-in-firefox"
   "firefox"
   "http://localhost:8081"))

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
    (start-process
     "PROCESS-fzl-start-apacheds"
     "PROCESS-fzl-start-apacheds"
     (concat **APACHEDS_HOME** " && ./bin/apacheds.sh start"))
    (split-window-below)
    (find-file (concat **APACHEDS_HOME** "/instances/default/log/apacheds.out"))
    (split-window-right)
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
    (start-process
     "PROCESS-fzl-start-apacheds-studio"
     "PROCESS-fzl-start-apacheds-studio"
     (concat **APACHEDS_STUDIO_HOME** "/ApacheDirectoryStudio")))



(defun fzl_start_firefox_at_fzl_welcome_page()
  (interactive)
  (shell-command "firefox http://www.google.com")
);;(defun fzl_start_firefox_at_fzl_welcome_page

;;;________________________________________
;;;
;;; tomcat8 functions
;;;________________________________________
  
;;was predefined by myself that the container 8080 por is binded to 80
(defun fzl-containers-tomcat8-tail-f-catalina-out()
  (interactive)
    (start-process
   "PROCESS-fzl-containers-tomcat8-tail-f-catalina-out"
   "PROCESS-fzl-containers-tomcat8-tail-f-catalina-out"
   "docker"
   "exec"
   "fzl_tomcat8"
   "tail"
   " -f "
   "/opt/apache-tomcat-8.5.31/logs/catalina.out"))



(defun fzl-containers-tomcat8-open-admin-in-browser()
  (interactive)
  (progn
    (start-process
     "PROCESS-fzl-containers-tomcat8-open-admin-in-browser"
     "PROCESS-fzl-containers-tomcat8-open-admin-in-browser"
     "firefox"
     "http://localhost")))

(defun fzl-containers-tomcat8-open-users-xml()
  (interactive)
  (progn))




;;;________________________________________
;;;
;;; Mariadb
;;;________________________________________

;;fzl-mariadb-start

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

(defun fzl-exo-setenv-customize-sh()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "bin/setenv-customize.sh"))))



(defun fzl-exo-idm-configuration-xml()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "webapps/platform-extension/WEB-INF/conf/organization"))))

(defun fzl-exo-platform-log()
  (progn
    (split-window-below)
    (find-file (concat **EXO_HOME** "logs/platform.log"))))




;(defun fzl-start-exo()
;  "https://www.exoplatform.com/docs/public/index.jsp?topic=%2FPLF43%2FPLFUserGuide.GettingStarted.html"
;  (progn
;    ;;(split-window-below)
;    (fzl-exo-platform-log)    
;    (start-process
;     "PROCESSfzl-start-exo-process"
;     "PROCESSfzl-start-exo-process"
;     (concat **FZL_HOME_SERVER** "bin/fzl-exo-run.sh"))))

;(defun fzl-stop-exo()
;    (progn
;    ;;(split-window-below)
;    (fzl-exo-platform-log)    
;    (start-process
;     "PROCESSfzl-stop-exo-process"
;     "PROCESSfzl-stop-exo-process"
;     (concat **FZL_HOME_SERVER** "bin/fzl-exo-stop.sh"))))


;(defun fzl-exo-open-in-browser()
;  (start-process
;   "PROCESS-fzl-exo-open-in-browser"
;   "PROCESS-fzl-exo-open-in-browser"
;   "firefox"
;   "http://localhost:8080/portal/"))

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



;;;;;;;;;;;;;;;;  C/C++ 
(defun fzl-list-c/c++header-files-directories()
  "list where are .h files are located on"
  ;;gcc -v -E - < /dev/null
  )

;;;;;;;;;;;;;;;;  shell function utils
;;FROM: https://stackoverflow.com/questions/6532998/how-to-run-multiple-shells-on-emacs
(defun fzl-new-shell (shell_name)
  (let ((currentbuf (get-buffer-window (current-buffer)))
        (newbuf     (generate-new-buffer-name shell_name)))
    (generate-new-buffer newbuf)
    (set-window-dedicated-p currentbuf nil)
    (set-window-buffer currentbuf newbuf)
    (shell newbuf)))

(defun fzl-shell(workDir)
  (let ((default-directory workDir))
    (shell workDir)))





(defun fzl-get-image-from-url (url filename)
  (shell-command (concat "wget -O " filename " " url))
  (org-redisplay-inline-images))



;(defun fzl-set-default-directory-to-FZL_HOME-etc() 
;  'set default directory to FZL_HOME etc' 
;  (interactive)
;  (setq default-directory (concat *FZL_HOME* "/etc"))
;  (speedbar-refresh))

;(defun fzl-bash-find-files-with-grep (dir, grepPattern)
;  "find dir -type f -exec grepPattern -l {} ';'"
;  (interactive "sdir a ser pesquisado: \nsgrepPattern: ")
;   (message (shell-command-to-string
;    (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"))))

;(defun fzl-bash-find-files-by-name-pattern (dir, namePattern)
;  "find dir -type f -name '*namePattern'"
;  (interactive "sdir to be searched: \nsnamePattern: ")
;   (message (split-string (shell-command-to-string
;    (format "find %s -type f -name '*namePattern*'")))))

;;;;________________________________________
;;;
;;; MAVEN
;;; 
;;; 
;;;________________________________________
(defun fzl-maven-settings()
  "Open maven settings.xml."
  (interactive)
  (message (concat **M2_HOME** "/conf/settings.xml"))
  (find-file (concat **M2_HOME** "/conf/settings.xml")))


;;;;________________________________________
;;;
;;; Config Files
;;; 
;;; 
;;;________________________________________
(defun fzl-open-gradle-properties-file()
  "Open ~/.gradle/gradle-properties."
  (interactive)
  (find-file "~/.gradle/gradle.properties")
  )

(defun fzl-docker-service()
  "Open docker-service systemd unit file."
  (interactive)
  (fzl-find-file-as-root "/usr/lib/systemd/system/docker.service"))

(defun fzl-ansible-service()
  "Open docker-service systemd unit file."
  (interactive)
  (fzl-find-file-as-root "/etc/ansible/ansible.cfg"))

(defun fzl-docker-storage-setup()
  "open docker-storage-setup file"
  (interactive)
  (fzl-find-file-as-root "/etc/sysconfig/docker-storage-setup"))

(defun fzl-open-ifcfg-enp2s0-file()
  "open docker-storage-setup file"
  (interactive)
  (fzl-find-file-as-root "/etc/sysconfig/network-scripts/ifcfg-enp2s0"))

(defun fzl-open-resolv-conf-file()
  "open docker-storage-setup file"
  (interactive)
  (fzl-find-file-as-root "/etc/resolv.conf"))


(defun fzl-mariadb-service()
  "open docker-service systemd unit file"
  (interactive)
  (fzl-find-file-as-root "/usr/lib/systemd/system/mariadb.service"))


;;;;________________________________________
;;;
;;; Code Section
;;; 
;;; 
;;;________________________________________


(defun fzl-nexus-settings-xml()
  "open the wrapper.log nexus file"
  (interactive)
  (find-file (concat **NEXUS_HOME** "/config/settings.xml")))

(defun fzl-nexus-url()
  "open nexus welcome url"
  (interactive)
  (shell-command "firefox http://localhost:8081/#browse/welcome"))



;;;;________________________________________
;;;
;;; emacsinitfile
;;; 
;;; 
;;;________________________________________
(defun fzl-open-log-emacsinitfile-logs()
  "open emacsinitfile log"
  (interactive)
  (find-file **EMACSINITFILE_LOG_FILE**))


                                                                   
(provide 'fzl-functions)
;;; fzl_functions.el ends here


