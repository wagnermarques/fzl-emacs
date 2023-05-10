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
(require 'defaults-window)
(require 'window-helpers)

(require 'shortcuts)

;;;fzl-utils
(require 'fzl-functions) ;;TODO to revise all functions and shared in coding-respective-language file



;;coding
(require 'autocomplete)
(require 'coding-R)
(require 'coding-php)
(require 'coding-java)
(require 'coding-javascript)
(require 'coding-kotlin)


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


;;programming languages integrations
