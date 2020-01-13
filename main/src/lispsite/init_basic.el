;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

(message " ### init-basic.el loaded sucessfully!!!")

;;Entering the Debugger on an Error
;;https://ftp.gnu.org/old-gnu/Manuals/elisp-manual-21-2.8/html_node/elisp_225.html
(setq debug-on-error t)

;;the **EMACSINITFILE_LISPSITE** variable is defined in global_variables_setup.el loaded by init-dev.el
(add-to-list 'load-path **EMACSINITFILE_LISPSITE**)


(provide 'init_basic)
