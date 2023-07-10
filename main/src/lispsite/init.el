(setq debug-on-error t)

;; add this file dir to load-path
;; it is needed to require another el files in this same dir
;; to work you need to change to this dir and runs "cd $this_dir && emacs -q -l init.el &"
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)


;;if you behind a proxy uncomment this line
;;(require 'config-proxy)


;;this is needed to install it
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;from hereafter we can use use-package to install and configure emacs packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;changing some emacs defaults
(require 'defaults)
(provide 'defaults-keys) 
(provide 'defaults-higligth)
(require 'defaults-window)
(require 'window-helpers)

(require 'dotenv-config)
(require 'helm-config)
(require 'speedbar-config)

(require 'shortcuts)
(require 'abbrev-config)

;;;fzl-utils
(require 'fzl-functions) ;;TODO to revise all functions and shared in coding-respective-language file



;;coding
(require 'magit-config)
(require 'autocomplete)
(require 'coding-shellscript)
(require 'coding-R)
(require 'coding-php)
(require 'coding-java)
(require 'coding-groovy)
(require 'coding-javascript)
(require 'coding-kotlin)
(require 'coding-dockerfile)
(require 'coding-sql)
;;coding hooks
(require 'hooks-prog-mode)



;;editing yml files
(require 'yaml-config)



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


;;infra and os
(require 'fzl-util-docker)


;;programming languages integrations
