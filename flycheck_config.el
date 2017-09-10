(provide 'flycheck_config)

;;https://www.gnu.org/software/emacs/manual/html_node/flymake/Installing-Flymake.html

(require 'flymake)

(global-flycheck-mode)

(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
(global-set-key [f4] 'flymake-goto-next-error)

(add-hook 'after-init-hook #'global-flycheck-mode)
