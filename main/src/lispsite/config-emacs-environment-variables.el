(print "===> config-emacs-environment-variables running...")


;;requiring 'dotenv-config call fzl-dotenv-variables-setup function
;;what reads dot env file and sets up global variables
(require  'pkgconfig-load-env-vars)

(defun fzl/emacs-env-variables-print-all ()
  "Print all relevant Emacs environment variables to the *Messages* buffer."
  (interactive)
  (mapc (lambda (env)
          (message "%s" env))
        process-environment))

(when (equal (getenv "FZLEMACS_INIT_SHOW_ENVIRONMENT_VARIABLES") "t") (fzl/emacs-env-variables-print-all))

(provide 'config-emacs-environment-variables) 
