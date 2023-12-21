(use-package java-snippets
  :ensure t)

(setq *ANDROID_SDK_ROOT* (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/Android/Sdk"))
(setenv "ANDROID_SDK_ROOT" *ANDROID_SDK_ROOT*)

;;https://developer.android.com/studio/run/device?hl=pt-br
;;(sudo groupadd plugdev)

(shell-command "sudo usermod -aG plugdev $LOGNAME")

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
  (shell-command "echo $ANDROID_SDK_ROOT" "*ADB Devices*"))
(fzl-adb-devices)

(global-set-key (kbd "C-c C-f C-a d") #'fzl-adb-devices)



(provide 'coding-android)
