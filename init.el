(setq debug-on-error t)

(require 'cl)


;;(setq url-proxy-services '(("no_proxy"   . "work\\.com")
;;                           ("http_proxy" . "wagner:nicolas1*@192.168.0.2:3128")
;;			    ("ftp_proxy"  . "wagner:nicolas1*@192.168.0.2:3128")
;;			    ("all_proxy"  . "wagner:nicolas1*@192.168.0.2:3128")))


(setq **HOME** (concat (concat "/home/" (getenv "USER")) "/"))


(defun fzl_print_global_variables()
  "print defined variables and its values"
  (interactive)
  (message (concat "**HOME** = \t" **HOME**))  
  (message (concat "**PWD** = \t" **PWD**))
  (message (concat "**FZL_HOME** = \t" **FZL_HOME**))
  (message (concat "**DEV_TOOLS_BASEDIR** = \t" **DEV_TOOLS_BASEDIR**))
  
  (message (concat "**M2_HOME** = \t" **M2_HOME**))
  (message (concat "**NEXUS_HOME** = \t" **NEXUS_HOME**))
  (message (concat "**JAVA_HOME** = \t"  **JAVA_HOME**))

  (message (concat "**EMACSINITFILE_HOME** = \t" **EMACSINITFILE_HOME**))  
  (message (concat "**EMACSINITFILE_LOG_FILE** = \t" **EMACSINITFILE_LOG_FILE**))

  (message (concat "*fzl_emacs_packages_checkouts* = \t" *fzl_emacs_packages_checkouts*))
  (message (concat "*fzl_emacs_packages_downloaded* = \t" *fzl_emacs_packages_downloaded*))
  (message (concat "*fzl_emacs_autosaved_files* = \t" *fzl_emacs_autosaved_files*))
  (message (concat "*fzl_emacs_yasnippets_snippets*" *fzl_emacs_yasnippets_snippets*))
  
  (message (concat "*fzl_shared_xml_schemas* = \t" *fzl_shared_xml_schemas*))
  (message (concat "*packages-installed-from-elpa-dir* = \t"  *packages-installed-from-elpa-dir*))
  )



(defun configure_load_path()
  (setq load-path
	(append (list nil **EMACSINITFILE_HOME**
                    *fzl_emacs_packages_checkouts*
                    "~/emacs")
		load-path)))




;;DEFINE THIS ENVIRONMENTAL VARIABLE
;;THIS JUST REPRESENTS A DIRECTORY WHERE SHOULD BE YOU DEVTOOLS WHERE ARE YOURS INTEGRATED DIR
(if (not (and (getenv "FZL_HOME")  (getenv "FZL_HOME_SERVER")))

    ;;in case FZL_HOME was not defined...
    (message "PLEASE EXPORT FZL_HOME AND FZL_HOME_SERVER ENVIRONMENT VARIABLES")


  ;;in case FZL_HOME was defined...
  (progn
    (setq **PWD** (file-name-directory load-file-name))


    ;;TEST AND EQUALIZE DIRS PROVIDED FOR NO VERY FINAL SLASH CHARACTERS
    (setq **FZL_HOME_provided** (getenv "FZL_HOME"))
    (setq **FZL_HOME_SERVER_provided** (getenv "FZL_HOME_SERVER"))
    (if (and (file-accessible-directory-p **FZL_HOME_provided**) (file-accessible-directory-p **FZL_HOME_SERVER_provided**))
        (progn    
          (setq **FZL_HOME** (file-name-as-directory **FZL_HOME_provided**))
          (setq **FZL_HOME_SERVER** (file-name-as-directory **FZL_HOME_SERVER_provided**)))
      (error "Sorry the $FZL_HOME and $FZL_HOME_SERVER must be accessible"))
    

    (setq **DEV_TOOLS_BASEDIR** (concat **FZL_HOME** "integrated/"))
    (message **DEV_TOOLS_BASEDIR**)

    ;;CHANGE DEV TOOLS ACCORDINGLY
    (setq **M2_HOME**     (concat **DEV_TOOLS_BASEDIR** "build/apache-maven-3.3.3/"))    
    (setq **NEXUS_HOME**  (concat **DEV_TOOLS_BASEDIR** "build/nexus-3.0.1-01/"))

    (setq **JAVA_HOME**   (concat **DEV_TOOLS_BASEDIR** "jdks/jdk1.8.0_65/"))

    (setq **APACHEDS_STUDIO_HOME**   (concat **DEV_TOOLS_BASEDIR** "eclipse/ApacheDirectoryStudio-2.0.0.v20151221-M10-linux.gtk.x86_64/"))
    (setq **ECLIPSE_MODELING_HOME**   (concat **DEV_TOOLS_BASEDIR** "eclipse/eclipse-modeling-neon-R-linux-gtk-x86_64/"))    

    (setq **APACHEDS_HOME**   (concat **FZL_HOME_SERVER** "/integrated/servers/apacheds-2.0.0-M22/"))

    (setq **KARAF_HOME**      (concat **FZL_HOME_SERVER** "/integrated/servers/apache-karaf-4.0.5/"))
    (setq **EXO_HOME**      (concat **FZL_HOME_SERVER** "/integrated/servers/platform-community-4.3.0/"))
    
    (setq **EMACSINITFILE_HOME**  **PWD**)
    (setq **EMACSINITFILE_LOG_FILE** (concat **EMACSINITFILE_HOME** "emacsinitfile.out"))

    (setq *fzl_emacs_packages_checkouts* (concat  **EMACSINITFILE_HOME** "dir_for_pkgs_checkouts"))
    (setq *fzl_emacs_packages_downloaded* (concat **EMACSINITFILE_HOME** "dir_for_pkgs_downloads"))
    (setq *fzl_emacs_autosaved_files* (concat **EMACSINITFILE_HOME** "dir_for_autosaved_files"))
    (setq *fzl_emacs_yasnippets_snippets* (concat **EMACSINITFILE_HOME** "dir_for_yasnippets_snippets"))
    
    (setq *fzl_shared_xml_schemas* (concat **FZL_HOME** "/shared/xml_schemas"))
    (setq *packages-installed-from-elpa-dir*  (concat **EMACSINITFILE_HOME** "/dir_for_elpa_pkg_installations" ))

    (setq **WKSP_MVN_PROJECTS** (concat **FZL_HOME** "/workspaces/users/admin/mavenprojects/"))
    (message **WKSP_MVN_PROJECTS**)
    
    
    (fzl_print_global_variables)
    (configure_load_path)

    ;;Comment line below if you are not behind a proxy
    ;;(require 'config_proxy)

    (require 'fzl_functions)
    (require 'config_logging)
    (require 'config_code_lisp)
    (require 'config_package_system)

    (require 'iimage_mode_config)
    (require 'iswitchb_config)
    
    (require 'config_lines_columns_and_cursor_behaviour)
    (require 'config_general_emacs_behaviour)
    (require 'config_buffers)

    (require 'fzl_find_file_functions)
    (require 'fzl_keys)
    (require 'fzl_utils)

    (require 'cedet_config)
    (require 'speedbar_config)
    (require 'flycheck_config)

    (require 'org_mode_config)
    (require 'calendar_config)
    (require 'ess_config)
    (require 'autocomplete_config)

   ;C O D I N G   C O N F I G U R A T I O N S
    (require 'config_code_in_general)
    (require 'js_mode_config)
    (require 'config_code_c_style_for_K_and_RStyle)
    (require 'sql_mode_config)
    (require 'yasnippet_config)
    (require 'config_env_for_shell_and_startup_some_dev_tools)
    (require 'config-web-mode)

    (require 'fzl_menus)
    (require 'config_eclipse)
    (require 'find_files)
;(require 'config_code_c_style_for_K_and_RStyle)

    ;;xml
     (defvar *nxml_or_PSGML* "nxml")
     (require 'xml_mode) ;TODO: nxml

    (find-file "init.el")
    (find-file "org_mode_config.el")
    (find-file "index.org")
    (log "+++++ EMACSINITFILE INITIALIZATION PROCESSED +++++")
    );(else block, the (progn
  );(if
	     
;(find-file (concat **EMACSINITFILE_HOME** "/init.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/index.org"))
;(find-file (concat **EMACSINITFILE_HOME** "/fzl_functions.el"))
;(find-file (concat **EMACSINITFILE_HOME** "/config-enviroment.el"))



;(defun fzl-bashcommand-autocomplete-installation-shell-script()
;  "just download in the fzlbpms context rigth place. 
;   Change init.el accordingle is needed"
;  (interactive)
;  (split-string
;   (shell-command-to-string "bash autocomplete_installation.sh")))

;(defun fzl-bashcommand-cedet-installation-shell-script()
;  "just download in the fzlbpms context rigth place. Change init.el accordingle is needed"
;  (interactive)
;  (split-string
;   (shell-command-to-string "bash cedet_installation.sh")))









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
;(require 'autocomplete_config)
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
