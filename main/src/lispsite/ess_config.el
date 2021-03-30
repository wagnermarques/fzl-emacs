;;; package --- Summary

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(setq inferior-R-program-name "/usr/bin/R")

;;R stuff
(setq ess-eval-visibly-p nil)
(setq ess-ask-for-ess-directory nil)
;(require 'ess-eldoc)

;;compile the first target in the Makefile in the current directory using F9
;(global-set-key [f9] 'compile)
;(setq compilation-read-command nil)

(autoload 'R-mode "ess-site.el" "ESS" t)
(require 'ess-site)

;;(load "ess-site")
;;(require 'ess-site)


(provide 'ess_config)
;;; this_file_name.el ends here
