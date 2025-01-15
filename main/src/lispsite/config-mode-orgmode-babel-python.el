(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


(add-to-list 'org-structure-template-alist '("python" . "src python :session s1 :exports both :results output"))
(add-to-list 'org-structure-template-alist '("python" . "src python :session s1 :exports both :results graphics file output :file boxplot.svg"))

(provide 'config-mode-orgmode-babel-python)

