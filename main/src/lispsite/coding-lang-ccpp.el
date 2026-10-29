;;; coding-lang-ccpp.el --- C/C++ configuration -*- lexical-binding: t -*-

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)))
  ;; Templates for C and C++
  (add-to-list 'org-structure-template-alist '("c" . "src C :includes <stdio.h> :exports both :results output"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src C++ :includes <iostream> :exports both :results output")))

;; General C/C++ mode configuration
(use-package cc-mode
  :ensure nil
  :mode (("\\.c\\'" . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.h\\'" . c-or-c++-mode))
  :hook (c-mode-common . (lambda ()
                           (setq indent-tabs-mode nil)
                           (setq c-basic-offset 4))))

(provide 'coding-lang-ccpp)
;;; coding-lang-ccpp.el ends here

