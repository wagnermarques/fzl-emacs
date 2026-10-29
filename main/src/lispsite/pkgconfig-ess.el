;;; pkgconfig-ess.el --- ESS configuration for R -*- lexical-binding: t -*-

(use-package ess
  :ensure t
  :defer t
  :mode (("\\.R\\'" . R-mode)
         ("\\.r\\'" . R-mode))
  :config
  ;; Set up some common ESS configurations
  (setq ess-ask-for-ess-directory nil)  ;; Don't ask for directory on startup
  (setq ess-history-directory "~/.Rhistory")  ;; Set history file location
  (setq ess-default-style 'RStudio)  ;; Use RStudio style for indentation
  (setq ess-eval-visibly 'nowait)  ;; Don't wait for R code to finish evaluating
  (setq ess-use-flymake nil)  ;; Disable flymake (syntax checking)
  
  ;; Keybindings for common ESS commands
  (with-eval-after-load 'ess-mode
    (define-key ess-mode-map (kbd "C-c C-r") 'ess-eval-region)
    (define-key ess-mode-map (kbd "C-c C-b") 'ess-eval-buffer)
    (define-key ess-mode-map (kbd "C-c C-n") 'ess-eval-line-and-step)
    (define-key ess-mode-map (kbd "C-c C-j") 'ess-eval-line)))

(provide 'pkgconfig-ess)
