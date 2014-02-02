
; i n s t a l a n d o a u t o c o m p l e t e
(provide 'autocomplete_installation)

(defun run-autocomplete-installation-script ()
  "run-autocomplete-installation-script"
  (interactive)
  (split-string
   (shell-command-to-string "bash autocomplete_installation.sh")))
  
;(run-autocomplete-installation-script)

