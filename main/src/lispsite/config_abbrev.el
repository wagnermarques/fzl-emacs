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

    ;;php with laravel
    ("html5Blade"
     "<!DOCTYPE html>
<html lang=\"{{ str_replace('_', '-', app()->getLocale()) }}\">
    <head>
        <meta charset=\"utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">

        <title>PAGE TITLE</title>

        <!-- Fonts -->
        <link href=\"https://fonts.googleapis.com/css?family=Nunito:200,600\" rel=\"stylesheet\">

        <!-- Styles -->
        <style>
            html, body {
                background-color: #fff;
                color: #636b6f;
                font-family: 'Nunito', sans-serif;
                font-weight: 200;
                height: 100vh;
                margin: 0;
            }

            .full-height {
                height: 100vh;
            }

            .flex-center {
                align-items: center;
                display: flex;
                justify-content: center;
            }

            .position-ref {
                position: relative;
            }

            .top-right {
                position: absolute;
                right: 10px;
                top: 18px;
            }

            .content {
                text-align: center;
            }

            .title {
                font-size: 42px;
            }

            .m-b-md {
                margin-top: 14px;
            }
        </style>
    </head>
    <body>
        <div class=\"flex-center position-ref full-height\">
            @if (Route::has('xxx'))
                <div class=\"top-right links\">
                    @auth
                        <h1>AUTH FOI TRUE</h1>
                        <a href=\"{{ url('/xxxx') }}\">Home</a>
                    @else
                        <h1>AUTH FOI FALSE</h1>
                        <a href=\"{{ route('yyyyy') }}\">Login</a>

                        @if (Route::has('register'))
                            <a href=\"{{ route('register') }}\">Register</a>
                        @endif
                    @endauth
                </div>
            @endif

            <div class=\"content\">
                <div class=\"title m-b-md\">
                    PAGE TITLE GRANDE
                </div>

            </div>
        </div>
    </body>
</html>

")
    
    
    ;;shellscript
    ("fileHeaderShellScript"
     "#!/bin/bash")
    
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
    ("orgIncludeJsFile" "#+INCLUDE: ./fil.js :src js :lines \"x-y\"")
    ("orgIncludeHtmlFile" "#+INCLUDE: ./fil.html :src html :lines \"x-y\"")
    ("orgIncludeSqlFile" "#+INCLUDE: ./fil.sql :src sql :lines \"x-y\"")
    ("orgIncludePhpFile" "#+INCLUDE: ./fil.php :src php :lines \"x-y\"")
    ("orgIncludeCFile" "#+INCLUDE: ./fil.c :src c :lines \"x-y\"")
    ("orgIncludeXMLFile" "#+INCLUDE: ./fil.xml :src xml :lines \"x-y\"")
    
    ("orgLink" "[[./x/asdf.org][lknName]]")
    
    ;;;org Img Config
    ("orgImg" "
#+CAPTION: Image Caption
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
* Duracao
* Pre-Requisitos
** Conhecimentos Previos
** Recursos
** Recomendacoes
   Leia de boa, sem ansiedade...
   Nao deixe de perguntar pro prof qdo tiver duvidas ok?
   Visite os links da referencia pra conhece-los, pelo menos
* Procedimento didatico
* Exercicioos e Atividades de Reflexao/Fixacao
* Avaliacao
* Referencias

")
    ;;https://orgmode.org/manual/Environment-of-a-Code-Block.html
            
     ("orgSrcE"  "
#+NAME:
#+BEGIN_EXAMPLE

#+END_EXAMPLE")

     
     ("orgSrcSqlite"  "
refs:
   https://www.orgmode.org/worg/org-contrib/babel/header-args.html
   https://orgmode.org/manual/Using-Header-Arguments.html

#+name: sqlite-populate-test
#+header: :results replace
#+header: :dir ~/temp/
#+header: :db test-sqlite.db
#+begin_src sqlite
  create table entregas(
     nome varchar(50),
     Sobrenome varchar(50),
     email varchar(100),
     forum varchar(2),
     quest integer,
     linkgithub varchar(2));

   insert into emtregas ...;
#+end_src
")

         ("orgSrcSqliteCmd"  "
refs:
   https://sqlite.org/cli.html

#+header: :dir /home/wagner/fzlbpms/data/sqlite
#+header: :db etec-BDIII-Sem1-entregas.db
#+name: sqlite command line
#+header: :colnames yes
#+header: :var tbName=\"tbAbc\" n=10 bkname=\"etec-BDIII-Sem1-entregas-bk\"
#+begin_src sqlite
  #on|off
  .headers on

  #ascii|column|csv|html|insert|line|list|quote|tabs|tcl
  .mode html


  #Output for the next SQL command only to FILE
  # (-e|-x|FILE)
  #.once
  
  #Send output to FILE or stdout if FILE is omitted
  #.output


  #.databases
  #.dbconfig

  #.backup $bkname
  #.restore ?DB? FILE       Restore content of DB (default \"main\") from FILE
  
  #?TABLE?          List names of tables matching LIKE pattern TABLE
  .tables
#+end_src

")

     ("orgSrcSqliteImportOrgTable"  "
refs:
   https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-sqlite.html


#+header: :dir /home/wagner/fzlbpms/data/sqlite
#+header: :db etec-BDIII-Sem1-entregas.db
#+name: Etec-BDIII-Sem1-entregas
#+header: :colnames yes
#+header: BDIII-Sem1-entregas
#+header: :var tbName=\"entregas\" orgtable=\"entregas\" n=10
#+begin_src sqlite
  drop table if exists $tbName;

  create table $tbName(
      nome varchar(30),
      Sobrenome varchar(30),
      forum varchar(2),
      quest integer,
      linkDeProjeto varchar(200),
      comentarios varchar(200));

    .mode csv $tbName
    .import $orgtable $tbName

    .tables
#+end_src


")

    
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


     ("orgSrcC"  "
#+NAME:
#+HEADER: :file myplot.png
#+HEADER: :dir .
#+BEGIN_SRC C :session s1 :results output :exports both
  printf(\"%d\\n\", 1+2);
#+END_SRC")
     

     ("orgSrcJs"  "
#+NAME:
#+BEGIN_SRC js :session s1 :results output :exports code
  
#+END_SRC")

     
     ("orgSrcPhp"  "
#+NAME:
#+BEGIN_SRC php :session s1 :results output :exports code
  
#+END_SRC")

     
     ("orgSrcHTML" "
#+NAME:
#+BEGIN_SRC html :session s1 :results output :exports both

#+END_SRC

#+NAME:
#+BEGIN_EXPORT html
  
#+END_EXPORT"
     )

     ("orgSrcXML" "
#+NAME:
#+BEGIN_SRC xml :session s1 :results output :exports code

#+END_SRC"
     )


     ("orgSrcRestclient" "
#+NAME:
#+BEGIN_SRC restclient :session s1 :results output :exports both
   POST --header 'Content-Type: application/json'  http://localhost:8081/service/rest/v1/script
#+END_SRC")

     ("orgSrcShell" "

#+NAME: parseShellAnsiColorCharacters
#+BEGIN_SRC elisp :session s1 :var data=""  :results silent  :exports node
  (print (ansi-color-apply data))
#+END_SRC


#+NAME:
#+BEGIN_SRC shell :session s1 :results output :exports both :post parseShellAnsiColorCharacters(data=*this*)

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

      
      ("pvsm" "public static void main(String[] args){

}")

      ("sysout" "System.out.println();")

      ("orgFn" "[fn:]")

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
    
    )

  );;(define-abbrev-table 'global-abbrev-table'(



(set-default 'abbrev-mode t)

(setq save-abbrevs nil)

(provide 'config_abbrev)
;;; config_abbrev.el ends here
