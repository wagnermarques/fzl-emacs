;;; package --- Summary

;;; Commentary:
;;http://ergoemacs.org/emacs/emacs_abbrev_mode.html

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-
;; sample use of abbrev

(clear-abbrev-table global-abbrev-table)

(define-abbrev-table 'global-abbrev-table
  '(

    ;;lisp coding
    ("lispFileHeader"
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
#+Subtitle:")

    ("orgImgConfig"     
"#+CAPTION: Weight space
#+attr_html: 
#+ATTR_HTML: :width 100px :alt altStr :title titleStr :align center
#+attr_latex: :width 100px
#+ATTR_ORG: :width 100px"
     )
     
    ("equ" "
  \\begin{equation} \\label{eq:str1}

  \\end{equation}
")
    
    ;;Org mode files for jekyll
    ("orgJekyllPost"
"#+TITLE: PostTitleHere
#+AUTHOR: Wagner
#+JEKYLL_LAYOUT: home
#+JEKYLL_POST_EXCERPT: PostExcerpt
#+JEKYLL_CATEGORY: aulas
#+JEKYLL_PERMALINK:/aulas/:title
#+JEKYLL_DATE: {{ page.date }}"
)


    ;;Org mode files
    ("orgPlanodeaula" "* Tema
* Objetivo
* Duração
* Pré-Requisitos
** Conhecimentos Prévios
** Recursos

* Procedimento didatico
* Exercicioos e Atividades de Reflexão/Fixação
* Avaliação
* Referencias

")

    
    ("utf8" "-*- coding: utf-8 -*-" )

    ;; regex
    ("rxAlphanumeric" "\\([A-Za-z0-9]+\\)" )

    ("hr" "--------------------------------------------------" )
    
 ))

(set-default 'abbrev-mode t)

(setq save-abbrevs nil)

(provide 'config_abbrev)
;;; config_abbrev.el ends here
