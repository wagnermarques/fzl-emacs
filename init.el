(setq debug-on-error t)
(require 'cl)

(defun define_enviroment_variables()
  "fzlbpms define a enviroment variables, 
   but users that are using this emacsinitel configuration without fzlbpms 
   runs this function to define some enviroment variable like JAVA_HOME, M2_HOME etc...
   That enviroment variables are difined in properties.csv and readed by this function"
  (setenv "M2_HOME" "/home/administrador/progsativos/fzlbpms/integrated/builds/apache-maven-3.3.3")
  (setenv "PATH" (concat (getenv "PATH") ":/home/administrador/progsativos/fzlbpms/integrated/builds/apache-maven-3.3.3/bin"))
)

(defun require_common_packages()
  "requires common packages... common in sense that will be required either with or without fzlbpms"
  (require 'config_code_lisp)
  (require 'config_package_system)
  (require 'config_lines_columns_and_cursor_behaviour)
  (require 'config_general_emacs_behaviour)
  (require 'config_buffers)
  (require 'fzl_find_file_functions)
  (require 'fzl_keys)
  (require 'fzl_utils)
  (require 'speedbar_config)
  (require 'flycheck_config)
)


(defun customize_emacs_in_fzlbpms_presence (strFzlHome)
  "customize_emacs_in_fzlbpms_presence"
  (let* ((*FZL_HOME* strFzlHome))
    (require_common_packages)
;;    (require 'config_global_variables_in_fzlbpms_presence)
    )
)


(defun customize_emacs_without_fzlbpms_enviroment()
  "customize_emacs_without_fzlbpms_envoriment"
  (require_common_packages)
  (define_enviroment_variables)
)


;; atencao: *fzl_emacs_site_lisp* ou *default_load_path_dir*
;; (add-to-list 'load-path *default_load_path_dir*)
(if (getenv "FZL_HOME")
    (let* ((*FZL_HOME* (getenv "FZL_HOME"))
	   (*fzl_emacs_config_dir* (concat *FZL_HOME* "/etc/emacs"))
	   (*fzl_emacs_site_lisp* (concat *fzl_emacs_config_dir* "/emacsinitel"))
	   (*fzl_emacs_packages_checkouts* (concat  *fzl_emacs_config_dir* "/checkouts"))
	   (*fzl_emacs_packages_downloaded* (concat *fzl_emacs_config_dir* "/downloaded-packages"))
	   (*fzl-backup-dir* (concat *FZL_HOME* "/backups/emacs/autosaved_files"))
	   (*fzl_shared_schemas* (concat *FZL_HOME* "/shared/xml_schemas"))
	   (package-user-dir  (concat *fzl_emacs_config_dir* "/installed_from_elpa" ))
	   (*default_load_path_dir* "/home/administrador/env-dev/sources/emacsinitfile")
           (default-directory *FZL_HOME*))
      (add-to-list 'load-path *default_load_path_dir*)
      ;;FZL_HOME directory must be defined and created fisically
      (if (not (file-directory-p (concat *FZL_HOME* "/etc")))
	  (mkdir (concat *FZL_HOME* "/etc")))
      (if (not (file-directory-p (concat *FZL_HOME* "/etc/emacs")))
	  (mkdir (concat *FZL_HOME* "/etc/emacs")))
      (if (not (file-directory-p *fzl_emacs_site_lisp* ))
	  (mkdir *fzl_emacs_site_lisp*))
      (if (not (file-directory-p *fzl_emacs_packages_checkouts*))
	  (mkdir *fzl_emacs_packages_checkouts*))
      (if (not (file-directory-p *fzl_emacs_packages_downloaded*))
	  (mkdir *fzl_emacs_packages_downloaded*))
      (if (not (file-directory-p (concat *fzl_emacs_config_dir* "/installed_from_elpa" )))
	  (mkdir (concat *fzl_emacs_config_dir* "/installed_from_elpa" )))
      (if (not (file-directory-p (concat *FZL_HOME* "/backups")))
	  (mkdir (concat *FZL_HOME* "/backups")))
      (if (not (file-directory-p (concat *FZL_HOME* "/backups/emacs")))
	  (mkdir (concat *FZL_HOME* "/backups/emacs")))
      (if (not (file-directory-p (concat *FZL_HOME* "/backups/emacs/autosaved_files")))
	  (mkdir (concat *FZL_HOME* "/backups/emacs/autosaved_files")))
      (if (not (file-directory-p (concat *FZL_HOME* "/shared")))
	  (mkdir (concat *FZL_HOME* "/shared")))
      (if (not (file-directory-p (concat *FZL_HOME* "/shared/xml_schemas")))
	  (mkdir (concat *FZL_HOME* "/shared/xml_schemas")))
      (customize_emacs_in_fzlbpms_presence *FZL_HOME*)
      (find-file (concat  *fzl_emacs_site_lisp* "/init.el"))
       (find-file (concat  *fzl_emacs_site_lisp* "/index.org"))
      )


  (let* ((*default_load_path_dir* "/home/administrador/env-dev/sources/emacsinitfile")
	 (package-user-dir  "~/.emacs.d/elpa" )
         (default-directory "~/env-dev/sources/emacsinitfile"))
    (add-to-list 'load-path *default_load_path_dir*)
    (if (not (file-directory-p "~/.emacs.d/elpa"))
	(mkdir "~/.emacs.d/elpa"))
    (if (not (file-directory-p "~/.emacs.d/backups"))
	(mkdir "~/.emacs.d/backups"))
    (if (not (file-directory-p "~/.emacs.d/xml_schemas"))
	(mkdir "~/.emacs.d/xml_schemas"))
    (customize_emacs_without_fzlbpms_enviroment)
    (find-file (concat  *default_load_path_dir* "/init.el"))
    (find-file (concat  *default_load_path_dir* "/index.org")))

  );;(if (getenv "FZL_HOME")





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




;;pagkages configs
;(require 'org_mode_config)
;(require 'calendar_config)
;(require 'cedet_config)
;(require 'autocomplete_config)
;(require 'js_mode_config)

;(require 'sql_mode_config)
;(require 'yasnippet_config)
;(require 'config_code_c_style_for_K_and_RStyle)

;;     (require 'config_lines_columns_and_cursor_behaviour)
;     (require 'config_fonts_and_themes) ;maybe its contents must migrate to buffers_config.el
;     (require 'fzl_customization_functions)
;     (require 'fzl_keys)
     
;     (require 'calendar_config)
;     (require 'find_files)


     ;dev
     ;commented because I am not using FZL_APP_HOME for a wile...
     ;(require  'util-minibuffer-as-a-promp)



     ;P A C K A G E S   C O N F I G U R A T I O N S
     ;C E D E T
;     (require  'fzl_pkg_install_functions)
;     (require  'autocomplete_config) 
;     (require  'cedet_config)
;     (require  'speedbar_config)
     
     
     ;C O D I N G   C O N F I G U R A T I O N S
     ;TODO make a common config_code.el for all languages
     ;TODO make a config_code_specificlanguage.el for each specific language
     ;TODO explain better the 'config_code_system as a file documentation
;     (require 'config_code_in_general)
;     (require 'config_code_system)
;     (require 'config_code_lisp)
     
     ;c++
;     (require  'config_code_c_style_for_K_and_RStyle)

     ;xml
;     (defvar *nxml_or_PSGML* "nxml")
;     (require 'xml_mode) ;TODO: nxml




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





;iimage_mode_config.el
;iswitchb_config.el
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
;(require 'iimage_mode_config)



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




