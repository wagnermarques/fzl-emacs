(provide 'fzl_menu)

(require 'easymenu)
(easy-menu-define djcb-menu global-map "fzlbpms-menu"
  '("FZLBPMS"
     ;; http://emacs-fu.blogspot.com/2008/12/running-console-programs-inside-emacs.html
    ("fzlStudio" ;; submenu
     ["Maven (settings)"  (fzl-maven-settings)]
     ["Nexus (start)"  (fzl_start_nexus)]
     ["Nexus (settings)"  (fzl-nexus-settings-xml)]     
     ["Nexus (start)"  (djcb-term-start-or-switch "mutt" t)]
     ["Eclipse Java"    (djcb-term-start-or-switch "mc" t)]
     ["Eclipse Modelling"  (fzl-eclipse-modeling--start)]
     ["Eclipse Report" (fzl-eclipse-reporting--start)])
  
     ;; http://emacs-fu.blogspot.com/2009/03/math-formulae-in-webpages.html
     ;; this submenu is only visible when in html-mode or html-helper-mode
     ("fzlServer"  :visible (or (string= major-mode "html-helper-mode") (string= major-mode "html-mode"))
       ["Insert formula"   texdrive-insert-formula :help "Insert some formula"]
       ["Generate images"  texdrive-generate-images :help "(Re)generate the images for the formulae"])
     
     ;; http://emacs-fu.blogspot.com/2009/03/twitter.html
     ("fzlBI" ;; submenu
       ["View friends" twitter-get-friends-timeline]
       ["What are you doing?" twitter-status-edit])

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
       ["Toggle full-screen" djcb-fullscreen-toggle])))))
