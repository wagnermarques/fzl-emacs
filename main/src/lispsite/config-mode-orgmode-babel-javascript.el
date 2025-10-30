
;; configure template insertions for babel block codes
      
(add-to-list 'org-structure-template-alist '("js1" . "src json :exports code"))
(add-to-list 'org-structure-template-alist '("js2" . "src javascript :exports code"))

 (use-package ob-js
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(js . t))
  (org-babel-do-load-languages 'org-babel-load-languages))

(use-package ob-json
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(json . t))
  (org-babel-do-load-languages 'org-babel-load-languages))

(provide 'config-mode-orgmode-babel-javascript)
