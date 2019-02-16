;;; package --- Summary
;;; Code:
;;; Commentary:
;;; http://tuhdo.github.io/helm-intro.html

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-


;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(helm-mode 1)


(provide 'config_helm)
;;; config_helm.el ends here
