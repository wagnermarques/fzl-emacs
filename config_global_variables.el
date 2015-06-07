(provide 'config_global_variables)

(message (concat (expand-file-name "./config_global_variables.el") " -> loaded sucessfully"))



(setq *FZL_HOME_NOT_DEFINED_MSG* "To integrate emacs with fzlbpms you must define FZL_HOME enviroment variable")

(if (eq nil *FZL_HOME*)
    (message *FZL_HOME_NOT_DEFINED_MSG*)
  (defvar *FZL_HOME* (getenv "FZL_HOME")))




(defvar **user-full-name** "wagnerdocri@gmail.com")
(defvar *user-mail-address* "administrador")

(defvar *fzl_emacs_config_dir* (concat *FZL_HOME* "/etc/emacs"))
(defvar *fzl_dot_emacs_dir* (concat *fzl_emacs_config_dir* "/lisp"))

;(defvar *fzl_emacs_packages_checkouts* (concat  *fzl_emacs_config_dir* "/checkouts"))
;(defvar *fzl_emacs_packages* (concat *FZL_HOME* "/etc/emacs/sitelisp/packages"))
;(setq *fzl_emacs_packages_downloaded* (concat *fzl_emacs_config_dir* "/downloaded-packages"))
(defvar *fzl-backup-dir* (concat *FZL_HOME* "/backups/emacs/autosaved_files"))
(defvar *fzl_shared_schemas* (concat *FZL_HOME* "/shared/xml_schemas"))
(setq *current-time-at-emacs-startup* (current-time))






