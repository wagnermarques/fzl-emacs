(print "===>config-langtool.el running...")

(use-package langtool
  :ensure t
  :config
  (setq langtool-language-tool-jar (getenv "FZLEMACS_INTEGRATION_LANGUAGETOOL_COMMANDLINE_JAR"))
  ;;  Default language is detected by LanguageTool automatically.
  ;;  Please set `langtool-default-language` if you need specific language.
  ;;(setq langtool-default-language "en-US")
  ;;(setq langtool-default-language "pt-BR")
  (require 'langtool)
  :bind (("\C-x4w" . langtool-check)
         ("\C-x4W" . langtool-check-done)
         ("\C-x4l" . langtool-switch-default-language)
         ("\C-x44" . langtool-show-message-at-point)
         ("\C-x4c" . langtool-interactive-correction)))


;;in case you need configure langtool-java-classpath....
;;(setq langtool-java-classpath
;;          "/usr/share/languagetool:/usr/share/java/languagetool/*")
 
;;in case you need a specific java executable 
;;* Currently GNU java version is not working.
;;  Please change the variable to your favorite java executable.

;;* Maybe you want to specify your mother tongue.
;;(setq langtool-mother-tongue "en")


;; in case some specific mode configuration is needed
;;* To customize LanguageTool commandline arguments.
;;
;;    (setq langtool-java-user-arguments '("-Dfile.encoding=UTF-8"))
;;
;;  You can also make the variable to buffer local like following:
;;
;;    (add-hook '**SOME**-mode-hook
;;              (lambda () (set (make-local-variable 'langtool-java-user-arguments)
;;                             '("-Dfile.encoding=UTF-8"))))


;;;(use-package org
;;  :ensure t
;;  :hook (org-mode . (lambda ()
;;                      (langtool-setup)
;;                      (langtool-enable)
;;                      (langtool-check-enable))))


;;
;;## Usage:
;;
;;* To check current buffer and show warnings.
;;
;;    M-x langtool-check
;;
;;  Check with different language.  You can complete supported language
;;  with C-i/TAB
;;
;;    C-u M-x langtool-check
;;
;;* To correct marker follow LanguageTool suggestions.
;;
;;    M-x langtool-correct-buffer
;;
;;* Go to warning point you can see a report from LanguageTool.
;;  Otherwise:
;;
;;    M-x langtool-show-message-at-point

(provide 'config-langtool)
