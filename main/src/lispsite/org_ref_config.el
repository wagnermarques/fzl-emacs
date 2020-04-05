;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'org-ref)
;; -*- coding: utf-8; lexical-binding: t; -*-

;;(org-babel-load-file "../etc/org-ref.org")

(setq reftex-default-bibliography '("./etc/bibliografia.bib"))

(setq org-ref-bibliography-notes (concat **EMACSINITFILE_HOME** "/etc/bibliografia_notes.org")
      org-ref-default-bibliography '(concat **EMACSINITFILE_HOME** "/etc/bibliografia.bib")
      org-ref-pdf-directory (concat **EMACSINITFILE_HOME** "/etc/bibtex-pdfs/"))
      
(provide 'org_ref_config.el)
;;; org_ref_config.el ends here
