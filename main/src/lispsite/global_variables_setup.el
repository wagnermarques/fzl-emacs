;;; Package -- Summary:
;;; Commentary:
;; this file sets some path to define some dev tools location
;; this file update the path environment variable too

;;; Code:
(print "===> global_variable_setup.el was loaded sucessfully!!!")
(provide 'global_variables_setup)


;;Disclaimer
;;I've been useing non final slash pattern

;;there are some strategic commands in bin directory
(setq **FZL_HOME** (getenv "FZL_HOME"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **FZL_HOME** "/bin")))

(setq **EMACSINITFILE_HOME**  (concat **FZL_HOME** "/emacsinitfile"))
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **EMACSINITFILE_HOME** "/bin"))))
(shell-command (concat "chmod +x " (concat **EMACSINITFILE_HOME** "/bin/*.sh"))) ;makes ./bin files executable

(setq **EMACSINITFILE_LISPSITE** (concat **EMACSINITFILE_HOME** "/main/src/lispsite"))
(setq **EMACSINITFILE_TESTSSITE** (concat **EMACSINITFILE_HOME** "/main/src/testssite"))


;;orgmode publish paths
;;(setq **SOMEWRITENS_HOME** (concat **DISK** "/envs/env-dev/sources/somewritings"))
;;(setq **org-publish-project-base-directory-4-jekyll-html-export** (concat **SOMEWRITENS_HOME** "/planosdeaulas"))
;;(setq **org-publish-project-publishing-directory-4-jekyll-html-export** (concat **SOMEWRITENS_HOME** "/var/publishing-directory/planosdeaulas"))
;;(setq **org-publish-project-base-directory-4-aws-s3-planosdeaulas** (concat **SOMEWRITENS_HOME** "/planosdeaulas"))
;;(setq **org-publish-project-publishing-directory-4-aws-s3-planosdeaulas** (concat **SOMEWRITENS_HOME** "/var/publishing-directory/planosdeaulas"))


;;SOURCES
;;(setq **SIN5009WithCamundaDir** "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/SIN5009WithCamunda")


;;; D E V   T O O L S   H O M E
;;; FZL_HOME
(setq **FZL_SERVER** (concat **FZL_HOME** "/fzlServer"))
(setq **FZL_STUDIO** (concat **FZL_HOME** "/fzlStudio"))

;;;JAVA ENRIRONMENT VARIABLES
(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk1.8.0_201"))
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


(setq **KARAF_HOME** (concat **FZL_SERVER** "/integrated/apache-karaf-4.2.7"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **KARAF_HOME** "/bin")))

;;ANDROID ENVIRONMENT VARIABLES
;;ANDROID_HOME is depracated
;;(setq **ANDROID_STUDIO_PROJECTS_DIR** "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/AndroidStudioProjects/")

;(setq **ANDROID_STUDIO_HOME** (concat **DISK** "/PROGSATIVOS/android-studio"))
;(setq **ANDROID_STUDIO_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio/integrated/ides/idea-IC-183.5429.30"))

(setq **ANDROID_SDK_ROOT** (concat **FZL_STUDIO** "/integrated/android/androidSdk"))
(setenv "ANDROID_SDK_ROOT" **ANDROID_SDK_ROOT**)
(setenv "ANDROID_SDK_HOME" **ANDROID_SDK_ROOT**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/platform-tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools/bin")))
;;(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/emulator")))

;;ANDROID_EMULATOR_HOME is defined, it replaces the path of the '$HOME/.android'
(setq **ANDROID_EMULATOR_HOME** (concat **FZL_STUDIO** "/integrated/android/android_emulators"))
(setenv "ANDROID_EMULATOR_HOME" **ANDROID_EMULATOR_HOME**)



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
(setq **rclone_remote_config_session**  "gdrive_wgn")


;;;C O N T A I N E R S    F U N C T I O N A L I T I E S
;;(setq **CONTAINERS_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles"))
;;(setq **maven_container_home** (concat **CONTAINERS_HOME** "/maven"))
