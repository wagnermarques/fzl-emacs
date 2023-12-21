(setq debug-on-error t)

;; configuring emacs load-path
;; add this file dir to load-path
;; it is needed to require another el files in this same dir
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
(require 'setup-environment-variables)


;; changins some emacs defaults
;; as background,
;; automatics emacs backup files dir to ~/.emacs.d/auto-save-list/
;; basic window config
(require 'defaults)
(require 'defaults-window)
(require 'window-helpers)

(require 'dotenv-config)
(require 'helm-config)
(require 'speedbar-config)
(require 'abbrev-config)


;;coding code
(require 'coding-) ;;define some common basic coding features

(require 'coding-dockerfile)
(require 'coding-yml)

(require 'coding-php)
(require 'coding-java)
(require 'coding-typescript)


(require 'coding-shellscript)
(require 'coding-shellscript-yasnippet-config)

(require 'coding-R)
(require 'coding-android)
(require 'coding-groovy)
(require 'coding-javascript)
(require 'coding-kotlin)
(require 'coding-sql)

(require 'coding-graphviz-dot)

(require 'magit-config)

;;coding hooks
(require 'hooks-prog-mode)




;;org-mode
;;org-mode easy templates
(require 'orgmode-defaults)

;;org-mode easy-templates
(require 'orgmode-babel-codeblocks)

;;control publish and exports in orgmode
(require 'orgmode-exports)

;;data analisys
(require 'data-analisys-ess)


;; ides
(require 'fzl-ides-netbeans)
(require 'fzl-ides-eclipse)
(require 'fzl-ides-androidstudio)
(require 'fzl-ides-vscode)


;;infra and os
(require 'fzl-util-docker)
(require 'fzl-util-karaf)


;;;fzl-utils requried by others functions
(require 'fzl-functions) ;;TODO to revise all functions and shared in coding-respective-language file
(require 'fzl-util-tail-f)
(require 'fzl-menus)

(require 'emacs-onstart)
;;programming languages integrations
