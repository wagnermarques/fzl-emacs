(require 'org)

;; Definir tags personalizadas (opcional)
(setq org-tag-alist '((:startgroup)
                      ("@work" . ?w)
                      ("@home" . ?h)
                      (:endgroup)
                      ("urgent" . ?u)
                      ("important" . ?i)
                      ("project" . ?p)))

;; Ativar a seleção de tags com o menu
(setq org-use-fast-tag-selection t)


(provide 'config-mode-orgmode-tags)
