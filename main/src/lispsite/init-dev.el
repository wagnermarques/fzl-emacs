;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

(message " ### init-dev.el loaded sucessfully!!!")

;;needs to change dir at emacs startup like cd /home/$USER/emacsinitfile && emacs -q -l init-dev.el
(setq **ThisFileDir** (getenv "PWD")) 

(add-to-list 'load-path **ThisFileDir**)
(add-to-list 'load-path (concat **ThisFileDir** "/web-mode"))
(add-to-list 'load-path (concat **ThisFileDir** "/rtags/src"))
(add-to-list 'load-path (concat **ThisFileDir** "/org-ref"))
(add-to-list 'load-path (concat **ThisFileDir** "/ESS"))

;(add-to-list 'load-path "~/emacs")
(setq load-path-copy load-path)
(while load-path-copy
  (message (car load-path-copy))
  (setq load-path-copy (cdr load-path-copy)))
   

(require 'init-common)
;;(require 'rtags_config)

(find-file (concat **EMACSINITFILE_HOME** "/index.org"))
;;; this_init-dev.el ends here
