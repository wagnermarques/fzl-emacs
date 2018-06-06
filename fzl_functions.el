(provide 'fzl_functions)

;;**GLOBAL_VARS** is all defined in  global_variables_setup.el file


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

;;(fzl-mutt()
;;         (fzl-run-prg-in-ansi-term "/usr/bin/mutt"))





;;;________________________________________
;;;
;;; sqlite
;;; 
;;; 
;;;________________________________________

(defun fzl-sqlite-open-in-shell-buffer()
  (interactive)
  (start-process
   "ProcessName_FzlStartSqlite"
   "BufferName__FzlStartSqlite"
   "sqlite3"
   (concat **FZL_HOME** "/integrated/dbs/sqlite")))


(defun fzl-open-url-in-browser(url)
  "Open url in browser"
  (interactive "s")
  (progn
    (start-process
     "ProcessNameForFzlOpenUrlInBroserFunction"
     nil
     "firefox"
     url)))




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
   (concat **ANDROID_HOME** "/tools/android list avd")
   ""
  ))

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
;;; emacsinitfile
;;;________________________________________

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

(defun fzl-git-config-set-http-proxy()
  ""
  (start-process
   "PROCESS-fzl-git-config-set-http-proxy"
   "PROCESS-fzl-git-config-set-http-proxy"
   "git"
   "--global --set http.proxy http://wagner:nicolas1*@192.168.0.2:3128"))

(defun fzl-git-config-UNset-http-proxy()
  ""
    (start-process
   "PROCESS-fzl-git-config-UNset-http-proxy"
   "PROCESS-fzl-git-config-UNset-http-proxy"
   "git"
   "--global --unset http.proxy"))

(defun fzl_shell_command(CMD)
  "Like shell-command-to-string but save output in cmdOutput variable and returns its. (fzl_shell_command 'echo $(pwd)'"
  (interactive)
  (progn
    (setq cmdOutput
          (substring 
           (shell-command-to-string CMD) 
           0 -1))
    (message cmdOutput)))

;;TODO...
(defun fzl-az-login()

  )


;;;________________________________________
;;;
;;; nodejs
;;; 
;;; 
;;;________________________________________
;;https://docs.npmjs.com/cli/config
(defun nodejs-npm-config-list()
  (message "todo"))
(defun fzl-containers-nodejs-npm-config-list()
  (message "todo"))
(defun fzl-containers-nodejs-sudo-npm-i-g-npm-to-update()
  (message "todo"))



;;;________________________________________
;;;
;;; Eclipse
;;;________________________________________
;;;osgi.instance.area {-data}
;;;    the instance data location for this session.
;;;    Plug-ins use this location to store their data. For example, the Resources plug-in uses this as the default location for projects (aka the workspace).
;;;    See the section on locations for more details.
;;;    https://help.eclipse.org/neon/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Freference%2Fmisc%2Fruntime-options.html&anchor=osgiinstancearea
(defun fzl-start-eclipse-modeling()
  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
  (start-process
     "PROCESS-fzl-start-eclipse-modelling"
     "PROCESS-fzl-start-eclipse-modelling"
     (concat **FZL_HOME** "/integrated/ides/eclipse-java-oxygen-R-linux-gtk-x86_64/eclipse/eclipse")))
  
(defun fzl-start-eclipse-java-oxigen()
  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
  (start-process
     "PROCESS-fzl-start-eclipse-java-oxigen"
     "PROCESS-fzl-start-eclipse-java-oxigen"
     (concat **FZL_HOME** "/integrated/ides/eclipse-java-oxygen-3a-linux-gtk-x86_64/eclipse")))

(defun fzl-start-eclipse-jee-java-oxigen()
  ;;(start-process-shell-command "PROCESS-start-eclipse-modeling" (concat **FZL_HOME** "bin/fzl_start_eclipse.sh"))))
  (start-process
     "PROCESS-fzl-start-eclipse-java-oxigen"
     "PROCESS-fzl-start-eclipse-java-oxigen"
     (concat **FZL_HOME** "/integrated/ides/eclipse-jee-oxygen-2-linux-gtk-x86_64/eclipse")))



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
  

(message (concat (concat (concat "cd '" **FZL_HOME**) "'") " && ./bin/fzl_start_nexus.sh"))
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




(defun fzl-start-exo()
  "https://www.exoplatform.com/docs/public/index.jsp?topic=%2FPLF43%2FPLFUserGuide.GettingStarted.html"
  (progn
    ;;(split-window-below)
    (fzl-exo-platform-log)    
    (start-process
     "PROCESSfzl-start-exo-process"
     "PROCESSfzl-start-exo-process"
     (concat **FZL_HOME_SERVER** "bin/fzl-exo-run.sh"))))

(defun fzl-stop-exo()
    (progn
    ;;(split-window-below)
    (fzl-exo-platform-log)    
    (start-process
     "PROCESSfzl-stop-exo-process"
     "PROCESSfzl-stop-exo-process"
     (concat **FZL_HOME_SERVER** "bin/fzl-exo-stop.sh"))))


(defun fzl-exo-open-in-browser()
  (start-process
   "PROCESS-fzl-exo-open-in-browser"
   "PROCESS-fzl-exo-open-in-browser"
   "firefox"
   "http://localhost:8080/portal/"))

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



(defun fzl-set-default-directory-to-FZL_HOME-etc() 
  'set default directory to FZL_HOME etc' 
  (interactive)
  (setq default-directory (concat *FZL_HOME* "/etc"))
  (speedbar-refresh))

(defun fzl-bash-find-files-with-grep (dir, grepPattern)
  "find dir -type f -exec grepPattern -l {} ';'"
  (interactive "sdir a ser pesquisado: \nsgrepPattern: ")
   (message (shell-command-to-string
    (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"))))

(defun fzl-bash-find-files-by-name-pattern (dir, namePattern)
  "find dir -type f -name '*namePattern'"
  (interactive "sdir to be searched: \nsnamePattern: ")
   (message (split-string (shell-command-to-string
    (format "find %s -type f -name '*namePattern*'")))))

;;eclipse modelling
(defun fzl-eclipse-modeling--start()
  "start eclipse modelling"
  (interactive)
  (message "(defun start_eclipse()...")
  (shell-command-to-string
   "/home/administrador/progsativos/fzlbpms/integrated/eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/eclipse"))

(defun fzl-eclipse-modeling--wrksp-dired-find-file()
  "list files in eclipse modelling workspace"
  (interactive)
  (message "(defun fzl-eclipse-modeling--wrksp-list-files()...")
  (dired-find-file
   "/home/administrador/progsativos/fzlbpms/wrksp-eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/"))

(defun fzl-eclipse-modeling--wrksp-log()
  "show error log"
  (interactive)
  (message "(defun fzl-eclipse-modeling--error-log()...")
  (find-file
   "/home/administrador/progsativos/fzlbpms/wrksp-eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/.metadata/.log"))




(defun fzl-eclipse-reporting--start()
  "start eclipse reporting"
  (interactive)
  (message "(defun start_eclipse()...")
  (shell-command-to-string
   "/home/administrador/progsativos/fzlbpms/integrated/eclipse/eclipse-reporting-mars-1-linux-gtk-x86_64/eclipse"))


(defun fzl-maven-settings()
  "open maven settings.xml"
  (interactive)
  (message (concat **M2_HOME** "/conf/settings.xml"))
  (find-file (concat **M2_HOME** "/conf/settings.xml")))

(defun fzl-open-log-emacsinitfile-logs()
  "open emacsinitfile log"
  (interactive)
  (find-file **EMACSINITFILE_LOG_FILE**))

(defun fzl-nexus-settings-xml()
  "open the wrapper.log nexus file"
  (interactive)
  (find-file (concat **NEXUS_HOME** "/config/settings.xml")))

(defun fzl-nexus-url()
  "open nexus welcome url"
  (interactive)
  (shell-command "firefox http://localhost:8081/#browse/welcome"))


;;;;;;;;;;FIND FILES
(defun fzl-open-bookmark-emacs-configuration-files()
  "open-initel-file"
  (interactive)
  (find-file (concat *fzl_dot_emacs_dir*  "/find_files.el"))
)

(defun fzl-open-code-config-files()
  (interactive)
  "open code configurations files"
  (find-file (concat **fzl_dot_emacs_dir**  "/yasnippet_config.el"))
)
                                                                   
;(fzl-open-initel-file)
;(fzl-open-yasnippet-config)
;(fzl-open-yasnippet-el)
;(fzl-open-find_file_functions)









;(defun svt-find-grep (sDiretorio, sGrepPattern)
;  "find dir -type f -exec grepIt -l {} ';'"
;  (interactive "sDiretorio a ser pesquisado \nsGrepPattern")
;  (shell-command-to-string
;   (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"
;           (expand-file-name dir t) 
;           (sGrepPattern))))


;(defun svt-find-and-grep-files (dir, grepIt)
;  "find dir -type f -exec grepIt -l {} ';'" 
; (shell-command-to-string
;    (format "find %s -type f -exec grep %s {} ';'"
;            (expand-file-name dir t) grepIt)));


;(svt-find-and-grep-files "." "auto-complete-config")

;(message (exec-to-string "pwd"))
;(defun multiple-hello (someone num)
;  "Say hello to SOMEONE via M-x hello, for NUM times."
;  (interactive "sWho do you want to say hello to? \nnHow many times? ")
;  (dotimes (i num)
;    (insert (format "Hello %s!\n" someone))))


;http://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Sequences.html


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; fzlbpms functions definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(defun open-fzlbpms-initfile ()
; "open emacs init file"
; (find-file " /run/media/wagner/Mass memory/fzlbpms/etc/emacs/checkouts/emacsinitfile/init.el"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C U S T O M I Z A N D O A S M E S S A G E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;credits of (defun what-line ()
;http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/what_002dline.html
;(defun line-num ()
; "Print the current line number (in the buffer) of point."
; (save-restriction
; (widen)
; (save-excursion
; (beginning-of-line)
; (1+ (count-lines 1 (point))))))
;(message (line-num))
;(concatenate 'stringc "abcd" "efg")
;(message 'stringc)

;(defun fzl-string-message (strMsg)
; (setq buffer_name (buffer-name))
; (setq line_num (line-num))
; (setq msg_prefix (concat buffer_name line_num))
; ;(message (concat msg_prefix strMsg))
;)

;;;;temp(fzl-string-message "mensagem..." )

;(defun fzl-string-message (strMsg)
; (message (concat
;         (get-buffer-name) strMsg)))
;
;(defun fzl-list-message (listMsg)
; (message "init.el (list message) -> %S" listMsg))

;(fzl-string-message "printin string mensagem...")
;(fzl-list-message (1 2 3 4))



;(defun fzl-task-manager-file ()
; " abre arquivo de configuracao do emacs do fzlbpms
; The function is poorly named, didn't really want to 'load' it, just open it."
; (interactive)
; (find-file (concat *FZL_HOME* "/workspaces/administrador/tasks.org"))
;)

;(defun fzl-guia-de-instalacao ()
; " abre guia de instalação do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms_guia_de_instalacao"))
;)


;(defun fzl-documentacao ()
; " abre arquivo de documentacao do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms_documentacao"))
;)

;(defun fzl-calendar-controller ()
; " abre arquivo calendar controller"
; (interactive)
; (find-file (concat *FZL_HOME* "/workspaces/ant_projects/fzlbpms_ant_projects_enviroment/libjs/fzlViews/calendar/calendarController.js"))
;)

;(defun fzl-configurar-orbeon()
; " abre arquivo calendar controller"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-orbeon.org"))
;)

;(defun fzl-configurar-maven()
; " abre arquivos de configuracao do maven"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-maven.org"))
;)


;(defun fzl-configurar-existdb()
; " abre arquivos de configuracao do existdb"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-existdb.org"))
;)



;(defun fzl-configurar-tomcat7()
; " abre arquivos de configuracao do tomcat7"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-tomcat7.org"))
;)

;(defun fzl-configurar-liferay()
; " abre arquivos de configuracao do liferay"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-liferay.org"))
;)


;(defun fzl-comandos()
; " abre arquivo de comandos do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms-comandos.org"))
;)

;(defun fzl-bookmark()uff
; " abre arquivo de bookmark"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms-bookmark.org"))
;)






;;; UTILITY FUNCTION FOR MESSAGE
;Directive Interpretation
; --------- --------------
; ~% new line
; ~& fresh line
; ~| page break
; ~T tab stop
; ~< justification
; ~> terminate ~<
; ~C character
; ~( case conversion
; ~) terminate ~(
; ~D decimal integer
; ~B binary integer
; ~O octal integer
; ~X hexadecimal integer
; ~bR base-b integer
; ~R spell an integer
; ~P plural
; ~F floating point
; ~E scientific notation
; ~G ~F or ~E, depending upon magnitude
; ~$ monetary
; ~A legibly, without escapes
; ~S READably, with escapes
; ~~ ~

;;; format t
;https://github.com/m2ym/auto-complete

;(defun fzl-message (msg)
; (message
; (format t         
;         "init.el -> %s" "msg")))
;(defun fzl-string-message (strMsg)
 ; (format t "~A" strMsg ))


;(message (fzl-string-message "CARREGADO COM SUCESSO"))


; (let ((groceries '(eggs bread butter carrots)))
; (format t "~{~A~^, ~}.~%" groceries) ; Prints in uppercase
; (format t "~@(~{~A~^, ~}~).~%" groceries)) ; Capitalizes output
 ;; ⇒ EGGS, BREAD, BUTTER, CARROTS.
 ;; ⇒ Eggs, bread, butter, carrots.

(provide 'fzl_customization_functions)








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; fzlbpms functions definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(defun open-fzlbpms-initfile ()
;  "open emacs init file"
;  (find-file " /run/media/wagner/Mass memory/fzlbpms/etc/emacs/checkouts/emacsinitfile/init.el"))


;(defun myCommand ()
;  "One sentence summary of what this command do.

;More details here. Be sure to mention the return value if relevant.
;Lines here should not be longer than 70 chars,
;and don't indent them."
;  (interactive)
;  (let (localVar1 localVar2 …)
;    (setq localVar1 …)
;    (setq localVar2 …)
;    ;; do something …
;  )
;)







;;; UTILITY FUNCTION FOR MESSAGE
;Directive   Interpretation
;  ---------   --------------
;     ~%       new line
;     ~&       fresh line
;     ~|       page break
;     ~T       tab stop
;     ~<       justification
;     ~>       terminate ~<
;     ~C       character
;     ~(       case conversion
;     ~)       terminate ~(
;     ~D       decimal integer
;     ~B       binary integer
;     ~O       octal integer
;     ~X       hexadecimal integer
;     ~bR      base-b integer
;     ~R       spell an integer
;     ~P       plural
;     ~F       floating point
;     ~E       scientific notation
;     ~G       ~F or ~E, depending upon magnitude
;     ~$       monetary
;     ~A       legibly, without escapes
;     ~S       READably, with escapes
;     ~~       ~

;;; format t
;https://github.com/m2ym/auto-complete

;(defun fzl-message (msg)
;  (message 
;   (format t 	 
;	   "init.el -> %s" "msg")))
;(defun fzl-string-message (strMsg)  
 ;  (format t "~A" strMsg ))


;(message (fzl-string-message "CARREGADO COM SUCESSO"))


; (let ((groceries '(eggs bread butter carrots)))
;   (format t "~{~A~^, ~}.~%" groceries)         ; Prints in uppercase
;   (format t "~@(~{~A~^, ~}~).~%" groceries))   ; Capitalizes output
 ;; ⇒ EGGS, BREAD, BUTTER, CARROTS.
 ;; ⇒ Eggs, bread, butter, carrots.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C U S T O M I Z A N D O   A S    M E S S A G E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;credits of (defun what-line ()
;http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/what_002dline.html
;(defun line-num ()
;       "Print the current line number (in the buffer) of point."
;       (save-restriction
;         (widen)
;         (save-excursion
;           (beginning-of-line)           
;                    (1+ (count-lines 1 (point))))))
;(message (line-num))
;(concatenate 'stringc "abcd" "efg")
;(message 'stringc)

;(defun fzl-string-message (strMsg) 
;  (setq buffer_name (buffer-name))
;  (setq line_num (line-num))
;  (setq msg_prefix (concat buffer_name line_num))
;  ;(message (concat msg_prefix strMsg))
;)

;;;;temp(fzl-string-message "mensagem..." )

;(defun fzl-string-message (strMsg)
;  (message (concat 
;	    (get-buffer-name)  strMsg)))
;
;(defun fzl-list-message (listMsg)
;  (message "init.el (list message) -> %S" listMsg))

;(fzl-string-message "printin string mensagem...")
;(fzl-list-message (1 2 3 4))




;;f u n c s para abrir arquivos de build/exportacao
;(defun fzl-dev-edit-file-exportar_fzlbpms()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/exportar_fzlbpms.sh"))
;)
;(defun fzl-dev-edit-file-fzlfn_exportadir_etc()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_etc.sh"))
;)
;(defun fzl-dev-edit-file-fzlfn_exportadir_bin()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_bin.sh"))
;)
;(defun fzl-dev-edit-file-fzlbpms_utils___shared_functions()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___shared_functions.sh"))
;)
;(defun fzl-dev-edit-file-fzlbpms_utils___handle_script_parameters()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___handle_script_parameters.sh"))
;)



;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
;(defun fzl-dev-edit-binproject-file-fzl_svn_status()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_status.sh"))
;)                                                               
;(defun fzl-dev-edit-binproject-file-fzl_svn_co_fzlbms_bin()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_co_fzlbms_bin.sh"))
;)
;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
;(defun fzl-dev-edit-binproject-files-envconfig-envsetup-and-fzl_startup()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_startup.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_config.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_env.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_paths.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_variables.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup_runner.c"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_utils.sh"))
;)



;(defun fzl-task-manager-file ()
;  " abre arquivo de configuracao do emacs do fzlbpms
;    The function is poorly named, didn't really want to 'load' it, just open it."
;  (interactive)
;  (find-file  (concat *FZL_HOME* "/workspaces/administrador/tasks.org"))
;)

;(defun fzl-guia-de-instalacao ()
;  " abre guia de instalação do  fzlbpms"
;  (interactive)
;  (find-file  (concat *FZL_HOME* "/fzlbpms_guia_de_instalacao"))
;)


;(defun fzl-documentacao ()
;  " abre arquivo de documentacao do fzlbpms"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms_documentacao"))
;)

;(defun fzl-calendar-controller ()
;  " abre arquivo calendar controller"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/workspaces/ant_projects/fzlbpms_ant_projects_enviroment/libjs/fzlViews/calendar/calendarController.js"))
;)

;(defun fzl-configurar-orbeon()
;  " abre arquivo calendar controller"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-orbeon.org"))
;)

;(defun fzl-configurar-maven()
;  " abre arquivos de configuracao do maven"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-maven.org"))
;)


;(defun fzl-configurar-existdb()
;  " abre arquivos de configuracao do existdb"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-existdb.org"))
;)



;(defun fzl-configurar-tomcat7()
;  " abre arquivos de configuracao do tomcat7"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-tomcat7.org"))
;)

;(defun fzl-configurar-liferay()
;  " abre arquivos de configuracao do liferay"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-liferay.org"))
;)


;(defun fzl-comandos()
;  " abre arquivo de comandos do fzlbpms"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms-comandos.org"))
;)

;(defun fzl-bookmark()uff
;  " abre arquivo de bookmark"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms-bookmark.org"))
;)




















