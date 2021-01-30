;;; package --- Summary
;;https://www.emacswiki.org/emacs/NewsTicker

;;; Commentary:
;;https://www.emacswiki.org/emacs/init-newsticker.el

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

(setq newsticker-url-list
      '(("EmacsWiki Recently Change"
         "http://www.emacswiki.org/cgi-bin/emacs?action=rss;showedit=1"
         nil nil nil)

        ("Planet Emacsen"
         "http://planet.emacsen.org/atom.xml"
         nil 86400 nil)


        ("Forum Nable (DS ETECZL)"
         "http://ds-eteczl.209235.n8.nabble.com/DS-ETECZL-ft1.xml"
         nil nil nil)


        ("jakarta.apache.org"
         "http://jakarta.apache.org/site/rss.xml"
         nil nil nil)


        ("Eclipse News"
         "http://feeds.feedburner.com/eclipse/fnews"
         nil nil nil)

        ("Eclipse Community News [eclipse_org]"
         "http://feeds.feedburner.com/eclipse/cnews"
         nil nil nil)

        ("jaxenter.com"
         "http://jaxenter.com/rss"
         nil nil nil)
                
        
        ("Haskell Planet"
         "http://planet.haskell.org/rss20.xml"
         nil 86400 nil)

        ("Bo Wen Wang"
         "http://feeds.bowenwang.com.cn"
         nil 86400 nil)

        ("Google Mi"
         "http://www.chromi.org/feed"
         nil 1800 nil)))


(provide 'config_newsticker)
;;; config_newsticker.el ends here

                     
