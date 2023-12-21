;;; package --- Summary

;;; Commentary:

;;; Code:
;; -*- coding: utf-8; lexical-binding: t; -*-


(defun fzl-docker-service-status ()
  "Run `systemctl status docker` and display the output in a dedicated buffer."
  (interactive)
  (let ((buffer-name "*fzl-status-docker-service*"))
    (with-output-to-temp-buffer buffer-name
      (shell-command "systemctl status docker" buffer-name))
    (with-current-buffer buffer-name
      (goto-char (point-min))
      (while (re-search-forward "[\200]" nil t)
        (replace-match "")))))

(defun fzl-docker-ps ()
  "Run `systemctl status docker` and display the output in a dedicated buffer."
  (interactive)
  (let ((buffer-name "*fzl-status-docker-ps*"))
    (with-output-to-temp-buffer buffer-name
      (shell-command "sudo docker ps -a " buffer-name))))

  
  

(global-set-key (kbd "C-c C-f C-d C-s") 'fzl-docker-service-status)
(global-set-key (kbd "C-c C-f C-d C-p") 'fzl-docker-ps)
(provide 'fzl-util-docker)
;;; this fzl-ides-eclipse.el
