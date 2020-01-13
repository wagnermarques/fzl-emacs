(print " =>=>=> test-load-path.el was loaded sucessfully!!!")

(setq load-path-copy load-path)

(while load-path-copy
  (message (car load-path-copy))
  (setq load-path-copy (cdr load-path-copy)))

(provide 'test-load-path)
