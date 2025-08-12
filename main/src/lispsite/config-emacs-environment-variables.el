(print "===> config-emacs-environment-variables running...")

(setq externaldisk_partition1 "/run/media/wgn/ntfs") ;;where lives my files in general
(setq externaldisk_partition2 "/run/media/wgn/libvirt_ext4") ;;where lives my desktop sofwares
(setq externaldisk_partition3 "/run/media/wgn/ext4") ;;whe lives my programmin projects

(setq dir_shared_files (concat externaldisk_partition3 "/SHARED_FILES"))
(setq progsativos (concat externaldisk_partition2 "/progsativos"))

(setq fzlemacs-dir--fzlemacs-home (concat externaldisk_partition2 "/Projects-Srcs-Desktop/fzl-emacs"))
(setq fzlemacs-dir--fzlemacs-lispsite (concat fzlemacs-dir--fzlemacs-home "/main/src/lispsite"))


;;; coding lang dirs
;;; coding lang dirs for java
(setq fzlemacs-dir--java-jdk-home (concat progsativos "/javasdks/temurim/jdk-21.0.8+9"))


;; Environment Variables Configuration
(setq fzlemacs-init-show-environment-variables t
      
      fzlemacs-key-show-window-message-buffer-at-bottom "C-c m"
      fzlemacs-key-show-window-speedbar-at-left "C-b"
      fzlemacs-key-copilot-chat-display-keybinding "C-c c c"
      
      fzlemacs-text-zoom-initial 130
      fzlemacs-dir-bibnotes-home (concat dir_shared_files "/bibtexfiles")
      ;?fzlemacs-bibliography-notes "/media/wgn/EnvsBk/__devenv__/Amb_Dev/projects/text_projects/bibtexfiles"
      fzlemacs-personal-config-dired-at-financial-dir-keybinding "C-c C-w f"
      fzlemacs-personal-config-dired-at-financial-dir-dirpath "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/WgnFin"

      ;;https://repo.languagetool.org/ui/native/languagetool-os-release/org/languagetool/languagetool-core
      fzlemacs-integration-languagetool-commandline-jar (concat progsativos "/LanguageTool/LanguageTool-stable/LanguageTool-6.6/languagetool-commandline.jar"))


;;;; setting up emacs automatic file editing backups ;;;;
;;;; Define backup directory path (relative to home)
(setq emacs-backup-directory (expand-file-name "diretoriodebackups/arquivoseditadosnoemacs" (getenv "HOME")))


;; Create directory if it doesn't exist
(unless (file-exists-p emacs-backup-directory)
  (make-directory emacs-backup-directory t)  ; 't' creates parent dirs if needed
  (message "Created backup directory: %s" emacs-backup-directory))

;; Configure Emacs to use this directory for backups
(setq backup-directory-alist `(("." . ,emacs-backup-directory)))
(setq auto-save-file-name-transforms `((".*" ,emacs-backup-directory t)))


(provide 'config-emacs-environment-variables) 
