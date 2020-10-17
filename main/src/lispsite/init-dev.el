;;; package --- Summary
;;; this init-dev.el configure emacs for coding with c/c++ java etc...

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-
(message " ### init-dev.el loaded sucessfully!!!")

;;acentos
(set-input-mode nil nil 1)
;(standard-display-european t) 
;;;
;;; encoding ;;;;
;;;https://stackoverflow.com/questions/6021862/force-emacs-to-use-a-particular-encoding-if-and-only-if-that-causes-no-trouble
(defun enforce-coding-system-priority ()
  (let ((pref (car (coding-system-priority-list)))
        (list (find-coding-systems-region (point-min) (point-max))))
    (when (or (memq 'undecided list) (memq pref list))
      (setq buffer-file-coding-system pref))))

(add-hook 'before-save-hook 'enforce-coding-system-priority)

(prefer-coding-system 'iso-8859-1)


;;load files in this same el file dir
(setq *thisFileDir* (getenv "PWD"))
(add-to-list 'load-path *thisFileDir*)


;;we add this file dir to load-path
;;so that we can load some .el files in this dir
;;after ir we load global vars the defines another paths of interests as global vars
(add-to-list 'load-path *thisFileDir*)


;;this file defines serveral path or interest as global vars
;;as **EMACSINITFILE_LISPSITE** the are used below, for example
;; global vars in code are the prefixed and postfixed  with **, like **MY_GLOBAL_VAR_NAME**
(require 'global_variables_setup)

(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/web-mode"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/rtags/src"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/org-ref"))
(add-to-list 'load-path (concat **EMACSINITFILE_LISPSITE** "/ESS"))


;;
;;
;;
(require 'init_common)

(require 'config_proxy)
(require 'config_package_system)
(require 'config_newsticker)

;;; B A S I C  W R I T E   C O N F I G U R A T I O N S
(require 'config_abbrev)
(require 'config_helm)
(require 'org_mode_config)
;(require 'org_mode_publish_backend_jquerymobile)
(require 'org_mode_publish_config)

 

;;;
;;; highlight matching parentheses next to cursor
(require 'config_code_in_general)


;;S U P E R    U T I L S    F U N C T I O N S
(require 'fzl_functions)
(require 'fzl_menus)


;;
;;
;;
;;(require 'cedet_config)


;; autocomplete for several languages is not so simple, but
;; this features still not working as I would like to
;; but a simpler is configured in this file required autocomplete_config.el
(require 'autocomplete_config)


;; GROOVY AND GRADLE (are still not working when build.gradle opens)
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.build" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(require 'gradle_config)


;; yasnippet uses ac-sources defined by autocomplete
;; so needs to be here, after autocomplete_config.el loaded
;;
(require 'yasnippet_config)
(require 'flycheck_config)


;;(require 'rtags_config)
(find-file (concat **EMACSINITFILE_HOME** "/index.org"))
(find-file "/home/wagner/envs/env-dev/sources/somewritings/var/publishing-directory/planosdeaulas/index.html")
(find-file (concat **EMACSINITFILE_HOME** "/main/src/lispsite/config_abbrev.el"))


;;Python coding
(require 'config_elpy)

;;; this_init-dev.el ends here
