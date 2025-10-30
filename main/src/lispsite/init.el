;;; Package -- Summary:
;;; Commentary:

;;; Code:
;;;  -*- lexical-binding: t -*-


;;; shows errors details in buffer
(setq debug-on-error t)
;(require 'edebug)


;; configuring emacs load-path
;; add this file dir to load-path
;; it is needed to require another .el files that lives in this same dir and from its subdir
;; to make its works, when you start emacs using this init.el as configuration follow this rule:
;; "cd $this_dir && emacs -q -l init.el &"
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)

;;This package synchronizes Emacs's internal exec-path with your shell's PATH.
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


;;if you behind a proxy uncomment this line
;;(require 'config-proxy)



;;configuring melpa repo and install usepackage
;; the use-package is need by other lisp module like 'config-emacs-environment-variables below
(require 'pkgconfig-usepackage)
(package-refresh-contents)



;;tryin to make emacs understand brazilian portuguese language
;;it's not works a lot of time

;; config-emacs-defaults-language nao ta funcionando legal ainda
(require 'config-emacs-defaults-language)

;;define all global variables
(require 'config-emacs-environment-variables) ;;this file calls pkgconfig-load-vars

;;changing some emacs defaulst config
(require 'config-emacs-defaults)

(require 'config-mode-dired)
(require 'config-mode-ibuffer)



;;; conding languages
(require 'coding-lang-java)
;(require 'coding-R)
(require 'pkgconfig-ess)
(require 'pkgconfig-restclient)



;;; configuring langtool if java is available  ;;;;
;;; https://languagetool.org/download/
;; Java verification and conditional langtool loading
(when (and (fboundp 'fzl-java-executable-find)
           (fzl-java-executable-find))
  (require 'config-langtool)
  (condition-case err
      (progn
        (require 'config-langtool)
        (message "LanguageTool loaded successfully"))
    (error
     (message "Failed to load LanguageTool: %s" (error-message-string err))
     nil))) ; Return nil on failure



;;for some reason edit markdown raise polymode not updated errors
(use-package polymode
  :ensure t)



;;some util functions
(require 'fzl-util-shell)
(require 'fzl-util-path)



;;all-the-icons is dependency pkg for treemacs, company and maybe others
;;to make it works was needed to M-x package-delete all-the-icons RET to delete pre installed all-the-icons
;;and restart emacs with this configuration to completelly reintall all-the-icons
;;install nerd font
;;https://www.nerdfonts.com/font-downloads
;;mkdir -p ~/.local/share/fonts
;;mv FiraCodeTemp/*.ttf ~/.local/share/fonts/
;;fc-cache -f -v
;;fc-list | grep -i "FiraCode"
(require 'pkgconfig-all-the-icons)
(use-package nerd-icons
  :ensure t)
(require 'config-theme)
(require 'pkgconfig-treemacs)
(require 'pkgconfig-helm)



(require 'pkgconfig-docker)


(require 'config-emacs-defaults)




;;;;;;;;;;;;;;;;;
;;controlling emacs buffers
;;;;;;;;;;;;;;;;;
(require 'fzl-views-strategies)

;;this makes .log files buffer works as tail -f its contents
(require 'config-buffer-for--logs)


(require 'fzl-emacs-hooks-startup)
(require 'fzl-ide-feat-grep)
(require 'fzl-ide-feat-keys)
(require 'fzl-ide-feat-menus)

(require 'pkgconfig-magit)

(require 'pkgconfig-company)
(require 'coding-lang-server-provider-docker)
(require 'coding-lang-sql)

(require 'coding-lang-lisp)
(require 'coding-lang-php)
(require 'coding-lang-shellscript)
(require 'coding-yaml)

;;its is the basic for angular
(require 'coding-lang-typescript)

(require 'coding-lang-python)

;;its specific format for angular

;;orgmode configuration
(require 'config-mode-orgmode)

(require 'files-special-files)
(require 'pkgconfig-undo-tree)

(require 'pkgconfig-copilot)
(require 'pkgconfig-org-zotxt)




;;abre alguns buffers de interesse
;;(fzl/view/open-this-buffers)

;;escolhe uma estrategia de view
(fzl-views--open-ibuffer-and-dired)


;; Set default coding system to UTF-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; If you use Windows
(setq locale-coding-system 'utf-8)

;; For older Emacs versions
(unless (boundp 'buffer-file-coding-system)
  (defvar buffer-file-coding-system 'utf-8))

;; If you use a graphical interface
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


(use-package which-key
  :ensure t
  :config
  (setq which-key-idle-delay 0.5)  ; Set the delay before which-key popup appears
  (setq which-key-side-window-location 'right)  ; Show which-key popup on the right side
  (which-key-mode))  ; Enable which-key mode




;;(open_dot_env_defined_buffers)
;;(teste)


;;(require 'fzl_menus)

;(require 'emacs-onstart)
;;programming languages integrations

;;;;;;;;;;;;;;;;;
;; some os facilities
;;;;;;;;;;;;;;;;;
(require 'linux-fedora)

;;;;;;;;;;;;;;;;;
;; fzlbpms utilities to work with stack of containers as bpms
;;;;;;;;;;;;;;;;;
(require 'fzlbpms)



;;(require 'tesaurus_from_json)


(find-file (concat fzlemacs-dir--fzlemacs-home "/index.org"))
(find-file (concat fzlemacs-dir--fzlemacs-lispsite "/init.el"))


