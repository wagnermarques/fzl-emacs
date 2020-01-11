;;; package --- Summary

;;; Commentary:

;;; Code:

;will make the last line end in a carriage return.
;(setq require-final-newline gt) 

;will disallow creation of new lines when 
;you press the "arrow-down key" at end of the buffer.
(setq next-line-add-newlines nil) 

;; Permanent display of line and column numbers is handy.
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)

;will introduce spaces instead of tabs by default.
(setq-default indent-tabs-mode nil) 

;will trucate lines if they are too long. 
;(OBSERVAR PRA VER SE PERMANECE COM ESSA CONF)
(setq-default truncate-lines t)

;will trucate even when screen is split into multiple windows.
(setq-default truncate-partial-width-windows nil) 

;will position the cursor to end of output in shell mode.
;fix-me because
;Debugger entered--Lisp error: (void-function auto-show-make-point-visible)
;  (auto-show-make-point-visible)
;(auto-show-make-point-visible) 

;will position cursor to end of output in shell mode automatically.
;(auto-show-make-point-visible) 


;load auto-show (shows lines when cursor moves to right of long line).
;(require 'auto-show) (auto-show-mode 1) (setq-default auto-show-mode t) 

; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)
(global-set-key [delete] 'delete-char)


;;http://homepages.inf.ed.ac.uk/s0243221/emacs/
;; ===== Set the highlight current line minor mode =====
;; In every buffer, the line which contains the cursor will be fully
;; highlighted
(global-hl-line-mode 1)

;ativa numero de linhas nos buffers
(global-linum-mode 1)

;ativa numero da coluna
(column-number-mode 1)

;; Se a quebra automatica de linhas estiver ativada, as linhas são
;; quebradas se ultrapassarem a coluna 70.
(setq fill-column 70)


(provide 'config_lines_columns_and_cursor_behaviour)
;;; config_lines_columns_and_cursor_behaviour.el ends here
