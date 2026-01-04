;;; package --- Summary
;;; Code:
 
;;; Commentary:

(provide 'fzl_menus)

(require 'easymenu)
(require 'fzl-util-browser)


(easy-menu-define djcb-menu global-map "fzlbpms-menu"
  '("FZLBPMS"))

(setq fzl-menus-root-dir "/run/media/wgn/ext4/Projects-Srcs/fzlbpms")
(setq fzl-menus-angular-ui-dir
      (concat fzl-menus-root-dir "/src-projects/fzlbpmsadmin/angular-ui"))

(def fzlbpms-shell-command--npm-run-tauri-dev
  (concat "cd " fzl-menus-angular-ui-dir " && npm run tauri:dev"))

(def fzlbpms-menus--fzlbpmsadmin-start ()
  "Starts and open fzlbpmsadmin gui runnin npm run tauri:dev."
  (interactive)
  (fzlbpms-shell-command--npm-run-tauri-dev))


(provide 'fzlbpms-menus)
