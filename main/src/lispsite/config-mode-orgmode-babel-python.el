(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


(add-to-list 'org-structure-template-alist '("python" . "src python :session s1 :shebang \"#!/usr/bin/env python3\" :exports both :results output"))
(add-to-list 'org-structure-template-alist '("python" . "src python :session s1 :shebang \"#!/usr/bin/env python3\" :exports both :results graphics file output :file boxplot.svg"))

(setq org-babel-python-command "python3")

(provide 'config-mode-orgmode-babel-python)

