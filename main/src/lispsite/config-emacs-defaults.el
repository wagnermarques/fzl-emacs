;; package --- Summary

;;; Commentary:
;;this file change some Emacs defauls

;;; Code:

;; Enable CUA mode
;;(cua-mode t)

;; Maximizar janela do Emacs ao iniciar
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; despite C-w is defined by default
;; I like to use this to kill buffers
(global-set-key (kbd "C-q") 'kill-this-buffer)


;;;desabilitando aquela pagina inicial do emacs, legal mas desnecessaria
(setq inhibit-startup-message t)


;will allow you to type just "y" instead of "yes" when you exit.
(fset 'yes-or-no-p 'y-or-n-p)


;;; auto save backup files to ~/.emacs.d/auto-save-list
;;; (https://www.emacswiki.org/emacs/AutoSave
(auto-save-mode t)
(setq backup-directory-alist
      `((".*" . ,(expand-file-name "~/.emacs.d/auto-save-list/"))))



;;http://www.emacswiki.org/emacs/StickyModifiers
;;From the documentation:
;;This means that you can release the modifier key before pressing down
;;the key that you wish to be modified.
;;Although this is non-standard behavior, it is recommended because
;;it reduces the strain on your hand, thus reducing the incidence of the dreaded
;;Emacs-pinky syndrome.
(setq modifier-keys-are-sticky t)


;;will make ctrl, shift, alt "sticky" in xemacs.
;;(Does anybody know how to do this in emacs?)
;;With sticky-keys, you dont have to hold down the ctrl/shift/alt key and another key simultaneosly.
;;For example, to type ctrl-a, you'd have to tap on the 'ctrl'-key, followed by a tap on the 'a'-key. This feature is useful for folks with sore wrists/hands.
(setq message-log-max 512) ;will reduce the number of messages that appear in the "*Messages*" window to 512.


;;will make the display of date and time persistent.
;;(setq display-time-day-and-date t) (display-time)
;;will highlight region between point and mark.
;;(transient-mark-mode t)


;;will highlight during query.
(setq query-replace-highlight t)


;;highlight incremental search
(setq search-highlight t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;F O N T S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;http://www.emacswiki.org/emacs/SetFonts
(set-face-attribute 'default (selected-frame) :height 80)

;http://www.gnu.org/software/emacs/manual/html_node/emacs/Font-Lock.html
;means that we want fontification in all modes.
(global-font-lock-mode t)

;denotes our interest in maximum possible fontification.
(setq font-lock-maximum-decoration t)


;R e m o v i n g    A n n o y a n c e s 

;(setq inhibit-startup-message t) ;will inhibit startup messages.
(setq require-final-newline t) ;will make the last line end in a carriage return.
(setq next-line-add-newlines nil) ;will disallow creation of new lines when you press the "arrow-down key" at end of the buffer. 


;conjunto de caracteres latin 1 he mais interessante que UTF-8
;(set-language-environment "Latin-1")
(set-language-environment "Latin-1")
 

;Desabilitando controlx control z
(global-unset-key "\C-x\C-z")


;will reduce the number of messages that appear in the "*Messages*" window to 512.
(setq message-log-max 512)

;will make the display of date and time persistent.
(setq display-time-day-and-date t) (display-time)

;will highlight matching parentheses next to cursor.
(require 'paren) (show-paren-mode t)

 ;will introduce spaces instead of tabs by default.
(setq-default indent-tabs-mode nil)

 ;will trucate lines if they are too long. (OBSERVAR PRA VER SE PERMANECE COM ESSA CONF)
(setq-default truncate-lines t)

;will trucate even when screen is split into multiple windows.
(setq-default truncate-partial-width-windows nil)

;(require 'auto-show) (auto-show-mode 1) (setq-default auto-show-mode t) ;load auto-show (shows lines when cursor moves to right of long line).
;(auto-show-make-point-visible) ;will position the cursor to end of output in shell mode.
;(auto-show-make-point-visible) ;will position cursor to end of output in shell mode automatically.

;will highlight region between point and mark.
(transient-mark-mode t)

;will highlight during query.
(setq query-replace-highlight t)

;highlight incremental search
(setq search-highlight t)

;(global-font-lock-mode t t) ;means that we want fontification in all modes.
;(setq font-lock-maximum-decoration t) ;denotes our interest in maximum possible fontification.


;(setq enable-recursive-minibuffers t) ;; allow recursive editing in minibuffer
;(resize-minibuffer-mode 1)            ;; minibuffer gets resized if it becomes too big
;(follow-mode t)                       ;; follow-mode allows easier editing of long files 

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(global-set-key [delete] 'delete-char)


;;________________________________________________________________
;;  Handle files with mixed UNIX and DOS line endings.
;;  http://marc.info/?l=tex-br&m=122278754619960
;;________________________________________________________________

;; Ativa a quebra automatica de linhas para todos os modos.
;;Para desativ�-la,
;; substitua "1" por "0", na linha abaixo.
(add-hook 'text-mode-hook
     '(lambda () (auto-fill-mode 1)))

;; Se a quebra automatica de linhas estiver ativada, as linhas são
;; quebradas se ultrapassarem a coluna 70.
(setq fill-column 70)


;;https://www.emacswiki.org/emacs/ShowWhiteSpace

(provide 'config-emacs-defaults)
