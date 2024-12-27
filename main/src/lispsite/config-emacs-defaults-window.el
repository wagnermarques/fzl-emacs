;;; package --- Summary

;;; Commentary:
;;this changes some windows scople defauts

;;; Code:

;; if you wants setting some colors
;(set-cursor-color "red")
;(set-mouse-color "white")
;(set-background-color "black")
;(set-foreground-color "white")
;(load-theme 'manoj-dark)


;http://www.djcbsoftware.nl/dot-emacs.html
(menu-bar-mode  nil)                       ;; t show the menu, nil hides...
(mouse-avoidance-mode 'jump)               ;; mouse ptr when cursor is too close
(tool-bar-mode -1)                         ;; turn-off toolbar


;; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)


;;ativa numero de linhas nos buffers e colunas
(global-display-line-numbers-mode 1)
(column-number-mode 1)


;;ace-window
;;allow to change buffer window but choose its number after M-o shurtcut
(use-package ace-window
  :ensure t)
(global-set-key (kbd "M-o") 'ace-window)


(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)


;;TODO FIX
(defun fzl-buffer-show-messages-in-bottom ()
  "Reorganize windows to show *Messages* buffer at the bottom."
  (interactive)
  (let* ((speedbar-window (get-buffer-window (speedbar-buffer))))
    ;; Split the current window horizontally
    (split-window-horizontally)
    ;; Move to the newly created window
    (other-window 1)
    ;; Show *Messages* buffer in the current window
    (switch-to-buffer "*Messages*")
    ;; Move back to the original speedbar window
    (select-window speedbar-window)
    ;; Adjust the window configurations
    (balance-windows)
    ;; Resize the *Messages* window to be larger
    (enlarge-window (- (window-height) 10))))



(provide 'config-emacs-defaults-window)

;;; defautls-window.el ends here
