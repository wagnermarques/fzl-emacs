;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'ox)
(require 'ox-html)
(require 'ox-publish)
(require 'format-spec)
(eval-when-compile (require 'cl) (require 'table nil 'noerror))

;; -*- coding: utf-8; lexical-binding: t; -*-

(message ">>>>>>>>>> org_mode_publish_config.el loaded sucessfully")

;;https://stackoverflow.com/questions/20914458/in-org-mode-how-to-specify-different-export-options-for-latex-and-html
;;(defun my-org-export-change-options (plist backend)
;;  "PLIST plist, BACKEND is the backend."
;;  (message "<><><><> (defun my-org-export-change-options (plist backend)...")
;;  (cond
;;    ((equal backend 'html)
;;     (plist-put plist :with-toc nil)
;;     (plist-put plist :body-only t)
;;     (plist-put plist :section-numbers nil))
;;    ((equal backend 'latex)
;;     (plist-put plist :with-toc t)
;;     (plist-put plist :section-numbers t)))
;;  plist)

;;(add-to-list 'org-export-filter-options-functions 'my-org-export-change-options)

;;https://github.com/yyr/org-mode/blob/master/lisp/ox-html.el
;;(defun fzl-org-html-template (contents info)
;;  "Replace org-html-template function.
;;CONTENTS is the transcoded contents string.  INFO is a plist
;;holding export options."
;;
;;  (message "contents")
;;          
  ;; (format "</%s>\n" (nth 1 (assq 'content (plist-get info :html-divs))))
   ;; Postamble.
  ;; (org-html--build-pre/postamble 'postamble info)

  ;;"</body>\n</html>"
;;  )


;;(defun fzl-org-html-src-block (src-block contents info)
;;  "Transcode a SRC-BLOCK element from Org to HTML.
;;CONTENTS holds the contents of the item.  INFO is a plist holding
;;contextual information."
;;  (if (org-export-read-attribute :attr_html src-block :textarea)
;;      (org-html--textarea-block src-block)
;;    (let ((lang (org-element-property :language src-block))
;;	  (caption (org-export-get-caption src-block))
;;	  (code (org-html-format-code src-block info))
;;	  (label (let ((lbl (and (org-element-property :name src-block)
;;				 (org-export-get-reference src-block info))))
;;		   (if lbl (format " id=\"%s\"" lbl) ""))))
;;      (if (not lang) (format "<pre class=\"example\"%s>\n%s</pre>" label code)
;;	(format
;;	 "<div class=\"org-src-container\">\n%s%s\n</div>"
;;	 (if (not caption) ""
;;	   (format "<label class=\"org-src-name\">%s</label>"
;;		   (org-export-data caption info)))
;;(format "\n<pre class=\"src src-%s\"%s>%s</pre>" lang label code))))))


;;from: https://code.orgmode.org/bzg/org-mode/raw/master/lisp/ox-html.el
;;(org-export-define-derived-backend  'htmlJekyll 'html
;;  :menu-entry
;;  '(?j "Export to Jekyll HTML post"
;;       ((?J "As HTML buffer" org-html-export-as-html)
;;	(?j "As HTML file" org-html-export-to-html)
;;	(?o "As HTML file and open"
;;	    (lambda (a s v b)
;;	      (if a (org-html-export-to-html t s v b)
;;		(org-open-file (org-html-export-to-html nil s v b)))))))
;;  :translate-alist '((template . fzl-org-html-template)
;;                     (src-block . fzl-org-html-src-block)))


;;(defun fzl-process-org-file-before-export ()
;;  "Insert SETUPFILE statement in the beginning of the buffer for export ONLY."
;;  (interactive) ; for testing in scratch
;;  (goto-char (point-min))
;;  (insert "#+SETUPFILE: ./level-0.org\n")
;;)

(provide 'org_mode_publish_config)
;;; org_mode_publish_config.el ends here
