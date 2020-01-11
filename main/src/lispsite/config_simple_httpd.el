;;; package --- summary
;;; Commentary:
;;; Code:
(provide 'config_simple_httpd)

(setq httpd-root "/home/wagner/wagnerdocri@gmail.com3/envs/env-dev/sources/somewritings/")
(require 'simple-httpd)

(require 'impatient-mode)
(setq httpd-port 9191)
(httpd-start)

;;start impatient-mode when visit html files
(add-hook 'html-mode-hook #'impatient-mode)
