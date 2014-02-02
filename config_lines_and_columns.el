(provide 'config_lines_and_columns)

(setq require-final-newline t) ;will make the last line end in a carriage return.
(setq next-line-add-newlines nil) ;will disallow creation of new lines when you press the "arrow-down key" at end of the buffer.

;; Permanent display of line and column numbers is handy.
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)



;Desabilitando controlx control z -> to undo: C-x U
(global-unset-key "\C-x\C-z")



;conjunto de caracteres latin 1 he mais interessante que UTF-8
;(set-language-environment "Latin-1")
(set-language-environment "Latin-1")


; o mode default, ao inves de text-mode, vamos utilizar o org-mode
(setq-default major-mode 'org-mode)


;will introduce spaces instead of tabs by default.
(setq-default indent-tabs-mode nil) 


;will trucate lines if they are too long. 
;(OBSERVAR PRA VER SE PERMANECE COM ESSA CONF)
(setq-default truncate-lines t)

;will trucate even when screen is split into multiple windows.
(setq-default truncate-partial-width-windows nil) 

;load auto-show (shows lines when cursor moves to right of long line).
;(require 'auto-show) 
;(auto-show-mode 1) 
;(setq-default auto-show-mode t) 
