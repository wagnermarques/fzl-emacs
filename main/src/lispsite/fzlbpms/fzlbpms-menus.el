;;; fzlbpms-menus.el --- FZLBPMS Menus -*- lexical-binding: t -*-
;;; Code:
 
;;; Commentary:

(provide 'fzl_menus)

(require 'easymenu)
(require 'fzl-util-browser)


(easy-menu-define djcb-menu global-map "fzlbpms-menu"
  '("FZLBPMS"))

(setq fzl-menus-root-dir
      (or (bound-and-true-p fzlbpms-root-dir)
          (and (bound-and-true-p externaldisk_partition2)
               (concat externaldisk_partition2 "/fzlbpms"))
          (expand-file-name "~/WORKING/fzlbpms")))
(setq fzl-menus-angular-ui-dir
      (concat fzl-menus-root-dir "/src-projects/fzlbpmsadmin/angular-ui"))

(defvar fzlbpms-shell-command--npm-run-tauri-dev
  (concat "cd " fzl-menus-angular-ui-dir " && npm run tauri:dev"))

(defun fzlbpms-menus--fzlbpmsadmin-start ()
  "Starts and open fzlbpmsadmin gui runnin npm run tauri:dev."
  (interactive)
  (fzlbpms-shell-command--npm-run-tauri-dev))


(provide 'fzlbpms-menus)
