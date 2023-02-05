;;; package --- Summary

;;; Commentary:

;;; Code:

(global-unset-key "\C-x\C-z")

;;http://www.emacswiki.org/emacs/RyanSpringerDotEmacs
;; shift + arrow key = switch to window
(windmove-default-keybindings)

;(define-key global-map (kbd "\e\er") 'eval-region) ;ESC ESC r

(define-key global-map (kbd "\er") 'eval-region) ;ESC r

(define-key global-map (kbd "\eb") 'org-beamer-export-to-pdf); ESC b
;(define-key global-map (kbd "\er") 'revert-buffer); ESC b


(define-key global-map (kbd "\es") 'fzl_open_shell_in_a_buffer) ;ESC s
(define-key global-map (kbd "C-c s") 'ansi-term)

(define-key global-map (kbd "\em") 'make-directory) ;ESC m

(define-key global-map (kbd "\ea") 'org-agenda-list)
(define-key global-map (kbd "\et") 'org-todo-list)

(define-key global-map (kbd "C-c C-a C-b") 'fzl-android-proj-gradlew-build)
(define-key global-map (kbd "C-c C-a C-r") 'fzl-android-proj-gradlew-install-and-run)
(define-key global-map (kbd "C-c C-a C-d") 'fzl-android-adb-devices)

;;handling files
(global-set-key (kbd "\ef") 'find-file-in-project)

;handle windows
;refs 
;http://www.emacswiki.org/emacs/WindowResize
(global-set-key (kbd "S-C-<right>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


;(global-set-key (kbd "\e\ec") 'calendar)         ;calendar
(provide 'fzl_keys)
;;; fzl_keys.el ends here
