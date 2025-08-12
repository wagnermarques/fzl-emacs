(use-package ob-php
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(php . t)))

(add-to-list 'org-structure-template-alist '("php" . "src php :exports code"))

(provide 'config-mode-orgmode-babel-php)
