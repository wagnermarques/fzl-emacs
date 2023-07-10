(message "==>config-orgmode-easytemplates loaded sucessfully!!!")
;;https://orgmode.org/worg/org-contrib/babel/languages/index.html#configure
;;https://orgmode.org/worg/org-contrib/babel/languages/index.html

(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")
        ("s" . "src")
        ("E" . "src emacs-lisp :results output :exports both :wrap EXAMPLE")
        ("S" . "src sh :results output :exports both :wrap EXAMPLE")
        ("groovy" . "groovy :exports code")))


;;(R . t)
;;   (shell . t)
;;   (java . t) ;https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-java.html

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (shell . t)
   (sqlite . t)
   (R . t)))

;(use-package ob-sh
;  :ensure t
;  :init
;  (org-babel-do-load-languages
 ;  'org-babel-load-languages
 ;  '((shell . t))))
;

(provide 'orgmode-babel-codeblocks)
