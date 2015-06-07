(provide 'fzl_functions)

;;UPDATE THIS FUNCTION
(defun print_fzl_global_variables ()

  ;;iterate e print name and value of the variable list
  
  ;;  (message (concat "*FZL_HOME* = " *FZL_HOME*))
  ;;  (message (concat "*USERNAME* = " *USERNAME*))
  ;;  (message (concat "*USER* = " *USER*))
  ;;  (message (concat "*FZL_VERSION* = " *FZL_VERSION*))
  ;;  (message (concat "*MAIL* = " *MAIL*))
  
  ;;  (message (concat "*fzl_emacs_config_dir* = " *fzl_emacs_config_dir* ))
  ;; (message (concat "*fzl_emacsinitfile_dir* = " *fzl_emacsinitfile_dir* ))
  ;;  (message (concat "*fzl_emacs_packages_checkouts* = " *fzl_emacs_packages_checkouts*))
  ;;  (message (concat "*fzl_emacs_packages* = " *fzl_emacs_packages* ))
  ;;  (message (concat "*fzl-backup-dir* = " *fzl-backup-dir* ))
  ;;  (message (concat "*fzl_shared_schemas* = " *fzl_shared_schemas* ))

)

(defun fzl-set-default-directory-to-FZL_HOME-etc() 
  'set default directory to FZL_HOME etc' 
  (interactive)
  (setq default-directory (concat *FZL_HOME* "/etc"))
  (speedbar-refresh))

(defun fzl-bash-find-files-with-grep (dir, grepPattern)
  "find dir -type f -exec grepPattern -l {} ';'"
  (interactive "sdir a ser pesquisado: \nsgrepPattern: ")
   (message (shell-command-to-string
    (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"))))

(defun fzl-bash-find-files-by-name-pattern (dir, namePattern)
  "find dir -type f -name '*namePattern'"
  (interactive "sdir to be searched: \nsnamePattern: ")
   (message (split-string (shell-command-to-string
    (format "find %s -type f -name '*namePattern*'")))))

;(svt 'klklkl')


;(defun svt-find-grep (sDiretorio, sGrepPattern)
;  "find dir -type f -exec grepIt -l {} ';'"
;  (interactive "sDiretorio a ser pesquisado \nsGrepPattern")
;  (shell-command-to-string
;   (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"
;           (expand-file-name dir t) 
;           (sGrepPattern))))


;(defun svt-find-and-grep-files (dir, grepIt)
;  "find dir -type f -exec grepIt -l {} ';'" 
; (shell-command-to-string
;    (format "find %s -type f -exec grep %s {} ';'"
;            (expand-file-name dir t) grepIt)));


;(svt-find-and-grep-files "." "auto-complete-config")

;(message (exec-to-string "pwd"))
;(defun multiple-hello (someone num)
;  "Say hello to SOMEONE via M-x hello, for NUM times."
;  (interactive "sWho do you want to say hello to? \nnHow many times? ")
;  (dotimes (i num)
;    (insert (format "Hello %s!\n" someone))))


;http://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Sequences.html


