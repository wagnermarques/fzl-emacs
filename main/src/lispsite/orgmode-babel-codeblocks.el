(message "==>orgmode-babel-codeblocks.el loaded sucessfully!!!")
;;https://orgmode.org/worg/org-contrib/babel/languages/index.html#configure
;;https://orgmode.org/worg/org-contrib/babel/languages/index.html

;;some languages to use with babel code blocks
;;ob-ada-spark                   20221114.2007  available    melpa    Babel functions for Ada & SPARK
;;ob-applescript                 20190709.1607  available    melpa    Org-babel functions for AppleScript
;;ob-async                       20210428.2052  available    melpa    Asynchronous org-babel src block execution
;;ob-axiom                       20220612.1535  available    melpa    An org-babel backend for the axiom-environment system
;;ob-bitfield                    20220401.600   available    melpa    Babel Functions for bitfield
;;ob-blockdiag                   20210412.1541  available    melpa    org-babel functions for blockdiag evaluation

;;ob-cfengine3                   20230226.1954  available    melpa    Org Babel functions for CFEngine 3
;;ob-chatgpt-shell               20230708.1957  available    melpa    Org babel functions for ChatGPT evaluation
;;ob-clojurescript               20180406.1828  available    melpa    org-babel functions for ClojureScript evaluation
;;ob-coffee                      20170725.1424  available    melpa    org-babel functions for coffee-script evaluation
;;ob-coffeescript                20180126.719   available    melpa    org-babel functions for coffee-script evaluation, and fully implementation!
;;ob-compile                     20220830.315   available    melpa    Run compile by org-babel
;;ob-crystal                     20180126.718   available    melpa    org-babel functions for Crystal evaluation
;;ob-cypher                      20200521.936   available    melpa    query neo4j using cypher in org-mode blocks
;;ob-d2                          20230314.352   available    melpa    Org-babel functions for d2
;;ob-dall-e-shell                20230708.1957  available    melpa    Org babel functions for DALL-E evaluation
;;ob-dao                         20170816.1558  available    melpa    Org Babel Functions for Dao
;;ob-dart                        20221201.633   available    melpa    Evaluate Dart source blocks in org-mode
;;ob-deno                        20201019.101   available    melpa    Babel Functions for Javascript/TypeScript with Deno
;;ob-diagrams                    20160407.1237  available    melpa    org-babel functions for diagrams evaluation
;;ob-drawtiming                  20230312.1740  available    melpa    Functions for drawtiming evaluation in org-babel
;;ob-dsq                         20220915.1610  available    melpa    Babel functions for the `dsq` CLI tool by Multiprocess Labs
;;ob-elixir                      20170725.1419  available    melpa    org-babel functions for elixir evaluation
;;ob-elm                         20200528.1857  available    melpa    Org-babel functions for elm evaluation
;;ob-elvish                      20180427.1900  available    melpa    org-babel functions for Elvish shell
;;ob-ess-julia                   20210414.1444  available    melpa    Org babel support for Julia language
;;ob-ffuf                        20221004.1715  available    melpa    Babel functions for ffuf
;;ob-fricas                      20220612.854   available    melpa    A FriCAS backend for Org-Babel
;;ob-fsharp                      20221113.1904  available    melpa    Org-Babel F#
;;ob-git-permalink               20220627.46    available    melpa    Import GitHub code given a permalink
;;ob-go                          20190201.2040  available    melpa    org-babel functions for go evaluation
;;ob-graphql                     20201222.1515  available    melpa    Org-Babel execution backend for GraphQL source blocks
;;ob-haxe                        1.0            available    gnu      org-babel functions for haxe evaluation


;;ob-hy                          20180702.540   available    melpa    org-babel functions for Hy-lang evaluation
;;ob-ipython                     20180224.953   available    melpa    org-babel functions for IPython evaluation
;;ob-julia-vterm                 20221102.756   available    melpa    Babel functions for Julia that work with julia-vterm
;;ob-lesim                       20230619.357   available    melpa    Org-babel functions for lesim-mode
;;ob-lfe                         20170725.1420  available    melpa    org-babel functions for lfe evaluation
;;ob-lurk                        20221122.2058  available    melpa    Evaluate lurk code blocks in org mode
;;ob-mermaid                     20200320.1504  available    melpa    org-babel support for mermaid evaluation
;;ob-ml-marklogic                20190312.1314  available    melpa    org-babel functions for MarkLogic evaluation

;;ob-napkin                      20200817.1259  available    melpa    Babel functions for Napkin
;;ob-nim                         20210601.1807  available    melpa    Babel Functions for nim
;;ob-nix                         20221224.334   available    melpa    Simple org-babel support for nix
;;ob-p5js                        20230103.1356  available    melpa    Support for p5js in org-babel
;;ob-prolog                      20190410.2130  available    melpa    org-babel functions for prolog evaluation.
;;ob-raku                        20221013.1938  available    melpa    Provides raku support for org-babel
;;ob-reticulate                  20210214.2229  available    melpa    Babel Functions for reticulate
;;ob-rust                        20220824.1923  available    melpa    Org-babel functions for Rust
;;ob-sagemath                    20191106.828   available    melpa    org-babel functions for SageMath evaluation
;;ob-smiles                      20220221.1255  available    melpa    Org-mode Babel support for SMILES.
;;ob-sml                         20130829.1843  available    melpa    org-babel functions for template evaluation
;;ob-solidity                    20220213.1910  available    melpa    Org-babel functions for solidity evaluation
;;ob-spice                       20221030.217   available    melpa    org-babel functions for spice evaluation
;; ob-svgbob                      20190911.300   available    melpa    Babel Functions for svgbob
;;ob-swift                       20170921.1325  available    melpa    org-babel functions for swift evaluation
;;ob-swiftui                     20230421.1542  available    melpa    Org babel functions for SwiftUI evaluation
;;ob-translate                   20170720.1919  available    melpa    Translation of text blocks in org-mode.
;;ob-uart                        20170521.858   available    melpa    org-babel support for UART communication


  

;;render HTML in org-mode blocks.
(use-package ob-browser
  :ensure t)

;;HTML code blocks converted to PNG using Chrome
;;https://github.com/nikclayton/ob-html-chrome
(use-package ob-html-chrome
  :ensure t) 

;;http request in org-mode babel
;;https://github.com/misohena/ob-html
(use-package ob-http
  :ensure t) 

;;org-babel functions for kotlin evaluation
(use-package ob-kotlin
  :ensure t) 

;;Org-babel functions for latex-as-png evaluation
(use-package ob-latex-as-png
  :ensure t) 



;;Execute mongodb queries within org-mode blocks.
(use-package ob-mongo
  :ensure t)
(use-package ob-php
  :ensure t)
(use-package ob-powershell
  :ensure t)
(use-package ob-restclient
  :ensure t)
(use-package ob-sql-mode
  :ensure t)
(use-package ob-typescript
  :ensure t)
(use-package ob-tmux
  :ensure t)
(use-package ob-redis
  :ensure t)


;FIX ERRORS in this excerpt below
;(with-eval-after-load "org"
;  (message " ### (with-eval-after-load \"org\"...")
;  (require 'ob-html)
;  (require 'ob-html-chrome)
;  (org-babel-html-enable-open-src-block-result-temporary)) ;;Enable C-c C-o on html code block



(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (restclient . t)
   (java . t)
   (kotlin . t)
   (latex . t)
   (shell . t)
   (sqlite . t)
   (php . t)
   (powershell . t)
   (http . t)
   (sql . t)
   (typescript . t)
   (tmux . t)
   (redis . t)
   (dot . t)
   (C . t)))


;;to not confirm C-c C-c for some languges
(setq org-confirm-babel-evaluate
      (lambda (lang body)
        (not (string= lang "html-chrome"))))



(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")
        ("s" . "src")
        ("E" . "src emacs-lisp :results output :exports both :wrap EXAMPLE")
        ("S" . "src sh :results output :exports both :wrap EXAMPLE")
        ("groovy" . "groovy :exports code")))

(provide 'orgmode-babel-codeblocks)
