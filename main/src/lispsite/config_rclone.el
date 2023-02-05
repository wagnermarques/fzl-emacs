;;; package --- Summary

;;; Code:

;;; Commentary:

(defun rclone_sync_from_gdrive_to_desktop()
  "use rclone for rsync from gdrive. Note **GDriveLocalRootDir** dir must exists"
  (interactive)
  (let(
       (src (concat **rclone_remote_config_session**  ":/ ")) ;please leave this very last space because sync concat needs this
       (dest **GDriveLocalRootDir**))
    (message (concat "sync "  (concat src dest )))
    (start-process
     "ProcessName_RCloneSync-GdriveToDesktop"
     "BufferName___RCloneSync-GdriveToDesktop"
     "rclone "
     (concat "sync "  (concat src dest )))))

;;TODO
;;rclone_sync_from_desktop_to_gdrive

(provide 'config_rclone)
