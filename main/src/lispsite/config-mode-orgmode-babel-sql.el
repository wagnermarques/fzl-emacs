(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(setq org-babel-sql-executable "path/to/your/sql/executable")

(add-to-list 'org-structure-template-alist '("sql p" . "src sql :engine postgresql :dbhost localhost :dbuser pguser :dbpassword 1234 :database dbname"))
(add-to-list 'org-structure-template-alist '("sql m" . "src sql :engine mysql :dbhost localhost :dbuser pguser :dbpassword 1234 :database dbname"))

(provide 'config-mode-orgmode-babel-sql)

