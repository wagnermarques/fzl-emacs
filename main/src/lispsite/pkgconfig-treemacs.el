;;; pkgconfig-treemacs.el --- Treemacs and Projectile Integration -*- lexical-binding: t -*-

;;; Commentary:
;; Treemacs is a file and project explorer for Emacs.
;; Integrated with Projectile for project-aware workspace browsing and Magit for Git status.

;;; Code:

;; Workspace projects and startup configuration
(defvar fzl/treemacs-open-on-startup nil
  "Whether to open Treemacs automatically at startup.")

(defvar fzl/treemacs-workspace-projects nil
  "List of projects (either (name . path) pairs or path strings) to ensure in Treemacs workspace.")

(defvar fzl/treemacs-default-project-path
  (if (boundp 'externaldisk_partition2)
      (concat externaldisk_partition2 "/Projects-Srcs")
    "/home/wgn/mnt/ext4/Projects-Srcs")
  "Default project directory fallback for Treemacs workspace.")

(defvar fzl/treemacs-default-project-name "Projects-Srcs"
  "Default project name fallback for Treemacs workspace.")

(defvar fzl/treemacs--syncing nil
  "Re-entrancy guard to prevent recursion during Treemacs workspace sync.")

(defvar fzl/treemacs-workspace-sync-mode 'add-and-resolve
  "How to synchronize projects defined in `fzl/treemacs-workspace-projects'.
- 'add-and-resolve: Add configured projects and remove any conflicting nested subprojects.
- 'exact: Set the workspace to match `fzl/treemacs-workspace-projects' exactly.")

(defun fzl/treemacs-sync-workspace-projects (&optional no-rerender)
  "Ensure all projects defined in `fzl/treemacs-workspace-projects' exist in Treemacs workspace.
When NO-RERENDER is non-nil, do not trigger a window/buffer rerender."
  (interactive)
  (unless fzl/treemacs--syncing
    (let ((fzl/treemacs--syncing t))
      (when (fboundp 'treemacs-current-workspace)
        (let ((ws (treemacs-current-workspace)))
          (when ws
            (let* ((targets (if (and (null fzl/treemacs-workspace-projects)
                                     (boundp 'fzl/treemacs-default-project-path)
                                     fzl/treemacs-default-project-path)
                                (list (cons (or (and (boundp 'fzl/treemacs-default-project-name)
                                                     fzl/treemacs-default-project-name)
                                                "Projects-Srcs")
                                            fzl/treemacs-default-project-path))
                              fzl/treemacs-workspace-projects))
                   (changed nil))
              (when (eq (and (boundp 'fzl/treemacs-workspace-sync-mode)
                             fzl/treemacs-workspace-sync-mode)
                        'exact)
                (setf (treemacs-workspace->projects ws) nil)
                (setq changed t))
              (dolist (item targets)
                (let* ((name (if (consp item) (car item) (file-name-nondirectory (directory-file-name item))))
                       (raw-path (if (consp item) (cdr item) item))
                       (path (and raw-path (expand-file-name raw-path))))
                  (when (and path (file-directory-p path))
                    (let ((adding t)
                          (attempts 0)
                          (max-attempts 50))
                      (while (and adding (< attempts max-attempts))
                        (setq attempts (1+ attempts))
                        (let ((res (treemacs-do-add-project-to-workspace path name)))
                          (pcase res
                            (`(success . ,_)
                             (setq changed t
                                   adding nil))
                            (`(includes-project ,nested-child)
                             ;; The configured project contains an existing child project.
                             ;; Remove child to allow parent to be added.
                             (treemacs--remove-project-from-current-workspace nested-child)
                             (setq changed t))
                            (`(duplicate-project . ,_)
                             (setq adding nil))
                            (`(duplicate-name . ,_)
                             (setq adding nil))
                            (_
                             (setq adding nil)))))))))
              (when changed
                (treemacs--persist)
                (when (and (not no-rerender)
                           (fboundp 'treemacs-current-visibility)
                           (eq (treemacs-current-visibility) 'visible))
                  (treemacs--rerender-after-workspace-change))))))))))

(defun fzl/treemacs-reset-workspace-projects ()
  "Clear current workspace and re-add all projects defined in `fzl/treemacs-workspace-projects'."
  (interactive)
  (require 'treemacs)
  (let ((ws (treemacs-current-workspace)))
    (when ws
      (setf (treemacs-workspace->projects ws) nil)
      (fzl/treemacs-sync-workspace-projects t)
      (treemacs--persist)
      (when (and (fboundp 'treemacs-current-visibility)
                 (eq (treemacs-current-visibility) 'visible))
        (treemacs--rerender-after-workspace-change))
      (message "Treemacs workspace reset to configured projects."))))

(defun fzl/treemacs-open ()
  "Ensure Treemacs window is open and visible without toggling it off."
  (interactive)
  (require 'treemacs)
  (let ((origin (selected-window)))
    (fzl/treemacs-sync-workspace-projects t)
    (unless (eq (treemacs-current-visibility) 'visible)
      (treemacs))
    (when (window-live-p origin)
      (select-window origin))))

(defun fzl/treemacs-set-default-project (&optional path name)
  "Set PATH (default `fzl/treemacs-default-project-path') as the project in Treemacs workspace."
  (interactive)
  (require 'treemacs)
  (let ((proj-path (or path fzl/treemacs-default-project-path))
        (proj-name (or name fzl/treemacs-default-project-name)))
    (when (file-directory-p proj-path)
      (let ((ws (treemacs-current-workspace)))
        (when ws
          (setf (treemacs-workspace->projects ws) nil)
          (treemacs-do-add-project-to-workspace proj-path proj-name)
          (treemacs--rerender-after-workspace-change)
          (treemacs--persist)
          (message "Treemacs workspace set to default project: %s" proj-path))))))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
        treemacs-deferred-git-apply-delay        0.5
        treemacs-directory-name-transformer      #'identity
        treemacs-display-in-side-window          t
        treemacs-eldoc-display                   'simple
        treemacs-file-event-delay                2000
        treemacs-file-extension-regex            treemacs-last-period-regex-value
        treemacs-file-follow-delay               0.2
        treemacs-follow-after-init               t
        treemacs-expand-after-init               t
        treemacs-find-workspace-method           'find-for-file-or-pick-first
        treemacs-git-integration                 t
        treemacs-header-scroll-indicators        '(nil . "^^^^^^")
        treemacs-hide-dot-git-directory          t
        treemacs-indentation                     2
        treemacs-indentation-string              " "
        treemacs-is-never-other-window           nil
        treemacs-max-git-entries                 5000
        treemacs-missing-project-action          'ask
        treemacs-move-files-by-mouse-dragging    t
        treemacs-move-forward-on-expand          nil
        treemacs-no-png-images                   nil
        treemacs-no-delete-other-windows         t
        treemacs-project-follow-cleanup          nil
        treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-position                        'left
        treemacs-read-string-input               'from-child-frame
        treemacs-recenter-distance               0.1
        treemacs-recenter-after-file-follow      nil
        treemacs-recenter-after-tag-follow       nil
        treemacs-recenter-after-project-jump     'always
        treemacs-recenter-after-project-expand   'on-distance
        treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask" "/target" "/dist")
        treemacs-project-follow-into-home        nil
        treemacs-show-cursor                     nil
        treemacs-show-hidden-files               t
        treemacs-silent-file-watch               nil
        treemacs-silent-refresh                  nil
        treemacs-sorting                         'alphabetic-asc
        treemacs-select-when-already-in-treemacs 'move-back
        treemacs-space-between-root-nodes        t
        treemacs-tag-follow-cleanup              t
        treemacs-tag-follow-delay                1.5
        treemacs-text-scale                      nil
        treemacs-user-mode-line-format           nil
        treemacs-user-header-line-format         nil
        treemacs-wide-toggle-width               70
        treemacs-width                           35
        treemacs-width-is-initially-locked       t
        treemacs-workspace-switch-cleanup        nil)

  ;; Enable follow mode and filewatch mode by default
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)

  ;; Git integration
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))

  ;; Theme loading fallback
  (ignore-errors (treemacs-load-theme "doom-atom"))

  ;; Ensure projects are synced when treemacs buffer initializes (without recursive rerender)
  (add-hook 'treemacs-post-buffer-init-hook (lambda () (fzl/treemacs-sync-workspace-projects t)))

  :bind
  (:map global-map
        ("C-c t"       . treemacs)
        ("C-c T"       . treemacs-select-window)
        ("M-0"         . treemacs-select-window)
        ("C-x t 1"     . treemacs-delete-other-windows)
        ("C-x t t"     . treemacs)
        ("C-x t d"     . treemacs-select-directory)
        ("C-x t B"     . treemacs-bookmark)
        ("C-x t C-t"   . treemacs-find-file)
        ("C-x t M-t"   . treemacs-find-tag)))

;; Treemacs + Projectile integration
(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :bind
  (:map projectile-command-map
        ("h" . treemacs-projectile)                   ; C-c p h : Add/select project in treemacs
        ("T" . treemacs-add-and-display-current-project))) ; C-c p T : Show current project in treemacs

;; Treemacs + Magit integration
(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

;; Treemacs + All The Icons support
(use-package treemacs-all-the-icons
  :ensure t
  :after (treemacs all-the-icons)
  :config
  (treemacs-load-theme "all-the-icons"))

;; Startup hook to open treemacs if configured
(add-hook 'emacs-startup-hook
          (lambda ()
            (when (and (boundp 'fzl/treemacs-open-on-startup)
                       fzl/treemacs-open-on-startup)
              (fzl/treemacs-open)))
          95)

(provide 'pkgconfig-treemacs)
;;; pkgconfig-treemacs.el ends here
