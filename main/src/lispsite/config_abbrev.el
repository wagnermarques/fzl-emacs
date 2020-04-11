;;; package --- Summary

;;; Commentary:
;;http://ergoemacs.org/emacs/emacs_abbrev_mode.html

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-
;; sample use of abbrev

(clear-abbrev-table global-abbrev-table)


;;; this_file_name.el ends here template
(define-abbrev-table 'global-abbrev-table
  '(

    ;;lisp coding
    ("fileHeaderLisp"
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
    
    ;;org File Header
    ("fileHeaderOrg" "#+Title: ATitle
#+Subtitle:
#+EXPORT_FILE_NAME: filename2.html
#+LANGUAGE: pt-BR
#+EXCLUDE_TAGS: noexport
try C-c C-e # (org-export-dispatch)
")

    ;;;org Img Config
    ("orgImgConfig" "
#+CAPTION: Weight space
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
    
     ("orgSrcR"  "
#+NAME:
#+BEGIN_SRC R :session s1 :results output :exports both

#+END_SRC")

     ("orgSrcHTML" "
#+NAME:
#+BEGIN_SRC html :session s1 :results output :exports both

#+END_SRC

#+NAME:
#+BEGIN_EXPORT html
  
#+END_EXPORT"
     )

     ("orgSrcRestclient" "
#+NAME:
#+BEGIN_SRC restclient :session s1 :results output :exports both
   POST --header 'Content-Type: application/json'  http://localhost:8081/service/rest/v1/script
#+END_SRC")

     ("orgSrcShell" "
#+NAME:
#+BEGIN_SRC shell :session s1 :results output :exports both

#+END_SRC")

      ("orgSrcSql" "
#+NAME:
#+BEGIN_SRC sql :session s1 :results output :exports both

#+END_SRC")

       ("orgSrcElisp" "
#+NAME: elispXXX
#+BEGIN_SRC elisp :session s1 :results output :exports both

#+END_SRC")

        ("orgSrcElisp" "
#+NAME:
#+BEGIN_SRC elisp :session s1 :results output :exports both

#+END_SRC")

        ("img" "
#+NAME:figX
#+CAPTION: figX
#+attr_ORG: :width 500px
#+attr_html: :width 500px
#+attr_latex: :width 500px
[[./imgs/XXX]]")

    ;;;setupUtf8
    ("utf8" "-*- coding: utf-8 -*-" )

    ;;; REGEX Alfanumeric
    ("rxAlphanumeric" "\\([A-Za-z0-9]+\\)" )

    ;;;horizontal line
    ("hr" "--------------------------------------------------" )
    
 ))

(set-default 'abbrev-mode t)

(setq save-abbrevs nil)

(provide 'config_abbrev)
;;; config_abbrev.el ends here
