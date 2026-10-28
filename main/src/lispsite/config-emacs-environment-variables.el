(print "===> config-emacs-environment-variables running...")

(setq externaldisk_partition1 "/run/media/wgn/ntfs") ;;where lives my files in general
(setq externaldisk_partition2
      (cond ((file-directory-p "/home/wgn/WORKING") "/home/wgn/WORKING")
            ((file-directory-p "/home/wgn/mnt/ext4") "/home/wgn/mnt/ext4")
            (t (expand-file-name "~/WORKING")))) ;;where lives my desktop softwares


(setq dir_shared_files (concat externaldisk_partition2 "/SHARED_FILES"))
(setq progsativos (concat externaldisk_partition2 "/progsativos"))

(setq fzlemacs-dir--fzlemacs-home
      (or (let* ((this-file (or load-file-name buffer-file-name (locate-library "config-emacs-environment-variables")))
                 (dir (and this-file (file-name-directory this-file))))
            (and dir (file-exists-p (expand-file-name "../../.." dir))
                 (file-truename (expand-file-name "../../.." dir))))
          (let ((dom (locate-dominating-file default-directory "main/src/lispsite")))
            (and dom (file-truename dom)))
          (and (boundp 'externaldisk_partition2)
               (file-directory-p (concat externaldisk_partition2 "/Projects-Srcs/Projects-Srcs-Desktop/fzl-emacs"))
               (concat externaldisk_partition2 "/Projects-Srcs/Projects-Srcs-Desktop/fzl-emacs"))
          (file-truename default-directory)))
(setq fzlemacs-dir--fzlemacs-lispsite (concat fzlemacs-dir--fzlemacs-home "/main/src/lispsite"))

(defun fzl/find-projects-root ()
  "Dynamically discover the root Projects-Srcs directory relative to init.el."
  (or ;; 1. Directly relative to init.el (5 levels up from main/src/lispsite)
      (let* ((init-file (or (locate-library "init.el")
                            (and (boundp 'fzlemacs-dir--fzlemacs-lispsite)
                                 (expand-file-name "init.el" fzlemacs-dir--fzlemacs-lispsite))))
             (init-dir (and init-file (file-name-directory (file-truename init-file))))
             (candidate (and init-dir (expand-file-name "../../../../.." init-dir))))
        (and candidate
             (file-directory-p candidate)
             (string-equal (file-name-nondirectory (directory-file-name candidate)) "Projects-Srcs")
             (file-truename candidate)))
      ;; 2. Relative to fzlemacs-dir--fzlemacs-home (2 levels up)
      (and (bound-and-true-p fzlemacs-dir--fzlemacs-home)
           (let ((candidate (expand-file-name "../.." fzlemacs-dir--fzlemacs-home)))
             (and (file-directory-p candidate)
                  (string-equal (file-name-nondirectory (directory-file-name candidate)) "Projects-Srcs")
                  (file-truename candidate))))
      ;; 3. Environment variable override
      (and (getenv "PROJECTS_SRCS_DIR")
           (file-directory-p (getenv "PROJECTS_SRCS_DIR"))
           (file-truename (getenv "PROJECTS_SRCS_DIR")))
      ;; 4. Check externaldisk_partition2 if configured and directory exists
      (and (bound-and-true-p externaldisk_partition2)
           (let ((candidate (concat externaldisk_partition2 "/Projects-Srcs")))
             (and (file-directory-p candidate) (file-truename candidate))))
      nil))


;;; coding lang dirs
;;; coding lang dirs for java
(setq fzlemacs-dir--java-jdk-home (concat progsativos "/javasdks/temurim/jdk-21.0.8+9"))


;; Environment Variables Configuration
(setq fzlemacs-init-show-environment-variables t
      
      fzlemacs-key-show-window-message-buffer-at-bottom "C-c m"
      fzlemacs-key-show-window-speedbar-at-left "C-b"
      fzlemacs-key-copilot-chat-display-keybinding "C-c c c"
      
      fzlemacs-text-zoom-initial 130
      fzlemacs-dir-bibnotes-home "/home/wgn/mnt/ext4/Researching-bibtex-manager-data"
      ;?fzlemacs-bibliography-notes "/media/wgn/EnvsBk/__devenv__/Amb_Dev/projects/text_projects/bibtexfiles"
      fzlemacs-personal-config-dired-at-financial-dir-keybinding "C-c C-w f"

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
