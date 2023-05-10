;;; package --- Summary

;;; Commentary:
;;this file installs no packages
;;its deal only with build in emacs defaults customize


;;; Code:
(message "==>yaml.el loaded sucessfully!!!")

(use-package yaml-mode
  :ensure t
  :mode ("\\.yaml\\'" . yaml-mode)
  :init
  (add-hook 'yaml-mode-hook #'display-line-numbers-mode))

(provide 'yaml-config)
