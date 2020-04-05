;;; package --- Summary

;;; Commentary:

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-


(defun fzl-android-proj-gradlew-build(projDirName)
  "Receive android studio PROJDIRNAME to Build."
  (interactive "sProjDirName?")
  (message "Running...")
  (message (concat (concat "cd " projDir) " && ./gradlew assembleDebug"))

  (setq projDir (concat **ANDROID_STUDIO_PROJECTS_DIR** projDirName))
  (start-process-shell-command
   "#ProcessName_FzlAndroid"
   "#ProcessName_FzlAndroid"
   (concat (concat "cd " projDir) " && ./gradlew assembleDebug"))
)

(defun fzl-android-proj-gradlew-install(projDirName)
  "Receive android studio PROJDIRNAME to Build."
  (interactive "sProjDirName?")
  (message "Running...")
  (message (concat (concat "cd " projDir) " && ./gradlew installDebug"))

  (setq projDir (concat **ANDROID_STUDIO_PROJECTS_DIR** projDirName))
  (start-process-shell-command
   "#ProcessName_FzlAndroid"
   "#ProcessName_FzlAndroid"
   (concat (concat "cd " projDir) " && ./gradlew installDebug"))
)

(defun fzl-android-proj-gradlew-install-and-run(projDirName)
  "Receive android studio PROJDIRNAME Build, install and run it."
  (interactive "sProjDirName?")
  (message "Running...")
  (message (concat (concat "cd " projDir) " && ./gradlew installDebug"))

  (setq projDir (concat **ANDROID_STUDIO_PROJECTS_DIR** projDirName))

  (start-process-shell-command
   "#ProcessName_FzlAndroid"
   "#ProcessName_FzlAndroid"
   (concat (concat "cd " projDir) " && ./gradlew installDebug"))

  (start-process-shell-command
   "#ProcessName_FzlAndroid"
   "#ProcessName_FzlAndroid"
   "adb shell am start -n loginapp.example.fzlbpms.com.br.exampleloginapp/.MainActivity"
   )

  
)


(defun fzl-android-adb-devices()
  "run adb devices"
  (interactive)
  (message "Running...")
  (message "adb devices")
  
  (start-process-shell-command
   "#ProcessName_FzlAndroid"
   "#ProcessName_FzlAndroid"
   "adb devices"))


(provide 'config_androiddev)

;;; this_config_androiddev ends here

