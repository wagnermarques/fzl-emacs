;;; Package -- Summary:
;;; Commentary:

;;; Code:
;;;  -*- lexical-binding: t -*-

(setq debug-on-error t)


;; configuring emacs load-path
;; add this file dir to load-path
;; it is needed to require another el files in this same dir and from its subdir
;; to make its works, when you start emacs using this init.el as configuration follow this rule:
;; "cd $this_dir && emacs -q -l init.el &"
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)


;;if you behind a proxy uncomment this line
;;(require 'config-proxy)


;;this is needed to install packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;;from hereafter we can use use-package to install and configure emacs packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



;;this environment variables configured are defined in emacs process
;;in emacs a lot of variables have special meaning as below
;;https://www.gnu.org/software//emacs/manual/html_node/emacs/General-Variables.html
;;this setup-environment-variable is to controlling some of them
;;to manipulate emacs external environment variable use
;;.env controlled but (require dotenv-config) below
(require 'config-emacs-environment-variables) ;;this file calls pkgconfig-load-vars
(require 'config-emacs-defaults)
(require 'config-emacs-windows-and-frames)
(require 'config-mode-dired) 
(require 'config-mode-ibuffer)
(require 'config-theme)
(require 'pkgconfig-magit)
(require 'hook-emacs-startup)



;;(require 'fzl_menus)

;(require 'emacs-onstart)
;;programming languages integrations
