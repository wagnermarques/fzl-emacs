;;; pkgconfig-projectile.el --- Projectile configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Project navigation and management library for Emacs.
;; Provides quick file jumping, project search, and project root detection.

;;; Code:

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  ;; Integration with Helm completion system
  (setq projectile-completion-system 'helm)
  
  ;; Performance and indexing optimizations
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'alien)
  (setq projectile-sort-order 'recentf)
  (setq projectile-auto-discover t)
  
  ;; Action taken when switching projects (opens dired or projectile-find-file)
  (setq projectile-switch-project-action #'projectile-dired)
  
  ;; Project root markers
  (setq projectile-project-root-files
        '(".git" ".projectile" "package.json" "pom.xml" "composer.json" "Cargo.toml" "Makefile" "CMakeLists.txt"))
  
  ;; Directories to ignore globally
  (setq projectile-globally-ignored-directories
        (append '(".git" ".svn" "node_modules" "target" "dist" "build" ".venv" ".idea" ".vscode")
                projectile-globally-ignored-directories))
  
  ;; Files to ignore globally
  (setq projectile-globally-ignored-files
        (append '("*.pyc" "*.o" "*.class" "*.tar.gz" "*.zip" "*~")
                projectile-globally-ignored-files)))

;; Helm Projectile integration
(use-package helm-projectile
  :ensure t
  :after (helm projectile)
  :config
  (helm-projectile-on))

(provide 'pkgconfig-projectile)
;;; pkgconfig-projectile.el ends here
