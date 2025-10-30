;;; Package -- Summary:
;;; Commentary:
;;; TODO: make it works indeed

;;; Code:
;;;  -*- lexical-binding: t -*-

(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)


;; Set language environment to Brazilian Portuguese
(set-language-environment "Brazilian Portuguese")

;; Define the default coding system for new buffers as UTF-8
(setq default-buffer-file-coding-system 'utf-8)

;; Force UTF-8 encoding when saving files
(prefer-coding-system 'utf-8)

;; Ensure UTF-8 is used for encoding, supporting a wide range of characters, including those used in Portuguese
(set-default-coding-systems 'utf-8)
(setq coding-system-for-write 'utf-8)

;; Org-mode UTF-8 settings with process check
(add-hook
 'org-mode-hook (lambda ()
                  (set-buffer-file-coding-system 'utf-8)
                  (when (get-buffer-process (current-buffer))
                    (set-buffer-process-coding-system 'utf-8 'utf-8))
                  (setq buffer-file-coding-system 'utf-8)))

;; Set a robust, Windows-like monospace font (fallback chain)
(let ((preferred-fonts '("Consolas" "Liberation Mono" "Courier New" "Andale Mono" "Source Code Pro" "Monospace")))
  (catch 'font-set
    (dolist (font preferred-fonts)
      (when (member font (font-family-list))
        (set-frame-font (format "%s-12" font) nil t)
        (throw 'font-set t))))
  (unless (member (face-attribute 'default :font) (mapcar (lambda (f) (format "%s-12" f)) preferred-fonts))))


(provide 'config-emacs-defaults-language)

(defun fzl-desktop-fonts-list-available-fonts ()
  "List all available fonts on the system."
  (interactive)
  (let ((font-list (font-family-list)))
    (with-output-to-temp-buffer "*Available Fonts*"
      (princ "Available Fonts:\n\n")
      (dolist (font font-list)
        (princ (format "- %s\n" font))))))

;;it must be consistent with os local
;;wgn@wgnhost:/media/wgn/EnvsBk/__devenv__/fzl-emacs/main/src/lispsite$ locale
;;LANG=pt_BR.UTF-8
;;LANGUAGE=pt_BR:pt:en
;;LC_CTYPE="pt_BR.UTF-8"
;;LC_NUMERIC="pt_BR.UTF-8"
;;LC_TIME="pt_BR.UTF-8"
;;LC_COLLATE="pt_BR.UTF-8"
;;LC_MONETARY="pt_BR.UTF-8"
;;LC_MESSAGES="pt_BR.UTF-8"
;;LC_PAPER="pt_BR.UTF-8"
;;LC_NAME="pt_BR.UTF-8"
;;LC_ADDRESS="pt_BR.UTF-8"
;;LC_TELEPHONE="pt_BR.UTF-8"
;;LC_MEASUREMENT="pt_BR.UTF-8"
;;LC_IDENTIFICATION="pt_BR.UTF-8" 
;;LC_ALL=
;(set-language-environment "Brazilian Portuguese")

