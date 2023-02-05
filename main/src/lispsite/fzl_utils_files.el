;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

;;https://stackoverflow.com/questions/2592095/how-do-i-create-an-empty-file-in-emacs
(defun fzl-create-empty-file-if-no-exists(filePath)
  "Touch a file witn FILEPATH parameter."
  (if (file-exists-p filePath)
      (message (concat  "File " (concat filePath " already exists")))
    (with-temp-buffer (write-file filePath))))

(provide 'fzl_utils_files)
;;; this_file_name.el ends here
