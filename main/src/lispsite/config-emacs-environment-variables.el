
(print "===> config-emacs-environment-variables running...")


;;requiring 'dotenv-config call fzl-dotenv-variables-setup function
;;what reads dot env file and sets up global variables
(require  'pkgconfig-load-env-vars)
         
(message (getenv "EMACS_BACKUP_DIRECTORY"))

;(defvar this_elisp_file_dir (getenv "PWD"))
;(defvar **EMACSINITFILE_HOME** (concat this_elisp_file_dir "/../../.."))
;(setq **EMACSINITFILE_TESTS_LISPSITE** (concat **EMACSINITFILE_HOME** "/main/src/testssite"))

;(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **EMACSINITFILE_HOME** "/bin"))))
;(shell-command (concat "chmod +x " (concat **EMACSINITFILE_HOME** "/bin/*.sh"))) ;makes ./bin files executable

(defun fzl/emacs-env-variables-print-all ()
  "Print all relevant Emacs environment variables to the *Messages* buffer."
  (interactive)
  (mapc (lambda (env)
          (message "%s" env))
        process-environment))

(provide 'config-emacs-environment-variables)
