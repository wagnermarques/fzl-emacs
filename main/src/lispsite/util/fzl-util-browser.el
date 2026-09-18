;;; fzl-util-browser.el --- Browser utilities and default browser configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Configures the default web browser (Chromium Browser) and provides URL opening helpers.

;;; Code:

(require 'browse-url)

;; Configure Chromium Browser as the default browser for Emacs
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program (or (executable-find "chromium-browser")
                                     (executable-find "chromium")
                                     "chromium-browser"))

(defun fzl-open-url-in-browser (url)
  "Open the specified URL in Chromium Browser."
  (interactive "sEnter URL: ")
  (browse-url url))

(provide 'fzl-util-browser)
;;; fzl-util-browser.el ends here
