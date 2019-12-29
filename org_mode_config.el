;;; package --- Summary
;;; Code:
;;; Commentary:

(provide 'org_mode_config)
(require 'ox-org)
(require 'ox-publish)

;;;ORG-AGENDA
(setq diary-file (concat **EMACSINITFILE_HOME** "/user_home/diary"))



;;Do not evaluate babel block codes during exportation process
;;each block codes needs be executed with C-c C-c before exportation
(setq org-export-babel-evaluate nil)


;;http://orgmode.org/worg/org-configs/org-customization-guide.html
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)


;;;;;;;;;;;;;;;;;;PUBLISHING;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;https://orgmode.org/worg/org-tutorials/org-jekyll.html
;;


;;https://github.com/theodorewiles/org-mind-map/issues/22
(org-export-define-derived-backend 'jekyllHtmlPost 'html
   :menu-entry
   '(?j "Jekyll HTML post"
        ((?j "As Body HTML file" org-jekyllHtml-export-to-html)
	 (?o "As Body HTML file and open"
	     (lambda (a s v b)
	       (if a (org-jekyllHtml-export-to-html t s v b)
                 (org-open-file (org-jekyllHtml-export-to-html nil s v b)))))))
   :options-alist
   '((:body-only t t t) ;;wants only body
     (:creator "CREATOR" nil org-html-creator-string)))

(defun org-jekyllHtml-export-to-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((body-only "t")
         (extension ".md")
	 (file (org-export-output-file-name extension subtreep))
         (file-renamed-as-a-jekyll-post (concat (concat (format-time-string "%Y-%m-%d") "-") file))
         (jekyll-posts-dir "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts/")
	 (org-export-coding-system org-html-coding-system))
    
    (org-export-to-file 'html file async subtreep visible-only body-only ext-plist)
    (copy-file file
               (concat jekyll-posts-dir file-renamed-as-a-jekyll-post ))
    );let
  );;defun



;;https://pank.eu/blog/blog-setup.html
(defun configure_jekyll_front_matter (output backend info)
  "Configure Jekyll front matter after jekyllHtmlPost publish backend.  OUTPUT BACKEND INFO."

  (if (org-export-derived-backend-p backend 'jekyllHtmlPost)
      (message (concat "jekyllHtmlPost backend was issued..." 'jekyllHtmlPost))
      (let ((frontMatter (format "---\ntitle: %s\nauthor: %s\nlayout: %s\ndate: %s\n---\n"
                                (org-export-data (or (plist-get info :title) "?Title?") info)
                                (org-export-data (or (plist-get info :author) "?author?") info)
                                (org-export-data (or (plist-get info :jekyl_layout) "home") info) ;;fixme: provide :jekyll_layout org file
                                (org-export-data (or (plist-get info :date) (format-time-string "%Y-%m-%d")) info)
                                )))
        (concat frontMatter output))
  );if
)
(add-to-list 'org-export-filter-final-output-functions
             'configure_jekyll_front_matter)


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

;;(add-to-list 'org-export-filter-final-output-functions
;;             'configure_jekyll_front_matter)



;;https://emacs.stackexchange.com/questions/10771/how-to-use-my-custom-layout-for-generating-html-files-from-org-files-instead-of
;;(defun jekyll-post-html-backend-template (contents info)
;;  "Template html to export.  CONTENTS conteudo.  INFO info."
;;
;;  (message ">>>>>>>>>> (defun jekyll-post-html-template (contents info)...")
;;
;;   (concat
;;      "<!DOCTYPE html>BBBBB\n"
;;      (format "<html lang=\"%s\">\n" (plist-get info :language))
;;      "<head>\n"
;;      (format "<meta charset=\"%s\">\n"
;;       (coding-system-get org-html-coding-system 'mime-charset))
;;      (format "<title>%s</title>\n"
;;       (org-export-data (or (plist-get info :title) "") info))
;;      (format "<meta name=\"author\" content=\"%s\">\n"
;;       (org-export-data (plist-get info :author) info))
;;     "<link href=\"/css/style.css\" rel=\"stylesheet\" style=\"text/css\" />\n"
;;     "</head>\n"
;;     "<body>\n"
;;     (format "<h1 class=\"title\">%s</h1>\n"
;;       (org-export-data (or (plist-get info :title) "") info))
;;     contents
;;     "</body>\n"
;;     "</html>\n"))



;;https://stackoverflow.com/questions/31834002/how-to-export-org-file-to-html-file-when-save
;;(defun fzl-toggle-html-export-on-save ()
;;  "Enable or disable export HTML when saving current buffer."
;;  (interactive)
;;  (when (not (eq major-mode 'org-mode))
;;    (error "Not an org-mode file!"))
;;  (if (memq 'org-html-export-to-html after-save-hook)
;;      (progn (remove-hook 'after-save-hook 'org-html-export-to-html t)
;;             (message "Disabled org html export on save"))
;;    (add-hook 'after-save-hook 'org-html-export-to-html nil t)
;;    (set-buffer-modified-p t)
;;    (message "Enabled org html export on save")))

;;https://emacs.stackexchange.com/questions/30575/adding-latex-newpage-before-a-heading
;;(defun fzl-org-parse-headings-insert-jekyll-frontmatter (backend)
;;  "Hook to insert front matter in html exported file.  BACKEND is backend 'org-mode' export."
;;  (message ">>>>>>>>>>Hook (defun fzl-org-parse-headings-insert-jekyll-frontmatter (backend)")
;;      (org-map-entries
;;       (lambda ()
;;         (progn
;;           (insert-string "--- \n frontmatter")
;;           ))
;;       "+newpage")
;;)


;;(defun fzl-setup-jekyll-post-org-exports()
;;  "TXT he o txt que esta sendo exportado."
;;  
;;  (org-export-define-derived-backend 'jekyllHtmlPostBackend 'html
;;    :translate-alist '((template . jekyll-post-html-backend-templateRRR))
;;    :options-alist   '((:with-toc nil nil nil))) ;; Never include HTML's toc)
  
  ;;(add-hook 'org-export-before-parsing-hook 'fzl-org-parse-headings-insert-jekyll-frontmatter)
  ;;https://orgmode.org/guide/Publishing.html
  ;;https://orgmode.org/manual/Project-alist.html
  ;;https://orgmode.org/manual/Advanced-Export-Configuration.html
  ;;http://cute-jumper.github.io/emacs/2013/10/06/orgmode-to-github-pages-with-jekyll
  ;;https://orgmode.org/worg/org-tutorials/org-jekyll.html
  ;;https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
;;  (setq org-publish-project-alist
;;        '(
;;          ("jekyll-html-export" ;; settings for export as jekyll post
;;           :base-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings/jekyllposts"
;;           :base-extension "org"
;;           :publishing-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts"
;;          :recursive t
;;           :publishing-function org-html-publish-to-html
           ;;;:publishing-function jekyll-post-html-backend-template
;;           :section-numbers nil
;;           :with-toc nil
;;           :auto-index nil
;;           :auto-preamble nil
;;           :auto-postamble nil
;;           :headline-levels 4
;;           :auto-sitemap nil
;;           :html-extension "html"
;;           :body-only t)
          
;;          ("jekyll-html-export-static"
;;           :base-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings/jekyllposts"
;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;;           :publishing-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts"
;;           :recursive t
;;           :publishing-function org-publish-attachment
;;           )
          
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



;;;;;;;;;;;;;;;;;;BABEL;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;do not confirm when C-c C-c for code evaluation
(setq org-confirm-babel-evaluate nil)

;;BABEL LANGUAGES
;;http://orgmode.org/worg/org-contrib/babel/languages.html

;; active Babel languages
;; active Baral languages deps
;;(require 'ess_config);;needed for R language code blocks
;;(slime)  ;;slime is needed for lisp language code blocks
;;TODO:How to enable slime automatically for lisp blocks?
;;for now lets use emacs-lisp :)
(setq org-babel-python-command "python3") ;;needed for python3 interpreter

(require 'ob-python)
(require 'ob-lisp)
(require 'ob-shell)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t) ;;http://thread.gmane.org/gmane.emacs.orgmode/102877
   (python . t)
   (java . t)
   (ditaa . t)
   (R . t)
   (restclient . t)
   (sqlite . t)
   ))
;;   (ruby . t)

;;   (dot . t)
;;   (octave . t)

;;   (perl . t)

;;   (C . t)
;;   (awk . t)
;;   (js . t)
;;   (plantuml . t)
;;   (sql . t)
;;   (groovy . t)
;;   (browser . t)
;;   (http . t)
;;   (R . t)  ;; to wokrs, just delete ob-R.elc from your emacs.d ->  https://github.com/syl20bnr/spacemacs/issues/4618 in my case: rm ./elpa/org-20171009/ob-R.elc

;;(org-babel-do-load-languages
; 'org-babel-load-languages
; '(
;   
;  





;; USE ESC t to toggle toggle image view
(global-set-key (kbd "\et") 'org-toggle-iimage-in-org)


;;;;;;;;;;;;;;;;;;Default directories for notes and website;;;;;;;;;;;;;;;;;
;;http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
(setq org-directory (expand-file-name **ORG-DIRECTORY**))
(setq org-default-notes-file (concat org-directory "/default-org-notes.org"))

(setq org-agenda-files '((concat org-directory "todos.org")
                         (concat org-directory "events.org")
                         (concat org-directory "default-org-notes.org")))

;;;;;;;;;;;;;;;;;;IIMAGE;;;;;;;;;;;;;;;;;
;; add the org file link format to the iimage mode regex
;;(add-to-list 'iimage-mode-image-regex-alist
;;(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))
;;https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode
(setq org-image-actual-width nil) ;;Resize image with #+ATTR_ORG: :width 50

;; add a hook so we can display images on load
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))

;; function to setup images for display on load
(defun org-turn-on-iimage-in-org ()
  "Display images in your org file."
  (interactive)
  (turn-on-iimage-mode)
  (set-face-underline-p 'org-link nil))

;; function to toggle images in a org bugger
(defun org-toggle-iimage-in-org ()
  "Display images in your org file."
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  
  (call-interactively 'iimage-mode))

;; Easy Templates
;; https://emacs.stackexchange.com/questions/34651/how-can-i-create-custom-org-mode-templates
;; https://orgmode.org/manual/Easy-templates.html
(add-to-list 'org-structure-template-alist
             '("textSession" "* write tile here
                      #+BIND: org-export-use-babel nil
                      :PROPERTY:
                      :someAnotherProperty:"))

(add-to-list 'org-structure-template-alist
             '("sR" "
   #+NAME:                     
   #+BEGIN_SRC R :session s1 :results output :exports both  
      #starts code

   #+END_SRC"))	

(add-to-list 'org-structure-template-alist
             '("insertImg" "

   #+CAPTION: A cool caption for the image
   #+ATTR_HTML: :alt alternative/string image :title Action! :align center
   [[./imgs/a.jpg]]

"))	



;;; package --- Summary
;;; Code:
;;; Commentary:

(provide 'org_mode_config)
(require 'ox-org)
(require 'ox-publish)

;;;ORG-AGENDA
(setq diary-file (concat **EMACSINITFILE_HOME** "/user_home/diary"))



;;Do not evaluate babel block codes during exportation process
;;each block codes needs be executed with C-c C-c before exportation
(setq org-export-babel-evaluate nil)


;;http://orgmode.org/worg/org-configs/org-customization-guide.html
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)


;;;;;;;;;;;;;;;;;;PUBLISHING;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;https://orgmode.org/worg/org-tutorials/org-jekyll.html
;;


;;https://github.com/theodorewiles/org-mind-map/issues/22
(org-export-define-derived-backend 'jekyllHtmlPost 'html
   :menu-entry
   '(?j "Jekyll HTML post"
        ((?j "As Body HTML file" org-jekyllHtml-export-to-html)
	 (?o "As Body HTML file and open"
	     (lambda (a s v b)
	       (if a (org-jekyllHtml-export-to-html t s v b)
                 (org-open-file (org-jekyllHtml-export-to-html nil s v b)))))))
   :options-alist
   '((:body-only t t t) ;;wants only body
     (:creator "CREATOR" nil org-html-creator-string)))

(defun org-jekyllHtml-export-to-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((body-only "t")
         (extension ".md")
	 (file (org-export-output-file-name extension subtreep))
         (file-renamed-as-a-jekyll-post (concat (concat (format-time-string "%Y-%m-%d") "-") file))
         (jekyll-posts-dir "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts/")
	 (org-export-coding-system org-html-coding-system))
    
    (org-export-to-file 'html file async subtreep visible-only body-only ext-plist)
    (copy-file file
               (concat jekyll-posts-dir file-renamed-as-a-jekyll-post ))
    );let
  );;defun



;;https://pank.eu/blog/blog-setup.html
(defun configure_jekyll_front_matter (output backend info)
  "Configure Jekyll front matter after jekyllHtmlPost publish backend.  OUTPUT BACKEND INFO."

  (if (org-export-derived-backend-p backend 'jekyllHtmlPost)
      (message (concat "jekyllHtmlPost backend was issued..." 'jekyllHtmlPost))
      (let ((frontMatter (format "---\ntitle: %s\nauthor: %s\nlayout: %s\ndate: %s\n---\n"
                                (org-export-data (or (plist-get info :title) "?Title?") info)
                                (org-export-data (or (plist-get info :author) "?author?") info)
                                (org-export-data (or (plist-get info :jekyl_layout) "home") info) ;;fixme: provide :jekyll_layout org file
                                (org-export-data (or (plist-get info :date) (format-time-string "%Y-%m-%d")) info)
                                )))
        (concat frontMatter output))
  );if
)
(add-to-list 'org-export-filter-final-output-functions
             'configure_jekyll_front_matter)


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

;;(add-to-list 'org-export-filter-final-output-functions
;;             'configure_jekyll_front_matter)



;;https://emacs.stackexchange.com/questions/10771/how-to-use-my-custom-layout-for-generating-html-files-from-org-files-instead-of
;;(defun jekyll-post-html-backend-template (contents info)
;;  "Template html to export.  CONTENTS conteudo.  INFO info."
;;
;;  (message ">>>>>>>>>> (defun jekyll-post-html-template (contents info)...")
;;
;;   (concat
;;      "<!DOCTYPE html>BBBBB\n"
;;      (format "<html lang=\"%s\">\n" (plist-get info :language))
;;      "<head>\n"
;;      (format "<meta charset=\"%s\">\n"
;;       (coding-system-get org-html-coding-system 'mime-charset))
;;      (format "<title>%s</title>\n"
;;       (org-export-data (or (plist-get info :title) "") info))
;;      (format "<meta name=\"author\" content=\"%s\">\n"
;;       (org-export-data (plist-get info :author) info))
;;     "<link href=\"/css/style.css\" rel=\"stylesheet\" style=\"text/css\" />\n"
;;     "</head>\n"
;;     "<body>\n"
;;     (format "<h1 class=\"title\">%s</h1>\n"
;;       (org-export-data (or (plist-get info :title) "") info))
;;     contents
;;     "</body>\n"
;;     "</html>\n"))



;;https://stackoverflow.com/questions/31834002/how-to-export-org-file-to-html-file-when-save
;;(defun fzl-toggle-html-export-on-save ()
;;  "Enable or disable export HTML when saving current buffer."
;;  (interactive)
;;  (when (not (eq major-mode 'org-mode))
;;    (error "Not an org-mode file!"))
;;  (if (memq 'org-html-export-to-html after-save-hook)
;;      (progn (remove-hook 'after-save-hook 'org-html-export-to-html t)
;;             (message "Disabled org html export on save"))
;;    (add-hook 'after-save-hook 'org-html-export-to-html nil t)
;;    (set-buffer-modified-p t)
;;    (message "Enabled org html export on save")))

;;https://emacs.stackexchange.com/questions/30575/adding-latex-newpage-before-a-heading
;;(defun fzl-org-parse-headings-insert-jekyll-frontmatter (backend)
;;  "Hook to insert front matter in html exported file.  BACKEND is backend 'org-mode' export."
;;  (message ">>>>>>>>>>Hook (defun fzl-org-parse-headings-insert-jekyll-frontmatter (backend)")
;;      (org-map-entries
;;       (lambda ()
;;         (progn
;;           (insert-string "--- \n frontmatter")
;;           ))
;;       "+newpage")
;;)


;;(defun fzl-setup-jekyll-post-org-exports()
;;  "TXT he o txt que esta sendo exportado."
;;  
;;  (org-export-define-derived-backend 'jekyllHtmlPostBackend 'html
;;    :translate-alist '((template . jekyll-post-html-backend-templateRRR))
;;    :options-alist   '((:with-toc nil nil nil))) ;; Never include HTML's toc)
  
  ;;(add-hook 'org-export-before-parsing-hook 'fzl-org-parse-headings-insert-jekyll-frontmatter)
  ;;https://orgmode.org/guide/Publishing.html
  ;;https://orgmode.org/manual/Project-alist.html
  ;;https://orgmode.org/manual/Advanced-Export-Configuration.html
  ;;http://cute-jumper.github.io/emacs/2013/10/06/orgmode-to-github-pages-with-jekyll
  ;;https://orgmode.org/worg/org-tutorials/org-jekyll.html
  ;;https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
;;  (setq org-publish-project-alist
;;        '(
;;          ("jekyll-html-export" ;; settings for export as jekyll post
;;           :base-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings/jekyllposts"
;;           :base-extension "org"
;;           :publishing-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts"
;;          :recursive t
;;           :publishing-function org-html-publish-to-html
           ;;;:publishing-function jekyll-post-html-backend-template
;;           :section-numbers nil
;;           :with-toc nil
;;           :auto-index nil
;;           :auto-preamble nil
;;           :auto-postamble nil
;;           :headline-levels 4
;;           :auto-sitemap nil
;;           :html-extension "html"
;;           :body-only t)
          
;;          ("jekyll-html-export-static"
;;           :base-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings/jekyllposts"
;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;;           :publishing-directory "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts"
;;           :recursive t
;;           :publishing-function org-publish-attachment
;;           )
          
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



;;;;;;;;;;;;;;;;;;BABEL;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;do not confirm when C-c C-c for code evaluation
(setq org-confirm-babel-evaluate nil)

;;BABEL LANGUAGES
;;http://orgmode.org/worg/org-contrib/babel/languages.html

;; active Babel languages
;; active Baral languages deps
;;(require 'ess_config);;needed for R language code blocks
;;(slime)  ;;slime is needed for lisp language code blocks
;;TODO:How to enable slime automatically for lisp blocks?
;;for now lets use emacs-lisp :)
(setq org-babel-python-command "python3") ;;needed for python3 interpreter

(require 'ob-python)
(require 'ob-lisp)
(require 'ob-shell)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t) ;;http://thread.gmane.org/gmane.emacs.orgmode/102877
   (python . t)
   (java . t)
   (ditaa . t)
   (R . t)
   (restclient . t)
   (sqlite . t)
   ))
;;   (ruby . t)

;;   (dot . t)
;;   (octave . t)

;;   (perl . t)

;;   (C . t)
;;   (awk . t)
;;   (js . t)
;;   (plantuml . t)
;;   (sql . t)
;;   (groovy . t)
;;   (browser . t)
;;   (http . t)
;;   (R . t)  ;; to wokrs, just delete ob-R.elc from your emacs.d ->  https://github.com/syl20bnr/spacemacs/issues/4618 in my case: rm ./elpa/org-20171009/ob-R.elc

;;(org-babel-do-load-languages
; 'org-babel-load-languages
; '(
;   
;  





;; USE ESC t to toggle toggle image view
(global-set-key (kbd "\et") 'org-toggle-iimage-in-org)


;;;;;;;;;;;;;;;;;;Default directories for notes and website;;;;;;;;;;;;;;;;;
;;http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
(setq org-directory (expand-file-name **ORG-DIRECTORY**))
(setq org-default-notes-file (concat org-directory "/default-org-notes.org"))

(setq org-agenda-files '((concat org-directory "todos.org")
                         (concat org-directory "events.org")
                         (concat org-directory "default-org-notes.org")))

;;;;;;;;;;;;;;;;;;IIMAGE;;;;;;;;;;;;;;;;;
;; add the org file link format to the iimage mode regex
;;(add-to-list 'iimage-mode-image-regex-alist
;;(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))
;;https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode
(setq org-image-actual-width nil) ;;Resize image with #+ATTR_ORG: :width 50

;; add a hook so we can display images on load
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))

;; function to setup images for display on load
(defun org-turn-on-iimage-in-org ()
  "Display images in your org file."
  (interactive)
  (turn-on-iimage-mode)
  (set-face-underline-p 'org-link nil))

;; function to toggle images in a org bugger
(defun org-toggle-iimage-in-org ()
  "Display images in your org file."
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  
  (call-interactively 'iimage-mode))

;; Easy Templates
;; https://emacs.stackexchange.com/questions/34651/how-can-i-create-custom-org-mode-templates
;; https://orgmode.org/manual/Easy-templates.html
(add-to-list 'org-structure-template-alist
             '("textSession" "* write tile here
                      #+BIND: org-export-use-babel nil
                      :PROPERTY:
                      :someAnotherProperty:"))

(add-to-list 'org-structure-template-alist
             '("sR" "
   #+NAME:                     
   #+BEGIN_SRC R :session s1 :results output :exports both  
      #starts code

   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sHTML" "
   #+NAME:                     
   #+BEGIN_SRC html :session s1 :results output :exports both  
      #starts code

   #+END_SRC

   #+NAME:
   #+BEGIN_EXPORT html
   
   #+END_EXPORT"
               ))	


(add-to-list 'org-structure-template-alist
             '("sRestclient" "
   #+NAME:    
   #+BEGIN_SRC restclient :session s1 :results output :exports both  
      #starts code
     POST --header 'Content-Type: application/json' 
     http://localhost:8081/service/rest/v1/script
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sShell" "
   #+NAME:                     
   #+BEGIN_SRC shell :session s1 :results output :exports both
      #starts code
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sElisp" "
   #+NAME:                     
   #+BEGIN_SRC elisp :session s1 :results output :exports both
      #starts code
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("img" "
   #+NAME:figX                     
   #+CAPTION: figX
   #+attr_ORG: :width 500px
   #+attr_html: :width 500px
   #+attr_latex: :width 500px
   [[./imgs/XXX]]"))	



;;;;;;;;;;;;;;;;;;PHANTONJS;;;;;;;;;;;;;;;;;
;;babel browser phantom dependency
;;https://github.com/krisajenkins/ob-browser
;;(add-to-list 'exec-path "/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/envs/env-dev/sources/emacsinitfile/node_modules/")
;(setenv "PATH" (mapconcat 'identity exec-path ":"))


;;;SYNTAX HIGHLIGHTING IN ORG-BABEL
;;http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
;(setq org-confirm-babel-evaluate nil)
;(setq org-src-fontify-natively t)
;(setq org-src-tab-acts-natively t)
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((lisp . t)))
;; '(emacs-lisp . t)
;; '(R . t)
;; '(java .t)
; '(sh . t)
;; '(js . t)
;; '(css . t)
;; '(C++ . t)
;; '(clousure . t)
;; '(sqlite . t)
;; '(sed . t)))
;;(setq org-src-fontify-natively t)
;; (setq org-html-htmlize-output-type 'inline-css) ;; default
;;(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
;;(setq org-html-htmlize-font-prefix "org-")


;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
 ;;    ;(require 'ess-site)
;;     ;(require 'ob-R)

;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
;;     (require 'ess-site)
;;     ;(require 'ob11-R)

;;     ;(require 'ob-emacs-lisp)
;;     ;(require 'ob-latex)
;;     ;(require 'octave)
;;     ;(require 'ob-python)
;;     ;(require 'ob-sql)
;;     ;(require 'ob-shell)
     ;(require 'ob-sqlite)
     ;;(require 'ob-julia);"arquivo ou diretório não encontrado" "ob-julia")
     ;(require 'ob-perl)
     ;(require 'ob-org)
     ;(require 'ob-awk)
        ;(require 'ob-sed);(file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-sed")
     ;(require 'ob-css)
     ;(require 'ob-js)
        ;(require 'ob-stata); (file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-stata")
;;     (setq org-export-babel-evaluate nil)
;;     (setq org-startup-indented t)
;;     ;; increase imenu depth to include third level headings
;;     (setq org-imenu-depth 3)
;;     ;; Set sensible mode for editing dot files
;;     (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
     ;; Update images from babel code blocks automatically
;;     (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;;     (setq org-src-fontify-natively t)
;;     (setq org-src-tab-acts-natively t)

;;     (setq org-confirm-babel-evaluate nil)))


;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;(require 'org-latex)
;(unless (boundp 'org-export-latex-classes)
;  (setq org-export-latex-classes nil))
;(add-to-list 'org-export-latex-classes
;             '("article"
;               "\\documentclass{book}"
;               ("\\section{%s}" . "\\section*{%s}")))  




;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;;(require 'org-latex)
;;(unless (boundp 'org-export-latex-classes)
;;  (setq org-export-latex-classes nil))
;;(add-to-list 'org-export-latex-classes
;;             '("article"
;;               "\\documentclass{book}"
;;               ("\\section{%s}" . "\\section*{%s}")))  


;;http://orgmode.org/worg/dev/org-export-reference.html
;;http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-LaTeX.html
;;(setq exec-path (append exec-path '("/usr/tex")))
;;TODO (load "auctex.el" nil t t)
;;TODO (add-hook 'LaTeX-mode-hook 'turn-on-reftex)



;;;LaTeX Export for Org Mode < 8.0
;;;http://orgmode.org/worg/org-tutorials/org-latex-export.html
;(require 'ox-latex)
;(unless (boundp 'org-latex-classes)
;  (setq org-latex-classes nil))
;(add-to-list 'org-latex-classes
;             '("article"
;               "\\documentclass{article}"
;               ("\\section{%s}" . "\\section*{%s}")))

;(add-to-list 'org-latex-classes
;          '("abntex2"
;            "\\documentclass{abntex2}"
;
;
;            "\\usepackage{lmodern}"
;            "\\usepackage[T1]{fontenc}"
;            "\\usepackage[utf8]{inputenc}"
;            "\\usepackage{indentfirst}"
;            "\\usepackage{nomencl}"
;            "\\usepackage{color}"
;            "\\usepackage{graphicx}"
;            "\\usepackage{microtype}"
;            
;            ("\\section{%s}" . "\\section*{%s}")
;            ("\\subsection{%s}" . "\\subsection*{%s}")
;            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;            ("\\paragraph{%s}" . "\\paragraph*{%s}")
;            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")));
;
;

;;CONFIG ORG-MODE/CONTRIB BY GIT REPO
;;http://orgmode.org/manual/Installation.html

(add-to-list 'org-structure-template-alist
             '("sHTML" "
   #+NAME:                     
   #+BEGIN_SRC html :session s1 :results output :exports both  
      #starts code

   #+END_SRC

   #+NAME:
   #+BEGIN_EXPORT html
   
   #+END_EXPORT"
               ))	


(add-to-list 'org-structure-template-alist
             '("sRestclient" "
   #+NAME:    
   #+BEGIN_SRC restclient :session s1 :results output :exports both  
      #starts code
     POST --header 'Content-Type: application/json' 
     http://localhost:8081/service/rest/v1/script
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sShell" "
   #+NAME:                     
   #+BEGIN_SRC shell :session s1 :results output :exports both
      #starts code
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("sElisp" "
   #+NAME:                     
   #+BEGIN_SRC elisp :session s1 :results output :exports both
      #starts code
   #+END_SRC"))	


(add-to-list 'org-structure-template-alist
             '("img" "
   #+NAME:figX                     
   #+CAPTION: figX
   #+attr_ORG: :width 500px
   #+attr_html: :width 500px
   #+attr_latex: :width 500px
   [[./imgs/XXX]]"))	



;;;;;;;;;;;;;;;;;;PHANTONJS;;;;;;;;;;;;;;;;;
;;babel browser phantom dependency
;;https://github.com/krisajenkins/ob-browser
;;(add-to-list 'exec-path "/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/envs/env-dev/sources/emacsinitfile/node_modules/")
;(setenv "PATH" (mapconcat 'identity exec-path ":"))


;;;SYNTAX HIGHLIGHTING IN ORG-BABEL
;;http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
;(setq org-confirm-babel-evaluate nil)
;(setq org-src-fontify-natively t)
;(setq org-src-tab-acts-natively t)
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((lisp . t)))
;; '(emacs-lisp . t)
;; '(R . t)
;; '(java .t)
; '(sh . t)
;; '(js . t)
;; '(css . t)
;; '(C++ . t)
;; '(clousure . t)
;; '(sqlite . t)
;; '(sed . t)))
;;(setq org-src-fontify-natively t)
;; (setq org-html-htmlize-output-type 'inline-css) ;; default
;;(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
;;(setq org-html-htmlize-font-prefix "org-")


;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
 ;;    ;(require 'ess-site)
;;     ;(require 'ob-R)

;; (eval-after-load 'org
;;   (lambda()
;;     ;(require 'ob-tangle)
;;     (require 'ess-site)
;;     ;(require 'ob11-R)

;;     ;(require 'ob-emacs-lisp)
;;     ;(require 'ob-latex)
;;     ;(require 'octave)
;;     ;(require 'ob-python)
;;     ;(require 'ob-sql)
;;     ;(require 'ob-shell)
     ;(require 'ob-sqlite)
     ;;(require 'ob-julia);"arquivo ou diretório não encontrado" "ob-julia")
     ;(require 'ob-perl)
     ;(require 'ob-org)
     ;(require 'ob-awk)
        ;(require 'ob-sed);(file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-sed")
     ;(require 'ob-css)
     ;(require 'ob-js)
        ;(require 'ob-stata); (file-error "Cannot open load file" "arquivo ou diretório não encontrado" "ob-stata")
;;     (setq org-export-babel-evaluate nil)
;;     (setq org-startup-indented t)
;;     ;; increase imenu depth to include third level headings
;;     (setq org-imenu-depth 3)
;;     ;; Set sensible mode for editing dot files
;;     (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
     ;; Update images from babel code blocks automatically
;;     (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;;     (setq org-src-fontify-natively t)
;;     (setq org-src-tab-acts-natively t)

;;     (setq org-confirm-babel-evaluate nil)))


;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;(require 'org-latex)
;(unless (boundp 'org-export-latex-classes)
;  (setq org-export-latex-classes nil))
;(add-to-list 'org-export-latex-classes
;             '("article"
;               "\\documentclass{book}"
;               ("\\section{%s}" . "\\section*{%s}")))  




;;http://orgmode.org/tmp/worg/org-tutorials/org-latex-export.html
;;(require 'org-latex)
;;(unless (boundp 'org-export-latex-classes)
;;  (setq org-export-latex-classes nil))
;;(add-to-list 'org-export-latex-classes
;;             '("article"
;;               "\\documentclass{book}"
;;               ("\\section{%s}" . "\\section*{%s}")))  


;;http://orgmode.org/worg/dev/org-export-reference.html
;;http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-LaTeX.html
;;(setq exec-path (append exec-path '("/usr/tex")))
;;TODO (load "auctex.el" nil t t)
;;TODO (add-hook 'LaTeX-mode-hook 'turn-on-reftex)



;;;LaTeX Export for Org Mode < 8.0
;;;http://orgmode.org/worg/org-tutorials/org-latex-export.html
;(require 'ox-latex)
;(unless (boundp 'org-latex-classes)
;  (setq org-latex-classes nil))
;(add-to-list 'org-latex-classes
;             '("article"
;               "\\documentclass{article}"
;               ("\\section{%s}" . "\\section*{%s}")))

;(add-to-list 'org-latex-classes
;          '("abntex2"
;            "\\documentclass{abntex2}"
;
;
;            "\\usepackage{lmodern}"
;            "\\usepackage[T1]{fontenc}"
;            "\\usepackage[utf8]{inputenc}"
;            "\\usepackage{indentfirst}"
;            "\\usepackage{nomencl}"
;            "\\usepackage{color}"
;            "\\usepackage{graphicx}"
;            "\\usepackage{microtype}"
;            
;            ("\\section{%s}" . "\\section*{%s}")
;            ("\\subsection{%s}" . "\\subsection*{%s}")
;            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;            ("\\paragraph{%s}" . "\\paragraph*{%s}")
;            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")));
;
;

;;CONFIG ORG-MODE/CONTRIB BY GIT REPO
;;http://orgmode.org/manual/Installation.html

