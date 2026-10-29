;;; coding-lang-sql.el --- SQL language support for Org Babel -*- lexical-binding: t -*-
;;; Commentary:

;;
;; habilita usar :connection
;;#+name: select * from mdl_assign limit 10;
;;#+begin_src sql :connection moodle-psql :result table
;;select * from mdl_assign limit 10;
;;#+end_src
;;
;; precisa configurar a conexao antes
;; essa e uma de exemplo, mudar os parametros conforme a sua instalacao

;;; Code:

;; change accordingly to your setup
(setenv "PGPASSWORD" "1234")

;;; enable sql mode for org babel when org loads
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t))))

(use-package ob-sql-mode
  :ensure t
  :defer t)

(provide 'coding-lang-sql)
;;; coding-lang-sql.el ends here
