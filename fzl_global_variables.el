;; Set the debug option to enable a backtrace when a
;; problem occurs.
(setq debug-on-error t)

(provide 'global_variables)

(message "#properties.el loaded sucessfully")



(setq *FZL_HOME* (getenv "FZL_HOME"))
(message "-----------------------------------")
(message concat("*FZL_HOME* = " *FZL_HOME*))
(message "-----------------------------------")

;if *FZL_HOME* does not setted as a enviromental variable
;initialize it as a hard coded value.
;this variable is important to compose all the others
(if  (eq nil *FZL_HOME*)
     (message (shell-command "ls"))
     (defvar *FZL_HOME* (getenv "FZL_HOME")))
(message "*FZL_HOME* = " (concat *FZL_HOME*))

(defvar *fzl_emacs_config_dir* (concat *FZL_HOME* "/etc/emacs"))
(message "*fzl_emacs_config_dir* = " (concat *fzl_emacs_config_dir*))

(defvar *fzl_emacsinitfile_dir* (concat *fzl_emacs_config_dir* "/checkouts/emacsinitfile"))
(defvar *fzl_emacs_packages_checkouts* (concat  *fzl_emacs_config_dir* "/checkouts"))
;(defvar *fzl_emacs_packages* (concat *FZL_HOME* "/etc/emacs/sitelisp/packages"))

(defvar *fzl-backup-dir* (concat *FZL_HOME* "~/fzlbpms/backups/emacs/autosaved_files"))

(defvar *fzl_shared_schemas* (concat *FZL_HOME* "/shared/schemas"))

(setq *current-time-at-emacs-startup* (current-time))
;http://ergoemacs.org/emacs/elisp_datetime.html
(print (format-time-string "%B %A %d-%m-%Y %T"))



