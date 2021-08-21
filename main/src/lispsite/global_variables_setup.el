;;; Package -- Summary:
;;; Commentary:
;; this file sets some path to define some dev tools location
;; this file update the path environment variable too

;;; Code:
(print "===> global_variable_setup.el was loaded sucessfully!!!")


(defvar this_elisp_file_dir (getenv "PWD"))
(defvar **EMACSINITFILE_HOME** (concat this_elisp_file_dir "/../../.."))
(setq **EMACSINITFILE_TESTS_LISPSITE** (concat **EMACSINITFILE_HOME** "/main/src/testssite"))

(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **EMACSINITFILE_HOME** "/bin"))))
(shell-command (concat "chmod +x " (concat **EMACSINITFILE_HOME** "/bin/*.sh"))) ;makes ./bin files executable

(defvar **fzlbpms/SUBMODULES_HOME** (concat **EMACSINITFILE_HOME** "/submodules")
  "The emacsinitifle has git submodules and **fzlbpms/SUBMODULES_HOME** sets common submodules directory.")

;; fzlbpms integration
;; [todo] check if FZL_HOME environment variabel is setted if not use hard coded one
(setq **FZL_HOME** (getenv "FZL_HOME"))
(message (concat "[global_variables_setup.el] **FZL_HOME** = " **FZL_HOME**))

(setq **FZL_SERVER** (concat **FZL_HOME** "/fzlServer"))
(setq **FZL_STUDIO** (concat **FZL_HOME** "/fzlStudio"))
(message (concat "[global_variables_setup.el] **FZL_SERVER** = " **FZL_SERVER**))
(message (concat "[global_variables_setup.el] **FZL_STUDIO** = " **FZL_STUDIO**))

(setenv "FZL_STUDIO" **FZL_STUDIO**)
(setenv "FZL_SERVER" **FZL_SERVER**)
(message (concat "[global_variables_setup.el] echo $FZL_STUDIO = " (getenv "FZL_STUDIO")))
(message (concat "[global_variables_setup.el] echo $FZL_SERVER = " (getenv "FZL_SERVER")))

;; the first httpd_root dir is get from EMCAS_SIMPLE_HTTPD_ROOT environment variable
;; if its nil, we user default one in **EMACSINITFILE_HOME**
(if (equal "" (getenv "EMACS_SIMPLE_HTTPD_ROOT"))
    (progn
      (setq **config_simple_httpd_root** (getenv "EMACS_SIMPLE_HTTPD_ROOT"))
      (message (concat "**config_simple_httpd_root** (setted by environment variable) = " **config_simple_httpd_root**)))
  (progn
    (setq **config_simple_httpd_root** (concat **EMACSINITFILE_HOME** "/httpd-root"))
    (message (concat "**config_simple_httpd_root** (using default) = " **config_simple_httpd_root**))))

;; [todo] check if FZL_HOME environment variable is setted if not warn user about it
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **FZL_HOME** "/bin")))


;; org-mode configuration path
;;https://emacs.stackexchange.com/questions/19391/can-t-set-directory-for-org-mode-capture
;;https://orgmode.org/worg/org-configs/org-customization-guide.html

;;TODO
;;if org-directory does not exists emacs will try to create it
;;but sometimes there are not permission
;;needs to test about it and to decide what to do in this case
(setq **org-directory** (concat **FZL_HOME** "/emacs/org-directory"))
(setq **aws-s3-planosdeaulas_publish_project_base-directory** (concat **FZL_HOME** "/submodules/somewritings/planosdeaulas"))
(setq **aws-s3-planosdeaulas_publishing-directory** (concat **FZL_HOME** "/emacs/org-publishing-directory/aws-s3-planosdeaulas"))


;; [todo] orgmode publish paths integration

;; [camunda integration]
;; (setq **SIN5009WithCamundaDir** "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/SIN5009WithCamunda")


;;;JAVA ENRIRONMENT VARIABLES
(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk-14.0.2"))
(setenv "JAVA_HOME" **JAVA_HOME**)
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME** "/bin"))))


;;GRADLE ENVIRONMENT VARIABLES
(setq **GRADLE_HOME** (concat **FZL_STUDIO** "/integrated/build/gradle-6.5"))
(setenv "GRADLE_HOME" **GRADLE_HOME**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **GRADLE_HOME** "/bin")))

;;;MAVEN ENVIROMENT VARIABLES
(setq **M2_HOME** (concat **FZL_STUDIO** "/integrated/build/apache-maven-3.6.3"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **M2_HOME** "/bin")))

;;;ANT
(setq **ANT_HOME** (concat **FZL_HOME** "/integrated/build/apache-ant-1.10.8"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANT_HOME** "/bin")))

;;;KARAF ENVIROMENT VARIABLES
(setq **KARAF_HOME** (concat **FZL_SERVER** "/integrated/apache-karaf-4.2.7"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **KARAF_HOME** "/bin")))

;;ANDROID SDK  ENVIRONMENT VARIABLES
;;ANDROID_HOME is depracated
(setq **ANDROID_STUDIO_PROJECTS_DIR** "/home/wagner/wagnerdocri@gmail.com/progsativos/AndroidStudioProjects/")
(setq **ANDROID_SDK_ROOT** (concat **FZL_STUDIO** "/integrated/android/androidSdk"))

(setenv "ANDROID_SDK_ROOT" **ANDROID_SDK_ROOT**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/platform-tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools/bin")))
;(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/emulator")))


;;;JEKYLL
;;(setq **JEKYLL-WEB-SITE-HOME**
;;      (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/notasdeaulaswagnermarques"))


;;;SQLITE
;;(setq **FZL_SQLITE_HOME** (concat **FZL_HOME** "/integrated/db/sqlite-tools-linux-x86-3310100"))
;;(setenv "PATH" (concat (concat (getenv "PATH") ":") **FZL_SQLITE_HOME**))


;;;HSQLDB
;;(setq **FZL_HQSQL_HOME** (concat **FZL_HOME** "/integrated/db/hsqldb"))
;;(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **FZL_HQSQL_HOME** "/bin")))


;;;SQUIRREL SQL
;;(setq **FZL_SQUIRRELSQL_HOME** (concat **FZL_HOME** "/integrated/db/squirrelsql-3.9.0-standard"))
;;(setenv "PATH" (concat (concat (getenv "PATH") ":") **FZL_SQUIRRELSQL_HOME**))



;;;D E S K T O P    F U N C T I O N A L I T I E S
;;(setq **GDriveLocalRootDir** (concat **DISK** "/wagnerdocri@gmail.com3/GDrive"))

;;run rclone config in order this configuration can work
;;if you have been runned it befor, consult /home/$USER/.config/rclone/rclone.config
;;(setq **rclone_remote_config_session**  "gdrive_wgn")


;;;C O N T A I N E R S    F U N C T I O N A L I T I E S
;;(setq **CONTAINERS_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles"))
;;(setq **maven_container_home** (concat **CONTAINERS_HOME** "/maven"))


(provide 'global_variables_setup)
