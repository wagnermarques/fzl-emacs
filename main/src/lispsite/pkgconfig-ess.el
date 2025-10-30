;; Install and configure ESS
(use-package ess
  :ensure t
  :init
  (require 'ess-site)
  :config
  ;; Set up some common ESS configurations
  (setq ess-ask-for-ess-directory nil)  ;; Don't ask for directory on startup
  (setq ess-history-directory "~/.Rhistory")  ;; Set history file location
  (setq ess-default-style 'RStudio)  ;; Use RStudio style for indentation
  (setq ess-eval-visibly 'nowait)  ;; Don't wait for R code to finish evaluating
  (setq ess-use-flymake nil)  ;; Disable flymake (syntax checking)
  
  ;; Keybindings for common ESS commands
  (define-key ess-mode-map (kbd "C-c C-r") 'ess-eval-region)
  (define-key ess-mode-map (kbd "C-c C-b") 'ess-eval-buffer)
  (define-key ess-mode-map (kbd "C-c C-n") 'ess-eval-line-and-step)
  (define-key ess-mode-map (kbd "C-c C-j") 'ess-eval-line)
  
  ;; Enable ESS for R files
  (add-to-list 'auto-mode-alist '("\\.R\\'" . R-mode))
  (add-to-list 'auto-mode-alist '("\\.r\\'" . R-mode))
  ;;(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))
)

;; Optional: Install and configure poly-markdown for R Markdown files
;;(use-package poly-markdown
;;  :ensure t
;;  :config
;;  (require 'poly-R)
;;  (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))
;;)

(provide 'pkgconfig-ess)
