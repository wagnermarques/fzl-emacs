;;; evt_keys.el --- keys facilitate use of emacs

;; Emacs Lisp Archive Entry
;; Filename: fzl_keys.el
;; Version: 0.0   (or RCS/CVS *Revision*)
;; Keywords: fzlbpms emacs .emacs
;; Author: wagner franca marques
;; Maintainer: wagner franca marques
;; Created: 2013-12-12
;; Description: init.el for svtbpms customization
;; URL: not yet
;; Compatibility: emacs 24




;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;; for more details. http://www.gnu.org/copyleft/gpl.html




;;; Install:

;; 
;; put this file in you site-lisp and require it
;; (require 'fzl_keys)
;; 
;;
;;
;http://ergoemacs.org/emacs/keyboard_shortcuts.html

;;; Code:
(provide 'fzl_keys)

(global-unset-key "\C-x\C-z")


;;http://www.emacswiki.org/emacs/RyanSpringerDotEmacs
;; shift + arrow key = switch to window
(windmove-default-keybindings)

;(define-key global-map (kbd "\e\er") 'eval-region) ;ESC ESC r
;(define-key global-map (kbd "\e\eb") 'eval-buffer) ;ESC ESC b

(define-key global-map (kbd "\er") 'eval-region) ;ESC r
(define-key global-map (kbd "\eb") 'eval-buffer) ;ESC b
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


