;;; package --- Summary

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

(setq _NETBEANS_JAVA_HOME_ (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-ides/netbeans-18-bin/netbeans/bin"))

(defun fzl-netbeans-start ()
  "Start Netbeans Java IDE and display logs in a dedicated buffer."
  (interactive)
  (let* ((netbeans-path (concat _NETBEANS_JAVA_HOME_ "/netbeans"))
         (buffer-name "*Netbeans Java Logs*")
         (default-directory (file-name-directory netbeans-path))
         (process-buffer (get-buffer-create buffer-name)))
    (with-current-buffer process-buffer
      (setq buffer-read-only t))
    (display-buffer process-buffer)
    (start-process "netbeans" process-buffer netbeans-path)
    (message "Netbeans Java IDE started. Logs are displayed in buffer '%s'." buffer-name)))

(provide 'fzl-ides-netbeans)
;;; this fzl-ides-netbeans.el
