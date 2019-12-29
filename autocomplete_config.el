(fzl/log "autocomplete_config.el loaded sucessfully!")
(provide 'autocomplete_config)


(require 'auto-complete)
(require 'auto-complete-config) ;https://github.com/auto-complete/auto-complete/issues/26
(ac-config-default)


;;from: https://emacs.stackexchange.com/questions/22556/auto-complete-c-headers-just-works-with-c-no-result-with-c
(defun fzl:ac-ac-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (setq achead:include-directories
        (append '("/usr/include/c++/4.8"
                  "/usr/include/x86_64-linux-gnu/c++/4.8"
                  "/usr/include/c++/4.8/backward"
                  "/usr/lib/gcc/x86_64-linux-gnu/4.8/include"
                  "/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed"
                  "/usr/include/x86_64-linux-gnu")
                achead:include-directories)))
(add-hook 'c++-mode-hook 'fzl:ac-ac-header-init)
(add-hook 'c-mode-hook 'fzl:ac-ac-header-init)
  


;;https://www.youtube.com/watch?v=HTUE03LnaXA
;(defun fzl:ac-ac-header-init()
;   (require 'auto-complete-c-headers)
;   (add-to-list 'ac-sources 'ac-sources-headers))
;                                              
;(add-hook 'c++-mode-hook 'fzl:ac-ac-header-init)
;(add-hook 'c-mode-hook 'fzl:ac-ac-header-init)

;;ac-dictionary-directories
;(add-to-list 'ac-dictionary-directories (concat *FZL_HOME* "/etc/emacs/auto-complete-1.3.1/byte-compiled/dict"))

; using default dic in
; /home/administrador/fzlbpms/fzlbpms/etc/emacs/elpa/auto-complete-20150408.1132/dict
;(add-to-list 'ac-dictionary-directories 
;             (concat *fzl_emacs_packages* "/auto-complete-1.3.1/byte-compiled/dict"))
;(ac-config-default)



;https://github.com/auto-complete/auto-complete/issues/26
;(require 'auto-complete-config) 

;(add-to-list 'ac-dictionary-directories 
;             (concat *SVT_HOME* "etc/emacs/sitelisp/emacsinitfile/auto-complete/dict"))


;autocomplete for xml
;https://github.com/aki2o/auto-complete-nxml

;lisp
;(require 'auto-complete-nxml)

;; Keystroke for popup help about something at point.
;(setq auto-complete-nxml-popup-help-key "C-:")

;; Keystroke for toggle on/off automatic completion.
;(setq auto-complete-nxml-toggle-automatic-key "C-c C-t")

;; If you want to start completion manually from the beginning
;(setq auto-complete-nxml-automatic-p nil)



