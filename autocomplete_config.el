
(provide 'autocomplete_config)

(require 'auto-complete-config) ;https://github.com/auto-complete/auto-complete/issues/26

;;ac-dictionary-directories
;(add-to-list 'ac-dictionary-directories (concat *FZL_HOME* "/etc/emacs/auto-complete-1.3.1/byte-compiled/dict"))

(add-to-list 'ac-dictionary-directories 
             (concat *fzl_emacs_packages* "/auto-complete-1.3.1/byte-compiled/dict"))
(ac-config-default)



;https://github.com/auto-complete/auto-complete/issues/26
;(require 'auto-complete-config) 

;(add-to-list 'ac-dictionary-directories 
;             (concat *SVT_HOME* "etc/emacs/sitelisp/emacsinitfile/auto-complete/dict"))


(ac-config-default)


;autocomplete for xml
;https://github.com/aki2o/auto-complete-nxml

;lisp
(require 'auto-complete-nxml)

;; Keystroke for popup help about something at point.
(setq auto-complete-nxml-popup-help-key "C-:")

;; Keystroke for toggle on/off automatic completion.
(setq auto-complete-nxml-toggle-automatic-key "C-c C-t")

;; If you want to start completion manually from the beginning
(setq auto-complete-nxml-automatic-p nil)



