(provide 'fzlfn_print_fzl_variables_inventory)
          
(defun fzlfn_print_fzl_variables_inventory ()
  ;iterate e print name and value of the variable list
  
  (message (concat "*FZL_HOME* = " *FZL_HOME*))
  (message (concat "*USERNAME* = " *USERNAME*))
  (message (concat "*USER* = " *USER*))
  (message (concat "*FZL_VERSION* = " *FZL_VERSION*))
  (message (concat "*MAIL* = " *MAIL*))

  (message (concat "*fzl_emacs_config_dir* = " *fzl_emacs_config_dir* ))
  (message (concat "*fzl_emacsinitfile_dir* = " *fzl_emacsinitfile_dir* ))
  (message (concat "*fzl_emacs_packages_checkouts* = " *fzl_emacs_packages_checkouts*))
  (message (concat "*fzl_emacs_packages* = " *fzl_emacs_packages* ))
  (message (concat "*fzl-backup-dir* = " *fzl-backup-dir* ))
  (message (concat "*fzl_shared_schemas* = " *fzl_shared_schemas* ))

  
)
