;;; package --- Summary
;;; this file is common init file for all others init files
;;; by other init files I mean specific init files for specific functionalities
;;; for example, I want init.el for C++ IDE, init.el for LATEX IDE something like this...


;;; Commentary:
;;; the intent for this common init.el file is serve base configuration for
;;; another more specifi init.el files


;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

(message " ### init-common.el loaded sucessfully!!!")
(require 'init_basic)

(message " ### 'config_lines_columns_and_cursor_behaviour")
(require 'config_lines_columns_and_cursor_behaviour)

(message " ### 'config_general_emacs_behaviour")
;; this sets up general emacs behavior including
;; auto mode alist, for example
(require 'config_general_emacs_behaviour)

;; maximize Emacs window
;; needed to use list with dot sintax to works
;(custom-set-variables
; '(initial-frame-alist (quote ((fullscreen . maximized)))))

(setq initial-frame-alist '((fullscreen . maximized)))

;;autosave and backaup dir
(setq auto-save-file-name-transforms '( (".*" "../../../var/auto-save" t)))

;;https://www.emacswiki.org/emacs/BackupDirectory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "../../../var/backup"))
   delete-old-versions t
   kept-new-versions 2
   kept-old-versions 1
   version-control nil)

;(setq tramp-backup-directory-alist '((".*"  "../../../var/backup")))


;;create emacsinitfile.log file
;;and provide a fzlUtil/log function to write on it
;;this feature config_loggin creates a emacsloggin.log file
;;and set up some fzl/log function to write on that file
;;beside this, set up the auto-revert-tail-mode for some files
;;like .log and _log and may some others if configure
;;when this files is opened in a buffer is showed like tail -f
;;it'is nice to open and watch log files
(require 'config_logging) ;;needs to be esclude from auto-save-file-name-transforms
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")


(message " ### requiring 'config_buffers")
;; for now just inhibit default startup emacs help buffer
(require 'config_buffers) ;;for now just inhibit emacs startup buffer

;;to see the messages during emacs initiazlization
(switch-to-buffer "*Messages*")

(require 'speedbar_config) ;;put a speedbar in confined buffer and opens it

;; define keybindings
(require 'fzl_keys)

(provide 'init_common)
;;; init_common.el ends here
