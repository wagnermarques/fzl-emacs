(use-package treemacs
  :ensure t
  :config
  (setq treemacs-width 0.25) ; Set the initial width of the Treemacs window
  (setq treemacs-follow-mode t) ; Automatically follow the currently active file in the tree
  (setq treemacs-pane-relative-size 0.3) ; Set the relative size of the Treemacs pane
  (treemacs-load-theme "doom-atom") ; Load a Treemacs theme
  (global-set-key (kbd "C-x t") 'treemacs-toggle) ; Bind a key to toggle Treemacs visibility
  )

(provide 'pkgconfig-treemacs)
