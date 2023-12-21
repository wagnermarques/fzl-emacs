;;; package --- Summary

;;; Commentary:

;;; Code:

(setq _ANDROID_SDK_ROOT_ "/home/wgn/mnt/ext4/PROGSATIVOS/Android/SdkFull")

(defun setup-android-environment ()
  "Set up Android development environment variables."
  (interactive)
  (let ((android-sdk-root _ANDROID_SDK_ROOT_))
    (setq process-environment
          (append (list (concat "ANDROID_HOME=" android-sdk-root)
                        (concat "ANDROID_SDK_ROOT=" android-sdk-root)
                        (concat "PATH=" android-sdk-root "tools:" android-sdk-root "platform-tools")))
                  process-environment)))
(setup-android-environment)


(defun fzl-adb-devices()
  "Run SQuirreL SQL Client and show the logs in a buffer."
(interactive)
 (shell-command (concat "ls " "-la")))

(global-set-key (kbd "C-c C-f C-a C-d") #'fzl-squirelsql-start)


(provide 'fzl-util-android-adb)
;;; this_file_name.el ends here
