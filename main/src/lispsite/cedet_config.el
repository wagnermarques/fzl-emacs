;;; package --- Summary

;;; Commentary:

;;; Code:

;;;i n s t a l a n d o c e d e t
;;;http://stackoverflow.com/questions/12711765/status-of-cedet-and-ecb-in-emacs-24-2

;(require 'inversion)
;(require 'semantic)
;;(require 'semanticdb) facing no such file or directory
;(require 'cedet-files)


;;https://www.gnu.org/software/emacs/manual/html_mono/semantic.html
;;https://emacs.stackexchange.com/questions/4055/global-semantic-summary-mode-not-enabled-at-startup/4101#4101
;; Semantic
;(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

(semantic-mode 1) ;;enable Semantic mode

;;https://www.gnu.org/software/emacs/manual/html_mono/semantic.html#SemanticDB
;;from https://github.com/siddontang/emacs/blob/master/site-lisp/cedet/semantic/semanticdb-file.el
;; SemanticDb

;(defcustom semanticdb-default-save-directory (expand-file-name "./semanticdb")
;  "default dir for semanticdb"
;  :group 'semanticdb
;  :type '(directory))

;(defcustom semanticdb-default-file-name "semanticdb.cache"
;  "File name for semanticdb"
;  :group 'semanticdb
;  :type 'string)

;(defcustom semanticdb-persistent-path '(always)
;  "always to which enables saving cached tags everywhere"
;  :group 'semanticdb
;  :type nil)

;(defun fzl:semanticdb-save-database-hook--save-dbsave-event-listener(db_recently_saved)
;  "run after a database is saved. Parameter: db_recently_saved is db recently saved"
;  (fzl_log (concat db_recently_saved "was saved in")))
;(add-hook 'semanticdb-save-database-hooks 'fzl:semanticdb-save-database-hook--save-dbsave-event-listener)


;; CC-mode
;(add-hook 'c-mode-hook '(lambda ()
;        (setq ac-sources (append '(ac-source-semantic) ac-sources))
;        (local-set-key (kbd "RET") 'newline-and-indent)
;        (linum-mode t)
;        (semantic-mode t)))

;; Autocomplete
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories (expand-file-name
;             "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict"))
;(setq ac-comphist-file (expand-file-name
;             "~/.emacs.d/ac-comphist.dat"))
;(ac-config-default)


;(require 'semantic/db)
;(global-semanticdb-minor-mode 1)




;IN CASE OF SOURCE CODE TRUNK INSTALLATION...
;(load-file
; (concat *cedet_home* "/common/cedet.el"))

;(global-ede-mode 1) ; Enable the Project management system
;TODO abilitate this litle features... are getting void functions...
;(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1) ; Enable template insertion menu

(provide 'cedet_config)
;;; Cedet_config.el ends here.
