(use-package java-snippets
  :ensure t)


(setq *ANDROID_SDK_ROOT* "/media/wgn/ext4/PROGSATIVOS/Android/Sdk")
(setenv "ANDROID_SDK_ROOT" *ANDROID_SDK_ROOT*)


;;Linux PATH separated by :
(setq androidplatformtoolsExecPath (concat (getenv "ANDROID_SDK_ROOT") "/platform-tools"))
(setq androidToolsExecPath (concat (getenv "ANDROID_SDK_ROOT") "/tools:"))

(defun fzl-add-to-path(pathToBeAdded)
  (setenv "PATH" (concat pathToBeAdded (getenv "PATH"))))  

(fzl-add-to-path androidToolsExecPath)
(fzl-add-to-path androidplatformtoolsExecPath)


(defun fzl-adb-devices ()
  "Run `adb devices` in an ansi-term buffer."
  (interactive)
  (let* ((android-sdk-root (getenv "ANDROID_SDK_ROOT"))
         (adb-command (concat android-sdk-root "/platform-tools/adb devices"))
         (buffer-name "*ADB Devices*"))
    (ansi-term adb-command buffer-name)))

(global-set-key (kbd "C-c a") #'fzl-adb-devices)



(provide 'coding-android)
