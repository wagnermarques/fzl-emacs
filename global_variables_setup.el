;;; Package -- Summary:
;;; Commentary:
;;; Code:
(provide 'global_variables_setup)

;;Disclaimer
;;We've been useing non final slash pattern
(setq **DISK** "/home/wagner")

(setq **GDriveLocalRootDir** (concat **DISK** "/wagnerdocri@gmail.com3/GDrive"))

;;run rclone config in order this configuration can work
;;if you have been runned it befor, consult /home/$USER/.config/rclone/rclone.config
(setq **rclone_remote_config_session**  "gdrive_wgn")

(setq **EMACSINITFILE_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/envs/env-dev/sources/emacsinitfile"))

(setq **FZL_HOME** (concat **DISK** "/wagnerdocri@gmail.com3/fzlbpms/fzlStudio"))

(setq **FZL_HOME_SERVER** (concat **DISK** "/wagnerdocri@gmail.com2/fzlbpms/fzlServer"))

(setq **WKSP_MVN_PROJECTS** (concat **DISK** "/wagnerdocri@gmail.com2/envs/env-dev/sources/mvnprojects"))

(setq **ANDROID_HOME** (concat **FZL_HOME** "/integrated/Android/Sdk"))

;;; Choose java jdk version
(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk1.8.0_151"))
;(setq **JAVA_HOME** (concat **FZL_HOME** "/integrated/jdks/jdk-9.0.1"))

;;;BUILDING
(setq **M2_HOME** (concat **FZL_HOME** "/integrated/build/apache-maven-3.5.3"))
(setq **ANT_HOME** (concat **FZL_HOME** "/integrated/build/apache-ant-1.10.3"))

(setq **ORG-DIRECTORY** (concat **FZL_HOME** "/integrated/emacs/org-mode/files"))

(setq **FZL_SQLLITE_HOME** (concat **FZL_HOME** "/integrated/dbs/sqlite"))
(setq **FZL_HQSQL_HOME** (concat **FZL_HOME** "/integrated/dbs/hsqldb"))


