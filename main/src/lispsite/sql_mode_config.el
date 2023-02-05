;Controlling history of sql mode
;http://how-to.linuxcareer.com/customizing-emacs-for-development

;good SQL mode must know how to deal with various database sql implementations in order to be useful
; have a look at the more bleeding-edge Lisp:sql, but we will just look at SqlMode.

;Let's get to work.
;To get to the SQL interpreter from a window already in SQL mode, do this:
;M-x sql-set-sqli-buffer Return *SQL* Return.

;What follows is a very practical code snippet for saving history separately for each SQL dialect (e.g. Sybase, MSSQL, and so on).
;In order for this to work, just create a sql directory under ~/.emacs.d, then add this hook to ~/.emacs:
(defun my-sql-save-history-hook ()
    (let ((lval 'sql-input-ring-file-name)
          (rval 'sql-product))
      (if (symbol-value rval)
          (let ((filename
                 (concat (concat *fzl_dot_emacs_dir* "/sql-history/")
                         (symbol-name (symbol-value rval))
                         "-history.sql")))
            (set (make-local-variable lval) filename))
        (error
         (format "SQL history will not be saved because %s is nil"
                 (symbol-name rval))))))
  (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

(provide 'sql_mode_config)
