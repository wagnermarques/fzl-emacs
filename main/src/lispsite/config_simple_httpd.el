;;; package --- summary
;;; Commentary:
;;; Code:


(setq httpd-root **config_simple_httpd_root**)
(require 'simple-httpd)

(require 'impatient-mode)
(setq httpd-port 3210)
(httpd-start)

;;start impatient-mode when visit html files
(add-hook 'html-mode-hook #'impatient-mode)


(provide 'config_simple_httpd)
