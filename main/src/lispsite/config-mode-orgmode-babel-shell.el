;;https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-shell.html

;; active shell in Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))

;; configure template insertions for babel block codes
(setq org-structure-template-alist
      '(("sh" . "src shell") ;;C-c C-, sh  will insert     #+BEGIN_SRC shell
        ("sh-a" . "src shell :session s1 :exports both :results output")
        ("sh-b" . "src shell :session s1 :exports both :results output")
        ("sh-r" . "src shell :results output") ;;C-c C-, sh-r will insert:  #+BEGIN_SRC shell :results output
        ("sh-n" . "src shell :noweb yes");;C-c C-, sh-n will insert:  #+BEGIN_SRC shell :noweb yes
        ;; Add more templates as needed
        ))

;; org-insert-template-structure does not insert #+NAME at the top of the code block
;; this function do it 
(defun fzl-org-insert-structure-template-after-advice--src-shell-blocks (&rest _args)
  "Insert #+NAME: srcName after the structure template."
  (forward-line -2)
  (beginning-of-line)
  (insert "#+name: "))

(advice-add 'org-insert-structure-template
            :after
            #'fzl-org-insert-structure-template-after-advice--src-shell-blocks)


;; Ensure org-tempo is required for easy template expansion
(require 'org-tempo)
(provide 'config-mode-orgmode-babel-shell)
