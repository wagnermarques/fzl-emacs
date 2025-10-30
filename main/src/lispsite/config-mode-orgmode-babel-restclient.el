(use-package ob-restclient
  :ensure t)
  
(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))

(provide 'config-mode-orgmode-babel-restclient)
