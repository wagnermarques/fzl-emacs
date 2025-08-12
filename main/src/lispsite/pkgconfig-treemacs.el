;;; pkgconfig-treemacs.el
(use-package treemacs
  :ensure t
  :config
  ;; All your settings go here
  (setq treemacs-width 35) ; A fixed width is often more stable
  (setq treemacs-follow-mode t)
  (setq treemacs-file-follow-delay 0.2)
  
  ;; This is handled by doom-themes, but is good to know
  (treemacs-load-theme "doom-atom")
  
  :bind
  ;; It's good practice to define keys inside :bind
  (("C-c t" . treemacs-toggle)))

(provide 'pkgconfig-treemacs)


(set-face-attribute 'default nil :font "FiraCode Nerd Font-12")

(provide 'pkgconfig-treemacs)
