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




;;this environment variables configured are defined in emacs process
;;in emacs a lot of variables have special meaning as below
;;https://www.gnu.org/software//emacs/manual/html_node/emacs/General-Variables.html
;;this setup-environment-variable is to controlling some of them
;;to manipulate emacs external environment variable use
;;.env controlled but (require dotenv-config) below

(require 'pkgconfig-usepackage);; the use-package is need by other lisp module like 'config-emacs-environment-variables below
(require 'config-emacs-environment-variables) ;;this file calls pkgconfig-load-vars
(require 'pkgconfig-all-the-icons)
(require 'pkgconfig-treemacs)
;;(require 'pgkconfig-all-the-icons)
;; config-emacs-defaults files loads
;; config-emacs-defaults-highlight.el
;; config-emacs-defaults-window.el
(require 'config-emacs-defaults)
(require 'config-emacs-windows-and-frames)
(require 'config-mode-dired) 
(require 'config-mode-ibuffer)
(require 'config-theme)
(require 'fzl-views-strategies)
(require 'fzl-emacs-hooks-startup) 
(require 'fzl-ide-feat-grep)
(require 'fzl-ide-feat-keys)
(require 'fzl-ide-feat-menus)

(require 'pkgconfig-magit)

(require 'pkgconfig-company)
(require 'coding-lang-lisp)


(require 'config-mode-orgmode)

;;abre alguns buffers de interesse
(fzl/view/open-this-buffers)

;;escolhe uma estrategia de view
(fzl/view/open-ibuffer-and-dired)


;;(open_dot_env_defined_buffers)
;;(teste)


;;(require 'fzl_menus)

;(require 'emacs-onstart)
;;programming languages integrations
