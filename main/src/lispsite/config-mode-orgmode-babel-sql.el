;; Load Org Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

;; Set up the SQL executable path
(setq org-babel-sql-executable "path/to/your/sql/executable")

;; Example SQL source code block
;#+BEGIN_SRC sql :engine postgresql :dbhost localhost :dbuser your_username :dbpassword your_password :database your_database
;SELECT * FROM your_table;
;#+END_SRC

(add-to-list 'org-structure-template-alist '("sql p" . "src sql :engine postgresql :dbhost localhost :dbuser pguser :dbpassword 1234 :database dbname"))
(add-to-list 'org-structure-template-alist '("sql m" . "src sql :engine mysql :dbhost localhost :dbuser pguser :dbpassword 1234 :database dbname"))

(provide 'config-mode-orgmode-babel-sql)

