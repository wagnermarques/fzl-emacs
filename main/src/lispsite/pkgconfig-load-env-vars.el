(print "===> pkgconfig-load-env-vars.el running...")

;; https://humanlytyped.hashnode.dev/working-effectively-with-env-files-in-emacs
;; load-env-vars                  20180511.2210  installed             Load environment variables from files
;; To load a .env file into your Emacs environment,
;; we read and parse the dot env file
;(use-package load-env-vars
;  :ensure t)

(use-package dot-env
  :ensure t  ; <-- This is the most important part!
  ;;:hook
  ;; This automatically loads the .env file when you enter programming modes
  ;;(prog-mode . dotenv-file-load-file))
  )

(defvar fzl-dotenv-filename "dot_env"
  "The name of the .env file.")

(defun fzl-find-dotenv-nearest ()
  "Find the closest .env file in the directory hierarchy."
  (let* ((env-file-directory (locate-dominating-file "." fzl-dotenv-filename))
        (file-name (concat env-file-directory fzl-dotenv-filename)))
    (when (file-exists-p file-name)
        file-name)))

(defun fzl-dotenv-variables-setup ()
  "Export all environment variables in the closest .env file."
  (let ((env-file (fzl-find-dotenv-nearest)))
    (when env-file
      (load-env-vars env-file))))

(fzl-dotenv-variables-setup)

(provide 'pkgconfig-load-env-vars)
