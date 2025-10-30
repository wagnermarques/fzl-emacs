;; Install and configure Helm
(use-package helm
  :ensure t
  :init
  ;; Set up Helm key bindings
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  :config
  ;; Enable Helm mode
  (helm-mode 1)
  
  ;; Close Helm buffer after selection
  (setq helm-quit-if-no-candidate t)
  (setq helm-exit-idle-delay 0)
  
  ;; Additional Helm configurations
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-semantic-fuzzy-match t)
  (setq helm-imenu-fuzzy-match t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-apropos-fuzzy-match t)
  (setq helm-lisp-fuzzy-completion t)
  (setq helm-session-fuzzy-match t)
  (setq helm-etags-fuzzy-match t)
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 50)
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-ff-search-library-in-sexp t)
  (setq helm-scroll-amount 8)
  (setq helm-ff-file-name-history-use-recentf t)
  (setq helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1))

;; Optional: Install and configure Helm Projectile for project management
;; must be install projectile first
;;(use-package helm-projectile
;;  :ensure t
;;  :after (helm projectile)
;;  :config
;;  (helm-projectile-on))

(provide 'pkgconfig-helm)
