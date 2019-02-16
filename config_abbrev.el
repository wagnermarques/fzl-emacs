;;; package --- Summary

;;; Commentary:
;;http://ergoemacs.org/emacs/emacs_abbrev_mode.html

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-
;; sample use of abbrev

(clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(

    ;;lisp coding
    ("startLispCode"
     ";;; package --- Summary

;;; Commentary:

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

(provide 'this_file_name)
;;; this_file_name.el ends here"
    )

    ;;https://www.gnu.org/software/emacs/manual/html_node/elisp/Comment-Tips.html
    ("lispcodesectioncomment"
";;;;________________________________________
;;;
;;; Code Section
;;; 
;;; 
;;;________________________________________"
)
    
    ;;Org mode files
    ("orgFileHeader" "#+Title:
#+Subtitle")

    ("utf8" "-*- coding: utf-8 -*-" )

    ;; regex
    ("rxAlphanumeric" "\\([A-Za-z0-9]+\\)" )

    ("hr" "--------------------------------------------------" )
    
 ))

(set-default 'abbrev-mode t)

(setq save-abbrevs nil)

(provide 'config_abbrev)
;;; config_abbrev.el ends here
