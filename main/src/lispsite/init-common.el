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


;;Entering the Debugger on an Error
;;https://ftp.gnu.org/old-gnu/Manuals/elisp-manual-21-2.8/html_node/elisp_225.html
(setq debug-on-error t)


(message " ### 'config_lines_columns_and_cursor_behaviour")
(require 'config_lines_columns_and_cursor_behaviour)

(message " ### 'config_general_emacs_behaviour")
;; this sets up general emacs behavior including
;; auto mode alist, for example
(require 'config_general_emacs_behaviour)


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


;;I N S T A L L I N G    E M A C S    P A C K A G E S
(message " ### I N S T A L L I N G    E M A C S    P A C K A G E S")
;;configure emacs packages repositories installing list of packages automatically
;;(require 'config_package_system)


(message " ### requiring 'config_buffers")
;; for now just inhibit default startup emacs help buffer
(require 'config_buffers) ;;for now just inhibit emacs startup buffer


;;to see the messages during emacs initiazlization
(switch-to-buffer "*Messages*")


(message " ### 'speedbar_config")
(require 'speedbar_config) ;;put a speedbar in confined buffer and opens it

(message " ### 'fzl_keys")
;; define keybindings
(require 'fzl_keys)

(require 'config_abbrev)
;(require 'config_helm)



;;; B A S I C  C O D I N G   C O N F I G U R A T I O N S
(message " ### B A S I C  C O D I N G   C O N F I G U R A T I O N S")
(message " ### 'config_code_in_general")
;(require 'config_code_in_general)
(message " ### 'autocomplete_config")
;(require 'autocomplete_config)
(message " ### 'cedet_config")
(require 'cedet_config)
(message " ### 'flycheck_config")
;(require 'flycheck_config)


(provide 'init-common)
;;; init-common.el ends here
