;;; Package -- Summary:
;;; Commentary:
;; this file sets some path to define some dev tools location
;; this file update the path environment variable too

;;; Code:
(provide 'global_variables_setup)

;;Disclaimer
;;We've been useing non final slash pattern
;;FZLBPMS PATHS (Fzlbpms is just a directory with several development tools)
(setq **DISK** "/home/wagner")
(setq **ORG-PUBLISH-PROJ-BASE-DIR** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings"))
(setq **ORG-PUBLISHING-DIRECTORY** (concat  **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/planosenotasdeaulas/_posts"))

;;there are some strategic commands in bin directory
(setq **EMACSINITFILE_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/emacsinitfile"))
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **EMACSINITFILE_HOME** "/bin"))))
(shell-command "chmod +x ./bin/*.sh")

(setq **FZL_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio"))

(setq **FZL_HOME_SERVER** (concat **DISK** "/wagnerdocri@gmail.com2/fzlbpms/fzlServer"))
(setq **KARAF_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/progsativos/apache-karaf-4.2.6"))


;;;JAVA ENRIRONMENT VARIABLES
(setq **JAVA_HOME** "/home/wagner/PROGSATIVOS/jdk1.8.0_191")
(setenv "JAVA_HOME" **JAVA_HOME**)
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME** "/bin"))))

;;GRADLE ENVIRONMENT VARIABLES
(setq **GRADLE_HOME** (concat **FZL_HOME** "/integrated/build/gradle-5.1.1"))
(setenv "GRADLE_HOME" **GRADLE_HOME**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **GRADLE_HOME** "/bin")))

;;;MAVEN ENVIROMENT VARIABLES
(setq **WKSP_MVN_PROJECTS** (concat **DISK** "/wagnerdocri@gmail.com2/envs/env-dev/sources/mvnprojects"))
(setq **M2_HOME** (concat **FZL_HOME** "/integrated/build/apache-maven-3.6.0"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **M2_HOME** "/bin")))

;;;ANT
(setq **ANT_HOME** (concat **FZL_HOME** "/integrated/build/apache-ant-1.10.5"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANT_HOME** "/bin")))

;;ANDROID ENVIRONMENT VARIABLES
;;ANDROID_HOME is depracated
(setq **ANDROID_STUDIO_PROJECTS_DIR** "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/AndroidStudioProjects/")

(setq **ANDROID_STUDIO_HOME** (concat **DISK** "/PROGSATIVOS/android-studio"))
;(setq **ANDROID_STUDIO_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio/integrated/ides/idea-IC-183.5429.30"))

(setq **ANDROID_SDK_ROOT** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio/integrated/android/androidSdk"))
(setenv "ANDROID_SDK_ROOT" **ANDROID_SDK_ROOT**)
(setenv "ANDROID_SDK_HOME" **ANDROID_SDK_ROOT**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/platform-tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools/bin")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/emulator")))


;;ANDROID_EMULATOR_HOME is defined, it replaces the path of the '$HOME/.android'
(setq **ANDROID_EMULATOR_HOME** (concat **FZL_HOME** "/integrated/android/android_emulators"))
(setenv "ANDROID_EMULATOR_HOME" **ANDROID_EMULATOR_HOME**)

;;;JEKYLL
(setq **JEKYLL-WEB-SITE-HOME**
      (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles/jekyll/jekyll-websites/notasdeaulaswagnermarques"))

;;;EMACS
;;https://orgmode.org/worg/org-configs/org-customization-guide.html
(setq **ORG-DIRECTORY** (concat **FZL_HOME** "/integrated/emacs/org-directory"))


;;;SQLITE
(setq **FZL_SQLITE_HOME** (concat **FZL_HOME** "/integrated/db/sqlite-tools-linux-x86-3260000"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") **FZL_SQLITE_HOME**))

;;;HSQLDB
(setq **FZL_HQSQL_HOME** (concat **FZL_HOME** "/integrated/db/hsqldb"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **FZL_HQSQL_HOME** "/bin")))

;;;SQUIRREL SQL
(setq **FZL_SQUIRRELSQL_HOME** (concat **FZL_HOME** "/integrated/db/squirrelsql-3.9.0-standard"))
(setenv "PATH" (concat (concat (getenv "PATH") ":") **FZL_SQUIRRELSQL_HOME**))


;;;D E S K T O P    F U N C T I O N A L I T I E S
(setq **GDriveLocalRootDir** (concat **DISK** "/wagnerdocri@gmail.com3/GDrive"))

;;run rclone config in order this configuration can work
;;if you have been runned it befor, consult /home/$USER/.config/rclone/rclone.config
(setq **rclone_remote_config_session**  "gdrive_wgn")


;;;C O N T A I N E R S    F U N C T I O N A L I T I E S
(setq **CONTAINERS_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles"))
(setq **maven_container_home** (concat **CONTAINERS_HOME** "/maven"))


