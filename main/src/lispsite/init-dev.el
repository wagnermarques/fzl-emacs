;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-
(message " ### init-dev.el loaded sucessfully!!!")

;;load files in this same el file dir
(setq *thisFileDir* (getenv "PWD"))
(add-to-list 'load-path *thisFileDir*)


;;we add this file dir to load-path
;;so that we can load some .el files in this dir
;;after ir we load global vars the defines another paths of interests as global vars
(add-to-list 'load-path *thisFileDir*)

;;this file defines serveral path or interest as global vars
;;as **EMACSINITFILE_LISPSITE** the are used below, for example
;; global vars in code are the prefixed and postfixed  with **, like **MY_GLOBAL_VAR_NAME**
(require 'global_variables_setup)


(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/web-mode"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/rtags/src"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/org-ref"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/ESS"))


(require 'init_common)

(require 'config_package_system)

;;; B A S I C  W R I T E   C O N F I G U R A T I O N S
(require 'config_abbrev)
(require 'config_helm)

;;; B A S I C  C O D I N G   C O N F I G U R A T I O N S
(message " ### B A S I C  C O D I N G   C O N F I G U R A T I O N S")

;;;
;;; highlight matching parentheses next to cursor
(require 'config_code_in_general)


(require 'cedet_config)

;; autocomplete for several languages is not so simple, but
;; this features still not working as I would like to
;; but a simpler is configured in this file required autocomplete_config.el
(require 'autocomplete_config)

;; yasnippet uses ac-sources defined by autocomplete
;; so needs to be here, after autocomplete_config.el loaded
(require 'yasnippet_config)


(require 'flycheck_config)


;;(require 'rtags_config)

(find-file (concat **EMACSINITFILE_HOME** "/index.org"))
;;; this_init-dev.el ends here
