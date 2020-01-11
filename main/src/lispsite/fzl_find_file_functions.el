;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-


(defun fzl-open-bookmark-emacs-configuration-files()
  "open-initel-file"
  (interactive)
  (find-file (concat *fzl_dot_emacs_dir*  "/find_files.el"))
)

(defun fzl-open-code-config-files()
  (interactive)
  "open code configurations files"
  (find-file (concat **fzl_dot_emacs_dir**  "/yasnippet_config.el"))
)

                                                                   
;(fzl-open-initel-file)
;(fzl-open-yasnippet-config)
;(fzl-open-yasnippet-el)
;(fzl-open-find_file_functions)

;;; this_file_name.el ends here
(provide 'fzl_find_file_functions)
