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


(message (concat "###:base-directory->"  **org-publish-project-base-directory-4-aws-s3-planosdeaulas**))
(shell-command (concat "ls -l " **org-publish-project-base-directory-4-aws-s3-planosdeaulas**))
(message (concat "###:publishing-directory->"  **org-publish-project-publishing-directory-4-aws-s3-planosdeaulas**))
(shell-command (concat "ls -l "  **org-publish-project-publishing-directory-4-aws-s3-planosdeaulas**))


;; just for htmlJekyll backend
;; this conf configure_jekyll_front_matter function
;; put the jekyll front matter as a html preambule
;; another option could be use html preabule format variable
(add-to-list 'org-export-filter-final-output-functions
             'configure_jekyll_front_matter)

(setq org-publish-project-alist
      '(("jekyll-html-export" ;; settings for export as jekyll post
         :base-directory **org-publish-project-publishing-directory-4-jekyll-html-export**
         :base-extension "org"
         :publishing-directory **org-publish-project-base-directory-4-jekyll-html-export**
         :recursive t
         :publishing-function org-twbs-publish-to-html
         :section-numbers nil
         :with-toc nil
         :auto-index nil
         :auto-preamble nil
         :auto-postamble nil
         :headline-levels 4
         :auto-sitemap nil
         :html-extension "html"
         :body-only t
         :html-preamble-format html-preamble-as-jekyll-front-matter)

        ;;;https://github.com/marsmining/ox-twbs
        ("aws-s3-planosdeaulas"
         :base-directory       "/home/wagner/envs/env-dev/sources/somewritings/planosdeaulas"
         :publishing-directory "/home/wagner/envs/env-dev/sources/somewritings/var/publishing-directory/planosdeaulas"
         :base-extension "org"
         :publishing-function org-twbs-publish-to-html
         :headline-levels 4
         :auto-preamble t
         :recursive t
         )

        ;;The static component just copies files (and their folders) from :base-directory to :publishing-directory without changing them. Thus let's tell Org-mode to use the function org-publish-attachment
        ("aws-s3-planosdeaulas-org-static"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         ;;:base-directory **org-publish-project-base-directory-4-aws-s3-planosdeaulas**
         :base-directory "/home/wagner/envs/env-dev/sources/somewritings/planosdeaulas"
         ;;:publishing-directory  **org-publish-project-publishing-directory-4-aws-s3-planosdeaulas**
         :publishing-directory  "/home/wagner/envs/env-dev/sources/somewritings/var/publishing-directory/planosdeaulas"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("aws-s3-planosdeaulas-site" :components ("aws-s3-planosdeaulas" "aws-s3-planosdeaulas-org-static"))
        ))

;;https://orgmode.org/manual/Adding-Export-Back_002dends.html
;;https://orgmode.org/worg/dev/org-export-reference.html
;;;;from: https://code.orgmode.org/bzg/org-mode/raw/master/lisp/ox-html.el
(org-export-define-derived-backend  'htmlJekyll 'html
  :menu-entry
  '(?j "Export to Jekyll HTML post"
       ((?J "As HTML buffer" org-htmlJekyll-export-as-html)
	(?j "As HTML file" org-htmlJekyll-export-to-html)
	(?o "As HTML file and open"
	    (lambda (a s v b)
	      (if a (org-html-export-to-html t s v b)
		(org-open-file (org-html-export-to-html nil s v b))))))))

(defun org-htmlJekyll-export-to-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((extension (concat "." (or (plist-get ext-plist :html-extension)
				    org-html-extension
				    "html")))
	 (file (org-export-output-file-name extension subtreep))
	 (org-export-coding-system org-html-coding-system))
    (org-export-to-file 'htmlJekyll file
      async subtreep visible-only body-only ext-plist)))


(defun org-htmlJekyll-export-as-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (org-export-to-buffer 'htmlJekyll "*Org htmlJekyll HTML Export*"
    async subtreep visible-only body-only ext-plist
    (lambda () (set-auto-mode t))))


;;https://github.com/yyr/org-mode/blob/master/lisp/ox-html.el
;;(defun htmlJekyll-export-template (contents info)
;;  "Replace org-html-template function for htmlJekyll backend.
;;CONTENTS is the transcoded contents string.  INFO is a plist
;;holding export options."
  
;;(message "contents")
;; (message contents)
;; (message "info")
;; (message info)
          
;;  (format "</%s>\n" (nth 1 (assq 'content (plist-get info :html-divs))))
;;  Postamble.
;;  (org-html--build-pre/postamble 'postamble info)
;;  "</body>\n</html>"
;;)

;;(defun htmlJekyll-export-src-block (src-block contents info)
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
;;(format "\n<pre class=\"src src-%s\"%s>%s</pre>" lang label code)))))
;;)


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


;;https://pank.eu/blog/blog-setup.html
(defun configure_jekyll_front_matter (output backend info)
  "Configure Jekyll front matter after jekyllHtmlPost publish backend.  OUTPUT BACKEND INFO."
  (message "##### (defun configure_jekyll_front_matter (output backend info)....")
  (if (org-export-derived-backend-p backend 'jekyllHtmlPost)
      (let ((frontMatter (format "---\ntitle: %s\nauthor: %s\nlayout: %s\ndate: %s\n---\n"
                                 (org-export-data (or (plist-get info :title) "?Title?") info)
                                 (org-export-data (or (plist-get info :author) "?author?") info)
                                 (org-export-data (or (plist-get info :jekyl_layout) "home") info) ;;fixme: provide :jekyll_layout org file
                                 (org-export-data (or (plist-get info :date) (format-time-string "%Y-%m-%d")) info)
                                 )))
        (concat frontMatter output)));if;
  )


;;https://pank.eu/blog/blog-setup.html
;;(defun configure_jekyll_front_matter (output backend info) ; (ref:pank.eu-add-html-lang-tag)
;;  "Only the dev.  version handles language properly.  OUTPUT BACKEND INFO."
  
  ;; (setq fmTitle (format "---\ntitle:%s\nauthor:%s\nlayout:%s\nexcerpt:%s\ndate:\n---\n"
  ;;                       (org-export-data (or (plist-get info :title) "?Title?") info)
  ;;                       (org-export-data (or (plist-get info :author) "?author?") info)
  ;;                       (org-export-data (or (plist-get info :jekyll_layout) "?jekyll layout here?") info)
  ;;                       (org-export-data (or (plist-get info :jekyll_excerpt) "?post excerpt here? ") info)
  ;;                       ))
  ;; (concat fmTitle output)

;;  (if (org-export-derived-backend-p backend 'html)
;;      (message "html backend")
;;    (message "jekyllHtml backend"))
;;)


;;(defun fzl-process-org-file-before-export ()
;;  "Insert SETUPFILE statement in the beginning of the buffer for export ONLY."
;;  (interactive) ; for testing in scratch
;;  (goto-char (point-min))
;;  (insert "#+SETUPFILE: ./level-0.org\n")
;;)

;;         ("jekyllPostExport"
;;           :components ("jekyll-html-export" "jekyll-html-export-static"))))

  ;;(org-publish-project "jekyllPostExport")
;;  (org-publish-project "jekyllPostExport")
    
;;  ;;(remove-hook 'org-export-before-parsing-hook 'fzl-org-parse-headings-insert-jekyll-frontmatter)
;;  (message ">>>>>>>>>> (defun fzl-setup-jekyll-post-org-exports()..."))


;;(defun fzl-toggle-html-export-as-jekyll-post-on-save()
;;  "Enable or disable export HTML when saving current buffer, but as a jekyll post."
;;  (interactive)
;;  (when (not (eq major-mode 'org-mode))
;;    (error "Not an org-mode file!"))
;;  (if (memq 'setup-jekyll-post-org-exports after-save-hook)
;;      (progn (remove-hook 'after-save-hook 'fzl-setup-jekyll-post-org-exports t)
;;             (message "Disabled org html export on save"))
;;    (add-hook 'after-save-hook 'fzl-setup-jekyll-post-org-exports nil t)
;;    (set-buffer-modified-p t)
;;    (message "Enabled org html export on save")))

;;Hook run each time a file is published.
;;org-publish-after-publishing-hook

;;Hook run before parsing an export buffer.
;;org-export-before-parsing-hook

;;Hook run at the beginning of the export process.
;;org-export-before-processing-hook

;;Hook run after entering or leaving org-indent-mode.
;;org-indent-mode-hook

;;Hook being run after inserting a new heading.
;;org-insert-heading-hook

;;Hook that is run after org.el has been loaded.
;;org-load-hook

;;Hook that is run after an Org log buffer is created.
;;org-log-buffer-setup-hook

;;hook for Org mode, run after the mode was turned on
;;org-mode-hook
  
;;Hook that is run after org-occur has constructed a sparse tree.
;;org-occur-hook

;;Hook that is run before visibility cycling is happening.
;;org-pre-cycle-hook

;;Hook run each time a file is published.
;;org-publish-after-publishing-hook

;;Hook run after Org switched a source code snippet to its Emacs mode.
;;org-src-mode-hook




;(remove-hook 'org-export-preprocess-final-hook
;          (lambda (htm) (message htm)))





(provide 'org_mode_publish_config)
;;; org_mode_publish_config.el ends here
