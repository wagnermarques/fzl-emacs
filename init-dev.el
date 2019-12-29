;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

(message " ### init-dev.el loaded sucessfully!!!")

;;needs to change dir at emacs startup like cd /home/$USER/emacsinitfile && emacs -q -l init-dev.el
(setq **ThisFileDir** (getenv "PWD")) 

(add-to-list 'load-path **ThisFileDir**)
(add-to-list 'load-path (concat **ThisFileDir** "/web-mode"))
(add-to-list 'load-path (concat **ThisFileDir** "/org-ref"))
(add-to-list 'load-path (concat **ThisFileDir** "/ESS"))

(add-to-list 'load-path "~/emacs")

(require 'init-common)


;;; this_init-dev.el ends here
