;; DISCLAIMER
;; I have been use emacs for development with some devtools
;; So there are a lot of global vars that define whare are these tools are in the disk
;; There are not a main goal of emacs usability 

;; are there any effort to adapt this for windows

;;some references

;;https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html
;;https://www.gnu.org/software/emacs/manual/
;;https://www.emacswiki.org/emacs?interface=en


(setq url-proxy-services '(("no_proxy" . "work\\\\.com")
			   ("http" . "wagner:nicolas1*@192.168.0.2:3128")))


;;Entering the Debugger on an Error
;;https://ftp.gnu.org/old-gnu/Manuals/elisp-manual-21-2.8/html_node/elisp_225.html
(setq debug-on-error t)


;;Some startup global variables
(setq emacs-startup-init-timestamp (current-time))
(defvar times-stamp-format-pattern "%a %b %d %H:%M:%S %Z %Y")
(defvar date-format-pattern "%a %b %d %H:%M:%S %Z %Y")
(defvar time-format-pattern "%a %b %d %H:%M:%S %Z %Y")
(defvar dayOfWeekendStr-dayOfMoutnInt-moutnInStr "%A %e %B")


;;starting emacs in maximed window
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


;;At the very first things to do is habilitate load emacsinitfile customization files
;;To do this: **PWD** first global var means this script directory
;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html
;;https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Search.html
;;https://www.gnu.org/software/emacs/manual/html_node/efaq/Changing-load_002dpath.html
(setq **PWD** (file-name-directory load-file-name))
(defun configure_load_path()
  (setq load-path
	(append (list nil
		      **PWD**
		      "~/emacs")
		load-path)))
(configure_load_path)


;;Before load .el files we need prevent some code requirments
(require 'config_code_lisp) ;;none lisp coding cofigure in this file for now


;; global vars in code are the prefixed and postfixed  with **, like **MY_GLOBAL_VAR_NAME**
(require 'global_variables_setup)


;;create emacsinitfile.log file
;;and provide a fzlUtil/log function to write on it
(require 'config_logging)


;;configure emacs packages repositories installing list of packages automatically
(require 'config_package_system)


;;Some of my super utils functions, keys and menus
(require 'fzl_functions)
(require 'fzl_keys)
(require 'fzl_utils)
(require 'fzl_menus)


;;basic emacs functionalities
;;https://ftp.gnu.org/old-gnu/Manuals/emacs/html_node/emacs_181.html
(require 'iswitchb_config)
(require 'config_buffers) ;;for now just inhibit emacs startup buffer 
(require 'config_lines_columns_and_cursor_behaviour)
(require 'config_general_emacs_behaviour)

(require 'iedit_config) ;multiple cursor C
(require 'yasnippet_config)

(require 'speedbar_config) ;;put a speedbar in confined buffer and opens it




;;open some interesting buffers at emacs starting up like
;;emacsinitfile.log and others
(require 'find_files)



;;B A S I C  C O D I N G   C O N F I G U R A T I O N S
(require 'config_code_in_general)
(require 'autocomplete_config)
(require 'cedet_config)
(require 'flycheck_config)


;;ORG MODE CONFIG
(require 'iimage_mode_config);; -- Display images in org mode
(require 'org_mode_config)





;;R
(require 'ess_config)







;(require 'reftex)    

;;(require 'auctex)Debugger entered--Lisp error: (error "Required feature `auctex' was not provided")
;(require 'calendar_config)


;(require 'config_dockerfile)


;;C O D I N G   C O N F I G U R A T I O N S
;(require 'config_code_in_general)
;(require 'js_mode_config)
;(require 'config_code_c_style_for_K_and_RStyle)
;(require 'sql_mode_config)


;(require 'multiple_cursors_config)

;(require 'config_env_for_shell_and_startup_some_dev_tools)
;(require 'config-web-mode)


;(require 'config_eclipse)


;(require 'elfeed_config)





;(require 'config_code_c_style_for_K_and_RStyle)

;;xml
;(defvar *nxml_or_PSGML* "nxml")
;(require 'xml_mode) ;TODO: nxml











     ;B U F F E R S   C O N F I G U R A T I O N S
;     (require 'org_mode_config)
;     (require 'config_buffers)
;     (require 'config_minibuffer) 


     ;(fzlfn_print_fzl_variables_inventory)


     ;http://ergoemacs.org/emacs/elisp_datetime.html
 ;    (print (format-time-string "%B %A %d-%m-%Y %T"))


;;;MAGIT
;;;magit deps
;(defvar *cl-lib-path* (concat *fzl_emacs_packages* "/cl-lib-0.2.el")) 
;(message (concat "### Using *cl-lib-path* =" *cl-lib-path*))
;(load-file *cl-lib-path*)
;(require 'cl-lib)


;(defvar *git-modes_home* (concat *fzl_emacs_packages* "/git-modes-git-commit-mode-0.13")) 
;(message (concat "### Using *git-modes_home* =" *git-modes_home*))
;(add-to-list 'load-path *git-modes_home*)
;(package-install-file "git-commit-mode")
;(package-install-file (concat *git-modes_home* "/git-commit-mode.el"))
;(package-install-file (concat *git-modes_home* "/git-rebase-mode.el"))
;(package-install-file (concat *git-modes_home* "/gitconfig-mode.el"))
;(package-install-file (concat *git-modes_home* "/gitignore-mode.el"))




;;.magit
;(defvar *magit_home* (concat *fzl_emacs_packages_checkouts* "/magit")) 
;(message (concat "### Using *magit_home* =" *magit_home*))

;(add-to-list 'load-path *magit_home*)
;(add-to-list 'load-path "/path/to/git-modes")
;(require 'magit)





;;util to compile a .el file
;byte-compile-file.sh






;javascript_mode_config.el
;jdee_config.el
;nxml_mode_config.el

;sql_mode_config.el
;xml_mode.el
;yasnippet_config.el





;(setq load-path
;      (append (list nil *fzl_emacs_packages_checkouts*) load-path))

;(add-to-list 'load-path
;             (concat  *fzl_emacs_packages_checkouts* "/yasnippet"))

;(add-to-list 'load-path
;             (concat *fzl_emacs_packages_checkouts* "/magit"))


;(add-to-list 'load-path 
;              (concat *fzl_emacs_packages_checkouts* "/cedet/common"))

;(add-to-list 'load-path 
;             (concat  *FZL_HOME* "/js2-mode"))


;(autoload 'js2-mode "js2-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))




;(require  'config_general_emacs_behaviour)
;(require 'yasnippet_config)
;(require 'magit_config)

;(require 'ceted_config)
;(require 'javascript_mode_config)
;(require 'xml_mode)
;(require 'calendar_config)
;(require 'speedbar_config)
;(require 'fzl_customization_functions)
;(require 'org_mode_config)
;(require 'sql_mode_config)




; i n s t a l a n d o    a u t o - j a v a - c o m p l e t e
;https://raw.github.com/emacs-java/auto-java-complete/0.2.8/Install
;(add-to-list 'load-path 
;	     (concat *fzl_emacs_config_dir* "/site/auto-java-complete/"))
;(require 'ajc-java-complete-config)
;(add-hook 'java-mode-hook 'ajc-java-complete-mode)
;(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

; FIM i n s t a l a n d o    a u t o - j a v a - c o m p l e t e


;;; i n s t a l a n d o    o   j a v a d o c - h e l p . e l 
;;(add-to-list 'load-path (concat *fzl_emacs_config_dir* "/site/javadoc-help-site"))
;;  Next add the following to your .emacs startup file.
;;    (require 'javadoc-help)
;;
;;  or add the autoloads for the public command functions.
;;    (autoload 'javadoc-lookup       "javadoc-help" "Look up Java class in Javadoc."   t)
;;    (autoload 'javadoc-help         "javadoc-help" "Open up the Javadoc-help menu."   t)
;;    (autoload 'javadoc-set-predefined-urls  "javadoc-help" "Set pre-defined urls."    t)
;;; Configuration:
;;
;;  Assign the commands to some keys in your .emacs file.
;;
;;  Examples below assign a set of keys to the javadoc-help functions.
;;    (global-set-key [(f1)]          'javadoc-lookup)  ; F1 to lookup
;;    (global-set-key [(shift f1)]    'javadoc-help)    ; Shift-F1 to bring up menu
;;
;;  Javadoc-help uses browse-url to launch the system web browser.  Make sure
;;  it's working for your platform.  Try it out with, M-x browse-url.  Usually
;;  browse-url defaults to the OS default browser.  Some the OS default browser
;;  might not be set up.  Use 'M-x customize-option' browse-url-browser-function
;;  to pick a specific browser, (like setting Firefox as the browser to use).

; M O S T R A N D O   O    F Z L - M E S S A G E S . O R G
;(find-file (concat *FZL_HOME*  "/etc/emacs/fzl-messages.org"))


;P R I N T I N G    F I N A L     C O N F I G U R A T I O N 
;(defun get_tempo_de_carregamento_do_emacs (time-qdo-o-emacs-comecou-a-subir) 
;  (time-to-seconds (time-since time-qdo-o-emacs-comecou-a-subir))
;)


;(message "\n\n\n
;-----------------------------------
;P R I N T I N G    S O M E    F I N A L    C O N F I G   P A R A M E T E R S.")
;(message "----------------------------------- \n")
;(message "get_tempo_de_carregamento_do_emacs = %d" (get_tempo_de_carregamento_do_emacs current-time-at-emacs-startup))
