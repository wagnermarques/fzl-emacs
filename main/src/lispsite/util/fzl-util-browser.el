;;; fzl-util-browser.el --- Browser utilities and default browser configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Configures the default web browser (Brave Browser) and provides URL opening helpers.

;;; Code:

(require 'browse-url)

;; Configure Brave Browser as the default browser for Emacs
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program (or (executable-find "brave-browser")
                                     (executable-find "brave")
                                     "brave-browser"))

(defun fzl-open-url-in-browser (url)
  "Open the specified URL in Brave Browser."
  (interactive "sEnter URL: ")
  (browse-url url))

(provide 'fzl-util-browser)
;;; fzl-util-browser.el ends here
