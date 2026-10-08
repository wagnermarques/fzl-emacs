;;; pkgconfig-helm-bibtex.el --- Configuration for Helm BibTeX and Ebib -*- lexical-binding: t -*-

;;; Commentary:
;; This package configures `helm-bibtex` for searching and acting on BibTeX entries,
;; `ebib` for visual database management, and integrates with `org-ref`/`org-cite`.
;; It relies on environment variables set in `config-emacs-environment-variables.el`.

;;; Code:

(require 'use-package)

;; 1. Helm-BibTeX
(use-package helm-bibtex
  :ensure t
  :commands (helm-bibtex)
  :init
  ;; We map this to our Desktoping menu later, but we can also set a global key
  (global-set-key (kbd "C-c B") 'helm-bibtex)
  :config
  ;; Set the bibliography path using the user's environment variable if defined
  (let ((bib-dir (if (boundp 'fzlemacs-dir-bibnotes-home)
                     fzlemacs-dir-bibnotes-home
                   "~/bibtexfiles")))
    (setq bibtex-completion-bibliography (list (expand-file-name "references.bib" bib-dir)))
    (setq bibtex-completion-library-path (list (expand-file-name "pdfs" bib-dir)))
    (setq bibtex-completion-notes-path (expand-file-name "notes" bib-dir)))

  ;; Setup actions for helm-bibtex
  (setq bibtex-completion-pdf-open-function
        (lambda (fpath)
          (if (fboundp 'fzl-open-url-in-browser)
              (fzl-open-url-in-browser fpath)
            (call-process "xdg-open" nil 0 nil fpath))))

  ;; Add formatting for the Helm display
  (setq bibtex-completion-display-formats
        '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
          (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
          (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))))

;; 2. Ebib - A visual BibTeX manager (similar to Zotero's UI)
(use-package ebib
  :ensure t
  :commands (ebib)
  :config
  (let ((bib-dir (if (boundp 'fzlemacs-dir-bibnotes-home)
                     fzlemacs-dir-bibnotes-home
                   "~/bibtexfiles")))
    (setq ebib-preload-bib-files (list (expand-file-name "references.bib" bib-dir)))
    (setq ebib-notes-directory (expand-file-name "notes" bib-dir))
    (setq ebib-file-search-dirs (list (expand-file-name "pdfs" bib-dir)))))

;; 3. Org-ref (optional, for inserting citations like Zotero word processor plugin)
(use-package org-ref
  :ensure t
  :commands (org-ref-helm-insert-cite-link)
  :config
  (let ((bib-dir (if (boundp 'fzlemacs-dir-bibnotes-home)
                     fzlemacs-dir-bibnotes-home
                   "~/bibtexfiles")))
    (setq org-ref-default-bibliography (list (expand-file-name "references.bib" bib-dir)))
    (setq org-ref-pdf-directory (expand-file-name "pdfs" bib-dir))
    (setq org-ref-notes-directory (expand-file-name "notes" bib-dir))))

(provide 'pkgconfig-helm-bibtex)
;;; pkgconfig-helm-bibtex.el ends here
