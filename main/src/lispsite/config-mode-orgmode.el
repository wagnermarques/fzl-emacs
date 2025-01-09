;; org-insert-template-structure does not insert #+NAME at the top of the code block
;; this function do it 
(defun fzl-org-insert-structure-template-after-advice--set-block-name (&rest _args)
  "Insert #+NAME: srcName after the structure template."
  (forward-line -2)
  (beginning-of-line)
  (insert "#+name: "))

(advice-add 'org-insert-structure-template
            :after
            #'fzl-org-insert-structure-template-after-advice--set-block-name)

;; Prevent Org from running Babel code during export
(setq org-export-use-babel nil)

(require 'config-mode-orgmode-babel)
(require 'config-mode-orgmode-babel-plantuml)
(require 'config-mode-orgmode-babel-shell)
(require 'config-mode-orgmode-babel-php)
(require 'config-mode-orgmode-babel-sql)
(require 'config-mode-orgmode-tags)

(provide 'config-mode-orgmode)
 
