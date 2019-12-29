;;; package --- Summary
;;; Code:
;;; Commentary:
;;; http://tuhdo.github.io/helm-intro.html

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-


;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;;https://www.youtube.com/watch?v=k78f8NYYIto
;;when helm-find-files shows up a folder between the files
;;this permit a tab to enter in this folder to select its files to open
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-unset-key (kbd "C-x c"))

(helm-mode 1)


(provide 'config_helm)
;;; config_helm.el ends here
