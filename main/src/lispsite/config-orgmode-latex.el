
(setq FZLEMACS_BIBNOTES_HOME (env"FZLEMACS_BIB_HOME"))

;; Use the 'use-package' macro to ensure the following packages are installed and configured.
(use-package org
  :ensure t
  :config
  ;; Set Org-mode to use the 'insert-and-template' method for inserting citations.
  (setq org-cite-insertion-method 'insert-and-template)
  ;; Enable export of citations to BibTeX format.
  (setq org-cite-export-to-bibtex t)
  ;; Specify the file where bibliography notes are stored.
  (setq org-bibliography-notes "~/path/to/your/bibnotes.org"))

;; Configure org-ref for managing references in Org-mode.
(use-package org-ref
  :ensure t
  :config
  ;; Set the file for storing bibliography notes used by org-ref.
  (setq org-ref-bibliography-notes "~/path/to/your/bibnotes.org")
  ;; Set the main bibliography file for org-ref.
  (setq org-ref-bibliography-file "~/path/to/your/bibfile.bib")
  ;; Set the default bibliography file for org-ref.
  (setq org-ref-default-bibliography 'org-ref-bibliography-file)
  ;; Specify the file where bibliography notes are stored.
  (setq org-ref-bibliography-notes "~/path/to/your/bibnotes.org"))

;; Configure citar for managing citations in Org-mode.
(use-package citar
  :ensure t
  :config
  ;; Set the main bibliography file for citar.
  (setq citar-bibliography "~/path/to/your/bibfile.bib")
  ;; Specify the file where bibliography notes are stored.
  (setq citar-bibliography-notes "~/path/to/your/bibnotes.org")
  ;; Set the bibliography style for citations.
  (setq citar-bibliography-style '("apa" "mla" "chicago"))
  ;; Set the default bibliography file for citar.
  (setq citar-default-bibliography 'citar-bibliography)
  ;; Set the default file for storing bibliography notes.
  (setq citar-default-bibliography-notes 'citar-bibliography-notes)
  ;; Set the default bibliography style for citations.
  (setq citar-default-bibliography-style 'citar-bibliography-style))

;; Enable export of citations to BibTeX format in Org-mode.
(setq org-cite-export-to-bibtex t)
;; Specify the file where bibliography notes are stored in Org-mode.
(setq org-bibliography-notes "~/path/to/your/bibnotes.org")

;; configure sintaxe highlight of code exported in pdf
(setq org-latex-listings 'minted)
(setq org-latex-packages-alist '(("" "minted")))

(provide 'config-orgmode-latex)
