(provide 'fzl_pkg_install_functions)

(defun fzl-bashcommand-autocomplete-installation-shell-script()
  "just download in the fzlbpms context rigth place. 
   Change init.el accordingle is needed"
  (interactive)
  (split-string
   (shell-command-to-string "bash autocomplete_installation.sh")))

(defun fzl-bashcommand-cedet-installation-shell-script()
  "just download in the fzlbpms context rigth place. Change init.el accordingle is needed"
  (interactive)
  (split-string
   (shell-command-to-string "bash cedet_installation.sh")))



