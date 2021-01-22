;;; package --- Summary

;;; Commentary:

;;; Code:
(fzl/log "[org_mode_config.el] Loaded sucessfully!!!")

(require 'org);; -- ensure org variables exists to be customized
(require 'ox-org)
(require 'fzl_utils_files)

;; O R G   M O D E    C O N F I G
(require 'iimage_mode_config);; -- Display images in org mode


;;http://orgmode.org/worg/org-configs/org-customization-guide.html
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)



;;;;;;;;;;;;;;;;;;Default directories for notes and website;;;;;;;;;;;;;;;;;
;;http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
;;https://orgmode.org/worg/org-configs/org-customization-guide.html
;;http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
(setq org-directory **org-directory**)

(setq org-default-notes-file (concat org-directory "/default-org-notes.org"))
(fzl-create-empty-file-if-no-exists org-default-notes-file)
(fzl-create-empty-file-if-no-exists (concat org-directory "/todos.org"))
(fzl-create-empty-file-if-no-exists (concat org-directory "/events.org"))
(fzl-create-empty-file-if-no-exists (concat org-directory "/default-org-notes.org"))


;(setq org-agenda-files '((concat org-directory "/todos.org")
;                         (concat org-directory "/events.org")
;                         (concat org-directory "/default-org-notes.org")))


(fzl/log (concat "[org_mode_config.el] => org-directory = " org-directory))

;;http://orgmode.org/worg/org-configs/org-customization-guide.html
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)



;;;;;;;;;;;;;;;;;;O R G   L I N K S;;;;;;;;;;;;;;;;;
;;
;;
;;
;;https://endlessparentheses.com/embedding-youtube-videos-with-org-mode-links.html
(defvar yt-iframe-format
  ;; You may want to change your width and height.
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(org-add-link-type
 "yt"
 (lambda (handle)
   (browse-url
    (concat "https://www.youtube.com/embed/"
            handle)))
 (lambda (path desc backend)
   (cl-case backend
     (html (format yt-iframe-format
                   path (or desc "")))
     (latex (format "\href{%s}{%s}"
                    path (or desc "video"))))))


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

;; USE ESC t to toggle toggle image view
(global-set-key (kbd "\et") 'org-toggle-iimage-in-org)


;;;;;;;;;;;;;;;;;;PUBLISHING;;;;;;;;;;;;;;;;;
;;http://orgmode.org/orgguide.pdf
;;https://orgmode.org/worg/org-tutorials/org-jekyll.html
;;

;;UNDERSCORE
;;https://emacs.stackexchange.com/questions/10549/org-mode-how-to-export-underscore-as-underscore-instead-of-highlight-in-html
;;https://stackoverflow.com/questions/8395036/make-org-ignore-underscores-when-exporting-to-html
(setq org-export-with-sub-superscripts nil)



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
;;(require 'ob-shell)
(require 'ob-java)
;(require 'restclient)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
;;   (shell . t) ;;http://thread.gmane.org/gmane.emacs.orgmode/102877
   (python . t)
   (java . t)
   (ditaa . t)
   (R . t)
   (sqlite . t)
   (C . t)
   ))
;;   (restclient . t)
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
;;;;;;;;;;;;;;;;ORG-AGENDA;;;;;;;;;;;;;;;;
(setq diary-file (concat **EMACSINITFILE_HOME** "/user_home/diary"))


;;Do not evaluate babel block codes during exportation process
;;each block codes needs be executed with C-c C-c before exportation
(setq org-export-babel-evaluate nil)


(provide 'org_mode_config)

