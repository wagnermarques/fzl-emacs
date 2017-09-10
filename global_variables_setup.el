(provide 'global_variables_setup)
(message "=>global_variables_setup.el loaded sucessfully!!!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Some util global variables
;;;;;;;;;;;;;;;; For compose paths

;; user home directory
(setq **HOME** (concat (concat "/home/" (getenv "USER")) "/"))

;;A meaningfull name for this directory
;; **EMACSINITFILE_HOME** is where there are all .el files about this emacs customization project
;; represents the directory that contains my init.el file
;; I have been running may emacs whith "emacs -q -l  **EMACSINITFILE_HOME** direcoty/init.el
(setq **EMACSINITFILE_HOME**  **PWD**)


;;Yes we have a log file for this peace of code
(setq **EMACSINITFILE_LOG_FILE** (concat **EMACSINITFILE_HOME** "emacsinitfile.out"))


;; There are some git submodules that help this project to customize my emacs
;; *fzl_emacs_packages_checkouts* is the directory where t
(setq *git_sub_modules* (concat  **EMACSINITFILE_HOME** "dir_for_git_submodules"))


;; *fzl_emacs_packages_downloaded* is a directory for modules downloaded manually.
(setq *fzl_emacs_packages_downloaded* (concat **EMACSINITFILE_HOME** "dir_for_pkgs_downloads"))


;; *fzl_emacs_autosaved_files* is dir where emacs will autosave files
(setq *fzl_emacs_autosaved_files* (concat **EMACSINITFILE_HOME** "dir_for_autosaved_files"))


;; *fzl_emacs_yasnippets_snippets* dir is where there are my yasnippets snippets
(setq *fzl_emacs_yasnippets_snippets* (concat **EMACSINITFILE_HOME** "dir_for_yasnippets_snippets"))



;; **FZL_HOME** and **FZL_HOME_SERVER** define directories where there are a lot of my devtools softwares
;; **FZL_HOME** contains some devtools
;; **FZL_HOME_SERVER** contains some servers paths
;; I'm getting this variables fom enviroment variables
(if (not (and (getenv "FZL_HOME")  (getenv "FZL_HOME_SERVER")))
    (progn
      (message "PLEASE edit setup_path_global_variables_manually.el global variables to manually setup devtools you have!"))

  ;;FZL_HOME and FZL_HOME_SERVER was provided
  (progn        
    ;;TESTING AND EQUALIZE DIRS PROVIDED FOR NO VERY FINAL SLASH CHARACTERS
    ;;Lets see if area accessible paths
    (setq **FZL_HOME_provided** (getenv "FZL_HOME"))
    (setq **FZL_HOME_SERVER_provided** (getenv "FZL_HOME_SERVER"))

    (message (concat "**FZL_HOME_provided**" **FZL_HOME_provided**))
    (message (concat "**FZL_HOME_SERVER_provided**" **FZL_HOME_SERVER_provided**))

    (if (and (file-accessible-directory-p **FZL_HOME_provided**) (file-accessible-directory-p **FZL_HOME_SERVER_provided**))
	;;ok, FZL_HOME and FZL_HOME_SERVER are accessible directories
        (progn    
          (setq **FZL_HOME** (file-name-as-directory **FZL_HOME_provided**))
          (setq **FZL_HOME_SERVER** (file-name-as-directory **FZL_HOME_SERVER_provided**))
	  (setq **DEV_TOOLS_BASEDIR** (concat **FZL_HOME** "integrated/"))      
	  (setq **JAVA_HOME**   (concat **DEV_TOOLS_BASEDIR** "jdks/jdk1.8.0_65"))      
	  (setq **M2_HOME**     (concat **DEV_TOOLS_BASEDIR** "build/apache-maven-3.3.3"))          
	  (setq **NEXUS_HOME**  (concat **DEV_TOOLS_BASEDIR** "build/nexus-3.0.1-01/"))
	  (setq **ECLIPSE_MODELING_HOME**   (concat **DEV_TOOLS_BASEDIR** "eclipse/eclipse-modeling-neon-R-linux-gtk-x86_64/"))      
	  (setq **APACHEDS_STUDIO_HOME**   (concat **DEV_TOOLS_BASEDIR** "eclipse/ApacheDirectoryStudio-2.0.0.v20151221-M10-linux.gtk.x86_64/"))         
	  (setq **APACHEDS_HOME**   (concat **FZL_HOME_SERVER** "/integrated/servers/apacheds-2.0.0-M22/"))      
	  (setq **KARAF_HOME**      (concat **FZL_HOME_SERVER** "/integrated/servers/apache-karaf-4.0.5/"))
	  (setq **EXO_HOME**      (concat **FZL_HOME_SERVER** "/integrated/servers/platform-community-4.3.0/"))      
	  (setq **tide-tsserver_LOG_FILE** (concat **EMACSINITFILE_HOME** "tss.log"))            
	  (setq **WKSP_MVN_PROJECTS** (concat **FZL_HOME** "/workspaces/users/admin/mavenprojects/"))
	  ;; *fzl_shared_xml_schemas* is a dir where are all of my xml schemmas
	  (setq *fzl_shared_xml_schemas* (concat **FZL_HOME** "/shared/xml_schemas"))
	  (message **WKSP_MVN_PROJECTS**))
      ;;oh, FZL_HOME and FZL_HOME_SERVER are not accessible directories
      (progn
	(message "Sorry you try to provide FZL_HOME and/or FZL_HOME_SERVER but it was not accessible")))))


