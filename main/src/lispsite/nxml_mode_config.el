;;; references...
;http://infohost.nmt.edu/tcc/help/pubs/nxml/how-find.html

(provide 'nxml_mode_config)

;;;https://github.com/vhallac/.emacs.d/blob/master/config/customize-nxml-mode.el
;(eval-when-compile
;  (require 'nxml-mode))

;(setq
; nxml-child-indent 2
; nxml-outline-child-indent 2
; nxml-slash-auto-complete-flag t)

;(add-hook 'nxml-mode-hook
;          '(lambda ()
;             (choose-indent-type)
;             ;; Add my schema files to RNG search path
;             (add-to-list 'rng-schema-locating-files
;                "/home/wagner/dev_env/evtbpms/etc/emacs/nxml-mode/schemas/schemas.xml")))

;;;setting schemas home
;default was 
;rng-schema-locating-files's value is ("schemas.xml" "/usr/share/emacs/24.1/etc/schema/schemas.xml")



;;;close tag automatically after </ charater 
;https://blog.lnx.cx/tag/nxml-mode/

