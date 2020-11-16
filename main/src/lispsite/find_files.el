;;; package --- Summary
;;; Code:
;;; Commentary:

(provide 'find_files)
(defun fzl-find-file(fileName)
  "find-file in **EMACSINITFILE_HOME** directory with just the filename"
  (find-file (concat **EMACSINITFILE_HOME**  fileName)))

(fzl-fzl-find-file  "/index.org"))
(fzl-find-file "config_abbrev.el")
(fzl-find-file "org_mode_config.el")

(fzl-find-file (concat **EMACSINITFILE_HOME**  "/emacsinitfile.log"))
(fzl-find-file (concat **EMACSINITFILE_HOME**  "/elfeed_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_installation.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_installation.sh"))
;(require 'autocomplete_installation)

;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/config_buffers.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/fzl_functions.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/fzl_keys.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/fzl_utils.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/config_code_in_general.el"))


;;CONFIG PACKAGES
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/cedet_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/js_mode_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/sql_mode_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/calendar_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/yasnippet_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/config_code_c_style_for_K_and_RStyle.el"))

;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/speedbar_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/calendar_config.el"))
;(fzl-find-file (concat **EMACSINITFILE_HOME**  "/config_code_c_style_for_K_and_RStyle.el"))

;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_startup.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_env_config.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_config_env.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_config_paths.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_config_variables.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_env_setup.sh"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_env_setup_runner.c"))
;(fzl-find-file (concat *FZL_HOME* "/bin/fzl_utils.sh"))

;;; find_files.el ends here
