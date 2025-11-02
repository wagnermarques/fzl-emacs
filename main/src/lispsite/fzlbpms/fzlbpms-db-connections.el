;;sql-mysql and sql-postgresql connections for fzlbpms
(setq sql-connection-alist
      '(("fzlbpms-mysql:8.0"
         (sql-product 'mysql)
         (sql-server "127.0.0.1") 
         (sql-user "root")        
         (sql-database "fzl_db")      
         (sql-port 3316))

        ("fzlbpms-postgres:16-alpine"
         (sql-product 'postgres)
         (sql-server "localhost") 
         (sql-user "postgres")       
         (sql-database "fzldb")    
         (sql-port 5432))))

(provide 'fzlbpms-db-connections)
