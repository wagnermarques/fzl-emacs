(use-package zotxt
  :ensure t
  :config
  (require 'zotxt)
  (add-hook 'org-mode-hook 'org-zotxt-mode)
  ;; Update deprecated functions and variables
  (defalias 'org-make-link-string 'org-link-make-string)
  (defvaralias 'org-any-link-re 'org-link-any-re))

(provide 'pkgconfig-org-zotxt)
