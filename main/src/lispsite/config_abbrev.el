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
    

    ("fileHeaderOrg" "
#+TITLE: TheTitleHere
#+SUBTITLE: TheSubTitle
#+DESCRIPTION:
#+KEYWORDS:
#+EXPORT_FILE_NAME:
#+LANGUAGE: pt-BR
#+EXCLUDE_TAGS: noexport
#+EXPORT_EXCLUDE_TAGS: noexport
#+AUTHOR:    wagner
#+EMAIL:     wagner.marques3@etec.sp.gov.br
#+DATE:


#+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:nil toc:nil ltoc:t mouse:underline buttons:0 path:https://orgmode.org/org-info.js
#+EXPORT_SELECT_TAGS: export

#+LINK_UP:
#+LINK_HOME:

#+OPTIONS: H:2 toc:t

#+LaTeX_CLASS_OPTIONS: [bigger]
#+LATEX_HEADER: \\usepackage[margin=0.5in]{geometry}

")

    ("fileHeaderOrgBeamer" "
#+TITLE: TheTitleHere
#+SUBTITLE: TheSubTitle
#+DESCRIPTION:
#+KEYWORDS:
#+EXPORT_FILE_NAME:
#+LANGUAGE: pt-BR
#+EXCLUDE_TAGS: noexport
#+EXPORT_EXCLUDE_TAGS: noexport
#+AUTHOR:    wagner
#+EMAIL:     wagner.marques3@etec.sp.gov.br
#+DATE:


#+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:nil toc:nil ltoc:t mouse:underline buttons:0 path:https://orgmode.org/org-info.js
#+EXPORT_SELECT_TAGS: export

#+LINK_UP:
#+LINK_HOME:

#+OPTIONS: H:2 toc:t

#+startup: beamer
#+LaTeX_CLASS: beamer
#+LaTeX_CLASS_OPTIONS: [bigger]
#+BEAMER_THEME: Copenhagen [height=20pt]
#+BEAMER_FRAME_LEVEL: 1

#+BEAMER_HEADER: \\subtitle{Document subtitle}
#+BEAMER_HEADER: \\institute[INST]{Etec Zona Leste\\\\url{https://eteczonaleste.com.br/}}
#+BEAMER_HEADER: \\titlegraphic{\\includegraphics[height=1.5cm]{InstLogo}}
#+BEAMER_HEADER: \\author{\\texorpdfstring{Prof Wagner França\\newline\\url{wagner.marques3@etec.sp.gov.br}}{Prof Wagner Franca}} % BAD ORDER XXX
")
    
    ("orgIncludeOrgFile" "#+INCLUDE: ./x/asdf.org")
    ("orgIncludeHtmlFile" "#+INCLUDE: ./fil.html :src html :lines \"x-y\"")
    ("orgLink" "[[./x/asdf.org][lknName]]")
    
    ;;;org Img Config
    ("orgImg" "
#+CAPTION: Site do Nodejs
#+ATTR_HTML: :width 600px :alt altStr :title titleStr :align center
#+attr_latex: :width 150px
#+ATTR_LATEX: :height 8cm :placement [!htpb]
#+ATTR_LATEX: :options angle=0
#+ATTR_LATEX: :caption \bicaption{HeadingA}{HeadingB}
#+ATTR_ORG: :width 100px
[[file:./imgs/imgname.png]]")
     
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
    ("orgPlanoDeAula" "* Tema
* Justificativa e Objetivos
* Duração
* Pré-Requisitos
** Conhecimentos Prévios
** Recursos

* Procedimento didatico
* Exercicioos e Atividades de Reflexão/Fixação
* Avaliação
* Referencias

")
     ;;https://orgmode.org/manual/Environment-of-a-Code-Block.html
     ("orgSrcR"  "
#+NAME:
#+HEADER: :file myplot.png
#+HEADER: :dir .
#+BEGIN_SRC R :session s1 :results output :exports both

#+END_SRC")

     
     ("orgSrcC++"  "
#+NAME:
#+HEADER: :file myplot.png
#+HEADER: :dir .
#+BEGIN_SRC C++ :session s1 :results output :exports both
  printf(\"%d\\n\", 1+2);
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

      
      ("orgSrcJava" "
#+NAME:
#+HEADER: :classname Main
#+BEGIN_SRC java :session s1 :results output :exports both
  public class Main{
    public static void main(String args[]){
      System.out.println(\"asdf\");
    }
  }
#+END_SRC")

      
      ("javamainmethod" "public static void main(String[] args){

}")
      ("sysout" "System.out.println();")
           

      ("orgSrcSql" "
#+NAME:
#+BEGIN_SRC sql :session s1 :results output :exports both

#+END_SRC")

       ("orgSrcElisp" "
#+NAME: elispXXX
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
