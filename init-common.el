;;; package --- Summary
;;; this file is common init file for all others init files
;;; by other init files I mean specific init files for specific functionalities
;;; for example, I want init.el for C++ IDE, init.el for LATEX IDE something like this...


;;; Commentary:
;;; the intent for this common init.el file is serve base configuration for
;;; another more specifi init.el files


;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-
(message " ### init-common.el loaded sucessfully!!!")



;;Entering the Debugger on an Error
;;https://ftp.gnu.org/old-gnu/Manuals/elisp-manual-21-2.8/html_node/elisp_225.html
(setq debug-on-error t)


;;G L O B A L    V A R I A B L E S
(message " ### Loading ... G L O B A L    V A R I A B L E S")
;; global vars in code are the prefixed and postfixed  with **, like **MY_GLOBAL_VAR_NAME**
(require 'global_variables_setup)


; maximize Emacs window
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


;;create emacsinitfile.log file
;;and provide a fzlUtil/log function to write on it
;;this feature config_loggin creates a emacsloggin.log file
;;and set up some fzl/log function to write on that file
;;beside this, set up the auto-revert-tail-mode for some files
;;like .log and _log and may some others if configure
;;when this files is opened in a buffer is showed like tail -f
;;it'is nice to open and watch log files
(message " ### requiring 'config_logging")
(require 'config_logging)
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")
(fzl/log "(require 'config_logging).. was required at last line sucessfully if you are reading this line...")



(message " ### requiring 'config_buffers")
;; for now just inhibit default startup emacs help buffer
(require 'config_buffers) ;;for now just inhibit emacs startup buffer


(provide 'init-common)
;;; init-common.el ends here
