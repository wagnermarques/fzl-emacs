;;; package --- summary
;;; Commentary:
;;; Code

(provide 'config_simple_httpd)

(setq httpd-root "./tests")
(require 'simple-httpd)

(require 'impatient-mode)

(httpd-start)

;;start impatient-mode when visit html files
(add-hook 'html-mode-hook #'impatient-mode)




