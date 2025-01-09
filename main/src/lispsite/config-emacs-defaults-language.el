;; #### setting language ###
;;https://emacsdocs.org/docs/emacs/Language-Environments

;;Tells Emacs to use Brazilian Portuguese as the language environment.
;;This influences how Emacs handles language-specific features.
;;https://www.gnu.org/software/emacs/manual/html_node/emacs/International.html
;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Language-Environments.html
(setenv "LANG" "pt_BR.iso-8859-1")
(set-language-environment "Latin-1")

;; Set language environment to Brazilian Portuguese
(set-language-environment "Brazilian Portuguese")

(prefer-coding-system 'iso-8859-1)
(setq org-default-notes-encoding 'utf-8)
;;(set-language-environment "pt_BR")
;;(insert (getenv "LANG"))pt_BR.UTF-8

;;Ensures that UTF-8 is used for encoding, which supports a wide range of characters, including those used in Portuguese
;;(set-default-coding-systems 'utf-8)

;;(use-package 'i18n
;;  :ensure t)
;;(require 'i18n)

;; Ensure UTF-8 Encoding
;;(prefer-coding-system 'utf-8)
;;(set-default-coding-systems 'utf-8)
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(setq buffer-file-coding-system 'utf-8)
;;
;;(require 'iso-transl)

;; Org-mode UTF-8 settings with process check
;;(add-hook
;; 'org-mode-hook (lambda ()
;;                  (set-buffer-file-coding-system 'utf-8)
;;                  (when (get-buffer-process (current-buffer))
;;                    (set-buffer-process-coding-system 'utf-8 'utf-8))
;;                  (setq buffer-file-coding-system 'utf-8)))

;; Set font to one that supports Brazilian Portuguese characters
;;(set-frame-font "DejaVu Sans Mono-12" nil t)




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
(set-language-environment "Brazilian Portuguese")

(provide 'config-emacs-defaults-language)
;;(set-default-coding-systems 'utf-8) 
;;(setq default-buffer-file-coding-system 'utf-8) 
