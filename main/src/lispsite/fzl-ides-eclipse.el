;;; package --- Summary

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-

(setq _ECLIPSE_JAVA_HOME_ (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-ides/eclipse-java-2023-06-R-linux-gtk-x86_64/eclipse"))
(setq _ECLIPSE_MODELING_HOME_ (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-ides/eclipse-modeling-2023-06-R-linux-gtk-x86_64/eclipse"))

(defun fzl-eclipse-java-start ()
  "Start Eclipse Java IDE and display logs in a dedicated buffer."
  (interactive)
  (let* ((eclipse-path (concat _ECLIPSE_JAVA_HOME_ "/eclipse"))
         (buffer-name "*Eclipse Java Logs*")
         (default-directory (file-name-directory eclipse-path))
         (process-buffer (get-buffer-create buffer-name)))
    (with-current-buffer process-buffer
      (setq buffer-read-only t))
    (display-buffer process-buffer)
    (start-process "eclipse" process-buffer eclipse-path)
    (message "Eclipse Java IDE started. Logs are displayed in buffer '%s'." buffer-name)))

(defun fzl-eclipse-modeling-start ()
  "Start Eclipse Java IDE and display logs in a dedicated buffer."
  (interactive)
  (let* ((eclipse-path (concat _ECLIPSE_MODELING_HOME_ "/eclipse"))
         (buffer-name "*Eclipse Java Logs*")
         (default-directory (file-name-directory eclipse-path))
         (process-buffer (get-buffer-create buffer-name)))
    (with-current-buffer process-buffer
      (setq buffer-read-only t))
    (display-buffer process-buffer)
    (start-process "eclipse" process-buffer eclipse-path)
    (message "Eclipse Java IDE started. Logs are displayed in buffer '%s'." buffer-name)))


(provide 'fzl-ides-eclipse)
;;; this fzl-ides-eclipse.el
