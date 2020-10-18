;;P A T H S
;;(setq **auto-save-file-name-transforms-dir** (concat **EMACSINITFILE_HOME** "/var/auto-save/"))
;;(setq **backup-directory-alist-dir** (concat **EMACSINITFILE_HOME** "/var/backup"))
;;(shell-command (concat "mkdir -p "  **backup-directory-alist-dir**))

;;autosave and backaup dir
;;(setq auto-save-file-name-transforms '(
;;                                        (".*" (concat **EMACSINITFILE_HOME** "/var/auto-save") t )))

;;https://www.emacswiki.org/emacs/BackupDirectory
;;(setq
;;   backup-by-copying t      ; don't clobber symlinks
;;   backup-directory-alist
;;    '(("." .  **backup-directory-alist-dir**))
;;   delete-old-versions t
;;   kept-new-versions 2
;;   kept-old-versions 1
;;   version-control nil)

;(setq tramp-backup-directory-alist '((".*"  "../../../var/backup")))


;; Put backup files neatly away                                                 
(let ((backup-dir (concat **EMACSINITFILE_HOME** "/var/backup"))
      (auto-saves-dir (concat **EMACSINITFILE_HOME** "/var/backup")))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
        tramp-backup-directory-alist `((".*" . ,backup-dir))
        tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks                           
      delete-old-versions t  ; Clean up the backups                             
      version-control t      ; Use version numbers on backups,                  
      kept-new-versions 5    ; keep some new versions                           
      kept-old-versions 2)   ; and some old ones, too      


(provide 'config_backup)
