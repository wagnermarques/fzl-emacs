;;; package --- Summary

;;; Commentary:
;;this changes some windows scople defauts

;;; Code:

(message "==>default-window.el loaded sucessfully!!!")

(scroll-bar-mode -1)

(set-cursor-color "red")
(set-mouse-color "white")

(set-background-color "black")
(set-foreground-color "white")


;http://www.djcbsoftware.nl/dot-emacs.html
(menu-bar-mode  nil)                       ;; t show the menu, nil hides...
(mouse-avoidance-mode 'jump)               ;; mouse ptr when cursor is too close
(tool-bar-mode -1)                         ;; turn-off toolbar


;; Permanent display of line and column numbers is handy.
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)

(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)


(provide 'defaults-window)

;;; defautls-window.el ends here
