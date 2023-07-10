;;  mysql-to-org       20210622.447  available  melpa      Minor mode to output the results of mysql queries to org tables
;;  emacsql-mysql      20230225.2205 available  melpa      EmacSQL back-end for MySQL
;;  emacsql-pg         20230224.1201 available  melpa      EmacSQL back-end for PostgreSQL via pg
;;  emacsql-psql       20230225.2205 available  melpa      EmacSQL back-end for PostgreSQL via psql
;;  emacsql-sqlite     20230225.2205 available  melpa      EmacSQL back-end for SQLite
;;  emacsql-sqlite-module 20230409.1847 available  melpa      EmacSQL back-end for SQLite using a module
;;  format-sql         20150422.1333 available  melpa      Use format-sql to make your SQL readable in directly Emacs.

(use-package format-sql
  :ensure t)


(require 'format-sql)
(add-hook 'sql-mode-hook 'format-sql-mode)

;;Manually format SQL code:
;;You can use the
;;format-sql-buffer command (M-x format-sql-buffer) to format the entire buffer
;;format-sql-region command (M-x format-sql-region) to format a selected region.

;;to auto-formatting on save
(add-hook 'sql-mode-hook 'format-sql-on-save-mode)

;;sql tooling
;;sql clients
(setq _SQUIREL_SQL_HOME_ "/media/wgn/ext4/PROGSATIVOS/db-clients/squirrelsql-4.6.0-optional")

(defun fzl-squirelsql-start()
  "Run SQuirreL SQL Client and show the logs in a buffer."
  (interactive)
  (let* ((squirrel-sql-home "/media/wgn/ext4/PROGSATIVOS/db-ides/squirrelsql-4.6.0-optional")
         (squirrel-sql-sh (concat squirrel-sql-home "/squirrel-sql.sh"))
         (buffer-name "*SQuirreL SQL Logs*"))
    (with-current-buffer (get-buffer-create buffer-name)
      (erase-buffer)
      (ansi-term "/bin/bash" buffer-name)
      (term-send-string (get-buffer-process buffer-name) squirrel-sql-sh)
      (term-char-mode))))

(global-set-key (kbd "C-c s") #'fzl-squirelsql-start)


(provide 'coding-sql)
