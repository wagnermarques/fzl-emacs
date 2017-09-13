;;;http://members.cbio.mines-paristech.fr/~thocking/primer.html
(provide 'ess_config)

(add-to-list 'load-path "ESS/lisp")
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(setq inferior-R-program-name "/usr/bin/R")

;;R stuff
(setq ess-eval-visibly-p nil)
(setq ess-ask-for-ess-directory nil)
(require 'ess-eldoc)

;;compile the first target in the Makefile in the current directory using F9
(global-set-key [f9] 'compile)
(setq compilation-read-command nil)

;;show matching parentheses
(show-paren-mode 1)
(autoload 'R-mode "ess-site.el" "ESS" t)


(load "ess-site")
(require 'ess-site)

