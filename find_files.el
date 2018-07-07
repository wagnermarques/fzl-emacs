(provide 'find_files)

(setq remote-machine-ip (getenv "FZL_REMOTE_MACHINE_IP"))

(find-file (concat **EMACSINITFILE_HOME**  "/emacsinitfile.log"))
(find-file (concat remote-machine-ip "/emacsinitfile.log"))
;(find-file (concat **EMACSINITFILE_HOME**  "/elfeed_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_installation.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_installation.sh"))
;(require 'autocomplete_installation)


;(find-file (concat **EMACSINITFILE_HOME** "/README.md"))

;(find-file (concat **EMACSINITFILE_HOME** "/README.md")) 
;(find-file (concat **EMACSINITFILE_HOME** "/init.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/config_code_lisp.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/config_global_variables.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/config_package_system.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/config_general_emacs_behaviour.el"))

;(find-file (concat **EMACSINITFILE_HOME** "/config_lines_columns_and_cursor_behaviour.el"))



;(find-file (concat **EMACSINITFILE_HOME**  "/index.org"))
;(find-file (concat **EMACSINITFILE_HOME**  "/config_buffers.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/fzl_functions.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/fzl_keys.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/fzl_utils.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/config_code_in_general.el"))


;;CONFIG PACKAGES
;(find-file (concat **EMACSINITFILE_HOME**  "/cedet_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/autocomplete_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/js_mode_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/sql_mode_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/calendar_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/yasnippet_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/config_code_c_style_for_K_and_RStyle.el"))

;(find-file (concat **EMACSINITFILE_HOME**  "/speedbar_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/calendar_config.el"))
;(find-file (concat **EMACSINITFILE_HOME**  "/config_code_c_style_for_K_and_RStyle.el"))

;(find-file (concat *FZL_HOME* "/bin/fzl_startup.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_env_config.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_config_env.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_config_paths.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_config_variables.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_env_setup.sh"))
;(find-file (concat *FZL_HOME* "/bin/fzl_env_setup_runner.c"))
;(find-file (concat *FZL_HOME* "/bin/fzl_utils.sh"))

;(split-window-below)
(find-file (concat **EMACSINITFILE_HOME** "/emacsinitfile.log"))
