;;; Package -- Summary:
;;; Commentary:
;;; Code:
(provide 'global_variables_setup)

;;Disclaimer
;;We've been useing non final slash pattern
(setq **DISK** "/home/wagner")

(setq **EMACSINITFILE_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/emacsinitfile"))

(setq **FZL_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio"))

(setq **FZL_HOME_SERVER** (concat **DISK** "/wagnerdocri@gmail.com2/fzlbpms/fzlServer"))

(setq **WKSP_MVN_PROJECTS** (concat **DISK** "/wagnerdocri@gmail.com2/envs/env-dev/sources/mvnprojects"))


(setq **GRADLE_HOME** (concat **FZL_HOME** "/integrated/build/gradle-4.6-rc-2"))
(setenv "GRADLE_HOME" **GRADLE_HOME**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **GRADLE_HOME** "/bin")))

;;ANDROID_HOME is depracated
(setq **ANDROID_SDK_ROOT** (concat **FZL_HOME** "/integrated/Android/Sdk"))
(setenv "ANDROID_SDK_ROOT" **ANDROID_SDK_ROOT**)
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/platform-tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/tools/bin")))
(setenv "PATH" (concat (concat (getenv "PATH") ":") (concat **ANDROID_SDK_ROOT** "/emulator")))

;;ANDROID_EMULATOR_HOME is defined, it replaces the path of the '$HOME/.android'
(setq **ANDROID_EMULATOR_HOME** (concat **FZL_HOME** "/integrated/.android"))
(setenv "ANDROID_EMULATOR_HOME" **ANDROID_EMULATOR_HOME**)

;;; Choose java jdk version
(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk1.8.0_161"))
(setenv "JAVA_HOME" **JAVA_HOME**)
(setenv "PATH" (concat (getenv "PATH") (concat ":" (concat **JAVA_HOME** "/bin"))))
;(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk-9.0.1"))

;;;BUILDING
(setq **M2_HOME** (concat **FZL_HOME** "/integrated/build/apache-maven-3.5.3"))
(message **M2_HOME**)
(message **M2_HOME**)
(message **M2_HOME**)
(message **M2_HOME**)
(setq **ANT_HOME** (concat **FZL_HOME** "/integrated/build/apache-ant-1.10.3"))

(setq **ORG-DIRECTORY** (concat **FZL_HOME** "/integrated/emacs/org-mode/files"))

(setq **FZL_SQLLITE_HOME** (concat **FZL_HOME** "/integrated/dbs/sqlite"))
(setq **FZL_HQSQL_HOME** (concat **FZL_HOME** "/integrated/dbs/hsqldb"))



;;;D E S K T O P    F U N C T I O N A L I T I E S
(setq **GDriveLocalRootDir** (concat **DISK** "/wagnerdocri@gmail.com3/GDrive"))

;;run rclone config in order this configuration can work
;;if you have been runned it befor, consult /home/$USER/.config/rclone/rclone.config
(setq **rclone_remote_config_session**  "gdrive_wgn")

;;;C O N T A I N E R S    F U N C T I O N A L I T I E S
(setq **CONTAINERS_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/Fedora-Dockerfiles"))
(setq **maven_container_home** (concat **CONTAINERS_HOME** "/maven"))

