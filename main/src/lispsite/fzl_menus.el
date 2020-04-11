;;; package --- Summary
;;; Code:

;;; Commentary:

(provide 'fzl_menus)

(require 'easymenu)

(easy-menu-define djcb-menu global-map "HOST"
  '("HOST"
    ("Config" ;;submenu
     ("Etc"
      ["/etc/selinux/config" fzl-find-file-as-root-selinuxconfig]
))))


(easy-menu-define djcb-menu global-map "fzlbpms-menu"
  '("FZLBPMS"
    ("Utils"
     ["wkhtmltopdf" fzl-html2pdf])
    ("Containers" ;; submenu
     ("Logs"
      ["Host: journalctl -u docker.service" fzl-journalctl-docker-service])
     ("maven"
      ["open nexus in browser" fzl-containers-maven-open-nexus-in-browser]
      ["open mvn settings" fzl-containers-maven-open-mvn-settings-file]
      ["restart container" fzl-containers-maven-restart-container]
      ["shell at mvnprojects" (fzl-shell (concat **maven_container_home** "/../data-dir-for-maven/mvnprojects"))])
     ("Nodejs"
      ["npm config list" fzl-containers-nodejs-npm-config-list]
      ["npm config list" fzl-containers-nodejs-npm-config-list]
      ["sudo npm i -g npm to update" fzl-containers-nodejs-sudo-npm-i-g-npm-to-update]
      ["shell at nodejs_projects" (fzl-shell (concat **maven_container_home** "/../data-dir-nodejs/node_projects"))])
     ("Tomcat8"
      ["open tomcat8 admin in browser" fzl-containers-tomcat8-open-admin-in-browser]
      ["tail -f catalina.out" fzl-containers-tomcat8-tail-f-catalina-out]))
    
    ("Desktop" ;; submenu
     ("Azure"
     ["az login" fzl-az-login])
     ["Rclone sync GDrive_wgn:/ 2 Desktop" rclone_sync_from_gdrive_to_desktop]
     ["Rclone sync Desktop to GDrive_wgn" rclone_sync_from_desktop_to_gdrive]
     ("Nodejs"
      ["List config (TODO)" nodejs-npm-config-list]))
   
    ("Emacsinitfile"
     ("simple httpd & impacient mode"
      ["open http://localhost:9191"
       (fzl-open-http-localhost-9191)])
       
     ("Org-mode"
      ["Export Beamer" fzl-orgmode-export-beamer-to-pdf]
      ["Open org-mode cheat sheet in browser" (progn
                       (start-process
                        "ProcessName=OrgModeCheetSheetInBrowser"
                        "BufferNameForTheProcess=OrgModeCheetSheetInBrowser"
                        "firefox"
                        "http://orgmode.org/orgcard.pdf"))])
     
     ("Shell"
      ["Open Shell in Maven Projects Workspaces" (fzl-shell-maven-projects-workspace)])
     ("Email Client Mutt"
      ["Open mutt in ansi-term" (fzl-mutt)])

     ("Urls"
      ["github" (fzl-github-open)])

     ("Change Dir"
      ["emacsinitfile (TODO)" (fzl-speedbar-change-dir-to-emacsinitifle)]
      ["fzlStudio/bin (TODO)" (fzl-speedbar-change-dir-to-fzlStudio-bin)]
      ["fzlServer/bin (TODO)" (fzl-speedbar-change-dir-to-fzlServer-bin)]
      )

     ("Logs"
      ["emacsinitfile.log (open)" (fzl-open-emacsinitfile-log)]
      ["fzlbpms.log (open)" (fzl-open-fzlbpms-log)]))

     ;; http://emacs-fu.blogspot.com/2008/12/running-console-programs-inside-emacs.html
    ("fzlStudio"
     ("Emacs"
      ["Find file in project Esc-f (kbd \\ef)" (find-file-in-project)])

     ("R"
      ["Open R-Studio" (fzl-start-rstudio)])

     ("Android"
      ["Start Android Studio" (fzl-start-android-studio)]
      ["Mostra Variaveis de Ambiente" (fzl-android-show-environment-variables)]
      ["Lista Avds (fzl-android-list-avds)" (fzl-android-list-avds)]
      ["Listar Pacotes Instalados e Disponiveis in Another Buffer (sdkmanager --list)" (fzl-android-sdkmanager-open)])

     ("Config files"
      ["Maven Settings: " (concat **M2_HOME** "/conf/settings.xml")  (fzl-maven-settings)]
      ["Git config: ~/.gitconfig" (find-file "~/.gitconfig")]
      ["docker.service file"  (fzl-docker-service)]
      ["docker-storage-setup file"  (fzl-docker-storage-setup)]
      ["mariadb.service file"  (fzl-mariadb-service)]
      ["~/.gradle/gradle.properties file"  (fzl-open-gradle-properties-file)]
      ["/etc/sysconfig/network-scripts/ifcfg-enp2s0"  (fzl-open-ifcfg-enp2s0-file)]
      ["/etc/resolv.conf"  (fzl-open-resolv-conf-file)]
      )

     ("Log files"
      ["Bonita Tomcat Embedded Server Logs " (fzl-bonita-studio-tomcat-logs-dir)]
      ["Bonita Tomcat .metadata/tomcat.log " (fzl-bonita-studio-tomcat-metadata-tomcat-log)]
      ["**KARAF_HOME**/data/log/karaf.log" (fzl-karaf-karaf-out)]
      )

     ("Git"
      ["Git config --global set http.proxy"  (fzl-git-config-set-http-proxy)]
      ["Git config --global UNSET http.proxy"  (fzl-git-config-UNset-http-proxy)])

     ("Nexus"
      ["Nexus (start)"  (fzl-start-nexus)]
      ["Nexus (Open in Firefox)"  (fzl-nexus-open-in-firefox)]
      ["Nexus (settings)"  (fzl-nexus-settings-xml)]
      ["Nexusk
 (online documentation)"  (shell-command " firefox https://books.sonatype.com/nexus-book/3.0/reference/index.html")]
      ["Nexus (start)"  (djcb-term-start-or-switch "mutt" t)])

     ("IDES"
      ["Camunda modeller" (fzl/start-camunda-modeller)] ;;
      ["Eclipse Jee"    (fzl/start-eclipse-jee)] ;;
      ["Eclipse Java"    (fzl/start-eclipse-java)]
      ["Eclipse Modelling"  (fzl/start-eclipse-modeling)]
      ["Eclipse Report" (fzl/eclipse-reporting--start)]))

     ;; http://emacs-fu.blogspot.com/2009/03/math-formulae-in-webpages.html
     ;; this submenu is only visible when in html-mode or html-helper-mode
    ("fzlServer"
     ("Camunda Server"
      ["fzl/ls-camunda-server-deployed-apps" (fzl/ls-camunda-server-deployed-apps)]
      ["ApacheDS (stop)" (fzl-stop-apacheds)]
      ["ApacheDS Studio (start)" (fzl-start-apacheds-studio)])
     ("ApacheDs"
      ["ApacheDS (start)" (fzl-start-apacheds)]
      ["ApacheDS (stop)" (fzl-stop-apacheds)]
      ["ApacheDS Studio (start)" (fzl-start-apacheds-studio)])
     ("Tomcat8"
      ["Tomcat8 (start)"   (fzl-tomcat8_start_container)]
      ["Tomcat8 (Manager)" (fzl-tomcat8_open_manager) ]
      ["Tomcat8 (catalina-out)" (fzl-tomcat8-catalina-out)])
     ("Mariadb"
      ["Mariadb (start)" (fzl-mariadb-start)])
     
     ("Exo"
      ["Exo (start)" (fzl-start-exo)]
      ["Exo (stop)" (fzl-stop-exo)]
      ["Exo (open in browser)" (fzl-exo-open-in-browser)]
      ["Exo (settings-example)" (fzl-exo-settings-example)]
      ["Exo (settings)" (fzl-exo-settings)]
      ["Exo (logging.properties)" (fzl-exo-logging-properties)]
      ["Exo (configuration.xml)" (fzl-exo-configuration-xml)]
      ["Exo (setenv-customize.sh)" (fzl-exo-setenv-customize-sh)]
      ["Exo (setenv-customize.sample.sh)" (fzl-exo-setenv-customize-sample-sh)]
      ["Exo (idm-configuration.xml)" (fzl-exo-idm-configuration-xml)]
      ["Exo (platform.log)" (fzl-exo-platform-log)]
      );;Exo
     
       ["Insert formula"   texdrive-insert-formula :help "Insert some formula"]
       ["Generate images"  texdrive-generate-images :help "(Re)generate the images for the formulae"])
     
     ;; http://emacs-fu.blogspot.com/2009/03/twitter.html
     ("fzlBI" ;; submenu
       ["View friends" twitter-get-friends-timeline]
       ["What are you doing?" twitter-status-edit])

     ("Google"
      ;;google tools
      ["Open Google Console" (fzl-open-url-in-browser "https://console.developers.google.com/")]
      ["Maps JavaScript API" (fzl-open-url-in-browser "https://developers.google.com/maps/documentation/javascript/?hl=pt-br")]
      )

     ("DojoTookit"
      ;;dojotoolkit links
      ["Site: Nabble Forum" (fzl-open-url-in-browser "http://dojo-toolkit.33424.n3.nabble.com/")]
      ["Dojo2 Github" (fzl-open-url-in-browser "https://github.com/dojo")]
      ["Dojo create " (fzl-open-url-in-browser "https://github.com/dojo")])
     

     ("NodeJs+Typescript+WebPack"
      ;;typescript links
      ["Community samples" (fzl-open-url-in-browser "https://github.com/Microsoft/TypeScriptSamples/")]
      ["Dojo2 Github" (fzl-open-url-in-browser "https://github.com/dojo")]
      ["Site:Nodejs" (fzl-open-url-in-browser "https://nodejs.org/en/)")]
      ["Site:Webpack" (fzl-open-url-in-browser "https://webpack.github.io/")]
      )

     
     
     ("Misc"  ;; submenu
       ;; http://emacs-fu.blogspot.com/2009/01/counting-words.html
      ["Shell" fzl_open_shell_in_a_buffer]
      ["emacsinitfile-log" fzl-open-log-emacsinitfile-logs]

       ;;http://emacs-fu.blogspot.com/2008/12/showing-line-numbers.html
       ["Firefox-FzlWelcome" fzl_start_firefox_at_fzl_welcome_page]

       ;; http://emacs-fu.blogspot.com/2008/12/running-emacs-in-full-screen-mode.html
       ["Toggle full-screen" djcb-fullscreen-toggle])

     ("Urls"  ;; submenu
       ;; http://emacs-fu.blogspot.com/2009/01/counting-words.html
       ["fzlWelcome" djcb-count-words]

       ;;http://emacs-fu.blogspot.com/2008/12/showing-line-numbers.html
       ["Show/hide line numbers" linum]

       ;; http://emacs-fu.blogspot.com/2008/12/running-emacs-in-full-screen-mode.html
       ["Toggle full-screen" djcb-fullscreen-toggle])))
