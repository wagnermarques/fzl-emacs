;;; package --- Summary

;;; Commentary:

;;; Code:


(require 'rtags)

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

(provide 'rtags_config)
;;; rtags_config.el ends here

