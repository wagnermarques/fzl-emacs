;;; package --- Summary

;;; Commentary:
;;https://magit.vc/manual/magit/Performance.html#Performance

;;Magit also reverts buffers for visited files located inside the current repository when the visited file changes on disk. That is implemented on top of auto-revert-mode

;;; Code:

;;; Install Magit
(use-package magit
  :ensure t)

;;tell Magit to only automatically refresh the current Magit buffer, but not the status buffer.
;;then the status buffer is only refreshed automatically if it is the current buffer.
(setq magit-refresh-status-buffer nil)


;magit-refresh-buffer-hook, magit-status-refresh-hook, magit-pre-refresh-hook, and magit-post-refresh-hook.
(provide 'magit-config)
;;; magit_config.el ends here
