(provide 'config_eclipse)
;;https://github.com/senny/emacs-eclim

(custom-set-variables
 '(eclim-eclipse-dirs '(**ECLIPSE_MODELING_HOME**))) ;;'(eclim-executable "~/nonStandard/eclipse/eclim"))



(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)



;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)



(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)




(require 'eclim)
(global-eclim-mode)

;;If you want to control eclimd from emacs, also add:

(require 'eclimd)
;;(start-eclimd)

