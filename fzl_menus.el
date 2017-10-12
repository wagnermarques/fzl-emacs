(provide 'fzl_menus)

(require 'easymenu)

(easy-menu-define djcb-menu global-map "fzlbpms-menu"
  '("FZLBPMS"
    
    ("Emacsinitfile"
     ("Org-mode"
      ["Open org-mode cheat sheet in browser" (progn
                       (start-process
                        "ProcessName=OrgModeCheetSheetInBrowser"
                        "BufferNameForTheProcess=OrgModeCheetSheetInBrowser"
                        "firefox"
                        "http://orgmode.org/orgcard.pdf"))])
     
     ("Shell"
      ["Open Shell in Maven Projects Workspaces" (fzl-shell-maven-projects-workspace)])
     

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
      ["Listar Pacotes Instalados e Disponiveis in Another Buffer (sdkmanager --list)" (fzl-android-sdkmanager-open    )])
     ("Maven"
      ["Maven (settings)"  (fzl-maven-settings)])
     ("Nexus"
      ["Nexus (start)"  (fzl-start-nexus)]
      ["Nexus (Open in Firefox)"  (fzl-nexus-open-in-firefox)]
      ["Nexus (settings)"  (fzl-nexus-settings-xml)]
      ["Nexusk
 (online documentation)"  (shell-command " firefox https://books.sonatype.com/nexus-book/3.0/reference/index.html")]     
      ["Nexus (start)"  (djcb-term-start-or-switch "mutt" t)])
     ("Eclipse"
      ["Eclipse Java"    (djcb-term-start-or-switch "mc" t)]
      ["Eclipse Modelling (start)"  (fzl-start-eclipse-modeling)]
      ["Eclipse Report" (fzl-eclipse-reporting--start)]))
  
     ;; http://emacs-fu.blogspot.com/2009/03/math-formulae-in-webpages.html
     ;; this submenu is only visible when in html-mode or html-helper-mode
    ("fzlServer"
     ("ApacheDs"
      ["ApacheDS (start)" (fzl-start-apacheds)]
      ["ApacheDS (stop)" (fzl-stop-apacheds)]
      ["ApacheDS Studio (start)" (fzl-start-apacheds-studio)])
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
