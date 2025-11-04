;; fzlbpms.el --- FZL Business Process Management System -*- lexical-binding: t; -*-
;;; Commentary:
;; This file serves as the main entry point for the FZL Business Process Management System ()
;; to work smoothly in your linux machine:
;; install docker
;; install psql client
;; install mysql client
;;; Code:

(setq fzlbpms-root-dir "/run/media/wgn/ext4/Projects-Srcs/fzlbpms")

(require 'fzlbpms-menus)
(require 'fzlbpms-db-connections);
(require 'fzlbpms-routes)
(require 'fzlbpms-containers)

(provide 'fzlbpms);
