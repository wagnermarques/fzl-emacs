;;https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-shell.html

;; active shell in Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))


;; Append shell script templates to org-structure-template-alist
(add-to-list 'org-structure-template-alist '("s1" . "src shell"))
(add-to-list 'org-structure-template-alist '("s2" . "src shell :session s1 :exports both :results output"))
(add-to-list 'org-structure-template-alist '("s3" . "src shell :session s1 :exports both :results output"))
(add-to-list 'org-structure-template-alist '("s4" . "src shell :results output"))
(add-to-list 'org-structure-template-alist '("s5" . "src shell :noweb yes"))


;; configure template insertions for babel block codes
(setq org-structure-template-alist
      '(("s1" . "src shell") ;;C-c C-, sh  will insert     #+BEGIN_SRC shell
        ("s2" . "src shell :session s1 :exports both :results output")
        ("s3" . "src shell :session s1 :exports both :results output")
        ("s4" . "src shell :results output") ;;C-c C-, sh-r will insert:  #+BEGIN_SRC shell :results output
        ("s5" . "src shell :noweb yes");;C-c C-, sh-n will insert:  #+BEGIN_SRC shell :noweb yes
        ;; Add more templates as needed
        ))


;; Ensure org-tempo is required for easy template expansion
(require 'org-tempo)
(provide 'config-mode-orgmode-babel-shell)
