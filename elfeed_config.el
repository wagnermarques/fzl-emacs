;;; package --- Summary
;;; Code:
;;; Commentary:
;;https://github.com/remyhonig/elfeed-org

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-


;;http://pragmaticemacs.com/emacs/read-your-rss-feeds-in-emacs-with-elfeed/
;;https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Btools/elfeed

;(elfeed :variables elfeed-enable-web-interface t)

(setq elfeed-feeds
      '("https://www.digitalhealth.net/feed/"    ;;Digital Health
        "http://www.howardism.org/index.xml"     ;; My Blog
        "http://endlessparentheses.com/atom.xml" ;; Emacs Blog
        "http://www.masteringemacs.org/feed/"    ;; Emacs Blog
        "http://emacs-fu.blogspot.com/feeds/posts/default"
        "http://emacsredux.com/atom.xml"         ;; Emacs Blog
        "http://www.lunaryorn.com/feed.atom"     ;; Emacs Blog
        "http://emacshorrors.com/feed.atom"
        "http://swannodette.github.com/atom.xml" ;; David Nolen, duh.
        "http://batsov.com/atom.xml"             ;; Bozhidar Batsov
        "http://twogreenleaves.org/index.php?feed=rss"

        "https://medium.com/feed/@hlship/"       ;; Programming
        "http://gigasquidsoftware.com/atom.xml"  ;; Clojure
        "http://blog.fogus.me/feed/"      ;; Programming
        "http://steve-yegge.blogspot.com/atom.xml"
        "http://www.rkn.io/feed.xml"
        "http://cpphints.com/rss"
        "https://infrequently.org/feed/"
        "http://scholarship-positions.com/tag/featured/feed/rss"
        ))    ;; Programming


;(use-package elfeed-org
;  :ensure t
;  :config
;  (elfeed-org)
;  (setq rmh-elfeed-org-files (list "elfeed_topics.org")))

;(use-package elfeed
;  :commands elfeed
;  :init     (define-key personal-global-map (kbd "r") 'elfeed))




(provide 'elfeed_config)
;;; elfeed_config.el ends here

