(provide 'eclim_config)

;;https://github.com/emacs-eclim/emacs-eclim
(require 'eclim)
(setq eclimd-autostart t)

(defun my-java-mode-hook ()
    (eclim-mode t))

(add-hook 'java-mode-hook 'my-java-mode-hook)

;;Displaying compilation error messages in the echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
;(require 'ac-emacs-eclim-source)
;(ac-emacs-eclim-config)

;;Configuring company-mode
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

;/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/fzlbpms/fzlStudio
(custom-set-variables
  '(eclim-eclipse-dirs '((concat **FZL_HOME** "/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64/"))
  '(eclim-executable (concat **FZL_HOME** "/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64/eclim"))))


(setq eclim-executable (concat **FZL_HOME** "/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64/eclim"))

  
  ;;(start-eclimd)
  ;;http://eclim.org/eclimd.html
  ;;starting up eclimd
  (start-process
   "PROCESS-start-eclimd"
   "PROCESS-start-eclipd"
   (concat **FZL_HOME** "/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64/eclimd")
   "")


  
  
;;Refs
;;http://www.goldsborough.me/emacs,/java/2016/02/24/22-54-16-setting_up_emacs_for_java_development/
