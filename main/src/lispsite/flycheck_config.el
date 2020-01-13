;;http://www.flycheck.org/en/latest/user/quickstart.html
;;https://www.gnu.org/software/emacs/manual/html_node/flymake/Installing-Flymake.html
;;http://www.flycheck.org/en/latest/user/installation.html

;;
;;Flycheck does not check buffers itself but relies on external programs to check buffers.
;;These programs must be installed separately.
;;Please take a look at the list of supported languages to find out what tools are required for a particular language.
;;

(add-hook 'after-init-hook #'global-flycheck-mode)

(global-flycheck-mode)


(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
(global-set-key [f4] 'flymake-goto-next-error)

(provide 'flycheck_config)
