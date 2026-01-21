(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)))

;; Templates for C and C++
(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("c" . "src C :includes <stdio.h> :exports both :results output"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src C++ :includes <iostream> :exports both :results output")))

;; General C/C++ mode configuration
(use-package cc-mode
  :ensure nil
  :mode ("\.c\'" "\.cpp\'" "\.h\'")
  :hook (c-mode-common . (lambda ()
                           (setq indent-tabs-mode nil)
                           (setq c-basic-offset 4))))


(provide 'coding-lang-ccpp)

