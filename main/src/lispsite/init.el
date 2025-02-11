;;; Package -- Summary:
;;; Commentary:

;;; Code:
;;;  -*- lexical-binding: t -*-

(setq debug-on-error t)
(require 'edebug)

;; configuring emacs load-path
;; add this file dir to load-path
;; it is needed to require another el files in this same dir and from its subdir
;; to make its works, when you start emacs using this init.el as configuration follow this rule:
;; "cd $this_dir && emacs -q -l init.el &"
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)


;;if you behind a proxy uncomment this line
;;(require 'config-proxy)


;;install usepackage package
(require 'pkgconfig-usepackage);; the use-package is need by other lisp module like 'config-emacs-environment-variables below

;; config-emacs-defaults-language nao ta funcionando legal ainda
;;(require 'config-emacs-defaults-language)


;;this environment variables configured are defined in emacs process
;;in emacs a lot of variables have special meaning as below
;;https://www.gnu.org/software//emacs/manual/html_node/emacs/General-Variables.html
;;this setup-environment-variable is to controlling some of them
;;to manipulate emacs external environment variable use
;;.env controlled but (require dotenv-config) below
(require 'config-emacs-environment-variables) ;;this file calls pkgconfig-load-vars

;;which-key is a package to show keybindings in a popup
(use-package which-key
  :ensure t
  :config
  (progn
    (setq which-key-idle-delay 0.5)
    (setq which-key-idle-secondary-delay 0.5)
    (setq which-key-popup-type 'side-window)
    (setq which-key-side-window-location 'bottom)
    (setq which-key-side-window-max-width 0.33)
    (setq which-key-side-window-max-height 0.33)
    (setq which-key-max-description-length 50)
    (setq which-key-max-display-columns nil)
    (setq which-key-show-remaining-keys t)
    (setq which-key-sort-order 'which-key-key-order-alpha)
    (setq which-key-allow-imprecise-window-fit t)
    (setq which-key-allow-evil-operators t)
    (setq which-key-allow-evil-leader t)
    (setq which-key-allow-evil-normal-state t)
    (setq which-key-allow-evil-motion-state t)
    (setq which-key-allow-evil-visual-state t)
    (setq which-key-allow-evil-insert-state t)
    (setq which-key-allow-evil-replace-state t)
    (setq which-key-allow-evil-operator-state t)
    (setq which-key-allow-multiple-replacements t)
    (setq which-key-allow-undefined-keys t)
    (setq which-key-echo-keystrokes 0.02)
    (setq which-key-highlighted-command-list '())))

(require 'config-langtool)

;;some util functions
(require 'fzl-util-shell)
(require 'fzl-util-path)

;;all-the-icons is dependency pkg for treemacs, company and maybe others
;;to make it works was needed to M-x package-delete all-the-icons RET to delete pre installed all-the-icons
;;and restart emacs with this configuration to completelly reintall all-the-icons
(require 'pkgconfig-all-the-icons)
(require 'pkgconfig-treemacs)
(require 'pkgconfig-ess)
(require 'pkgconfig-helm)
(require 'config-emacs-defaults)


(require 'config-mode-dired)
(require 'config-mode-ibuffer)
(require 'config-theme)



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
(require 'coding-lang-lisp)
(require 'coding-lang-php)
(require 'coding-lang-shellscript)

;;its is the basic for angular
(require 'coding-lang-typescript)

(require 'coding-lang-python)

;;its specific format for angular

;;orgmode configuration
(require 'config-mode-orgmode)


(require 'pkgconfig-copilot)
(require 'pkgconfig-undo-tree)
(require 'personal-config)


;;abre alguns buffers de interesse
(fzl/view/open-this-buffers)

;;escolhe uma estrategia de view
(fzl/view/open-ibuffer-and-dired)


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


;; working with special files and dirs
(defvar fzl-special-files
  '("/media/wgn/EnvsBk/__devenv__/fzl-emacs/main/src/lispsite"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Tasks.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Dates.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Diary.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Contacts.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Projects.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Ideas.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Books.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Places.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__Shopping.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/__WorkinOn.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Notes/"
    "/media/wgn/EnvsBk/Documentos_Pess_Wgn_Pgtos/"
))

(defun fzl-open-special-file ()
  "Prompt to select a file from `fzl-special-files` and open it."
  (interactive)
  (let ((file (completing-read "Select file: " fzl-special-files)))
    (when file
      (find-file file))))

(global-set-key (kbd "M-f") 'fzl-open-special-file)

;;(open_dot_env_defined_buffers)
;;(teste)


;;(require 'fzl_menus)

;(require 'emacs-onstart)
;;programming languages integrations
