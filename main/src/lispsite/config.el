;;; config.el --- Central User Configuration and Preferences -*- lexical-binding: t -*-

;;; Commentary:
;; This file centralizes user-level policy and preferences across various packages.
;; Specific package loading and mechanics remain in `pkgconfig-*.el` and `coding-*.el`,
;; while user choices (paths, startup behaviors, UI settings) are defined here.

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Treemacs Workspace and Startup Configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Open Treemacs automatically when Emacs finishes loading (t or nil)
(defvar fzl/treemacs-open-on-startup t
  "Whether to open Treemacs automatically when Emacs starts.")

;; Treemacs workspace sync behavior:
;;   'add-and-resolve - Add configured projects, automatically resolving any conflicting nested subprojects
;;   'exact           - Set workspace to match `fzl/treemacs-workspace-projects' exactly
(defvar fzl/treemacs-workspace-sync-mode 'add-and-resolve
  "How to synchronize projects defined in `fzl/treemacs-workspace-projects'.")

;; List of directories/projects to ensure in the Treemacs workspace.
;; Each entry can be:
;;   - A cons cell: ("Project Name" . "/path/to/directory")
;;   - A simple path string: "/path/to/directory" (name will be derived from folder name)
(defvar fzl/treemacs-workspace-projects
  (delq nil
        (list
         ;; Primary Projects directory
         (when (boundp 'externaldisk_partition2)
           (let ((path (concat externaldisk_partition2 "/Projects-Srcs")))
             (when (file-directory-p path)
               (cons "Projects-Srcs" path))))

         ;; Current fzl-emacs configuration project
         (when (boundp 'fzlemacs-dir--fzlemacs-home)
           (when (file-directory-p fzlemacs-dir--fzlemacs-home)
             (cons "fzl-emacs" fzlemacs-dir--fzlemacs-home)))

         ;; Add more projects here as needed, for example:
         ;; (cons "MyProject" "/path/to/my/project")
         ))
  "List of projects to automatically register in the Treemacs workspace.")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Startup Views and Window Layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Choose startup view layout strategy:
;;   'ibuffer-and-dired  - Split window with ibuffer on top and dired below
;;   'theese-buffers     - Open predefined buffers (dot_env, Readme.org, init.el)
;;   nil                 - Keep default initial Emacs buffer
(defvar fzl/startup-view-strategy 'ibuffer-and-dired
  "Startup window layout strategy.")

;; Files to open automatically at startup (prior to view layout)
(defvar fzl/startup-files
  (delq nil
        (list
         (when (boundp 'fzlemacs-dir--fzlemacs-home)
           (let ((file (concat fzlemacs-dir--fzlemacs-home "/index.org")))
             (when (file-exists-p file) file)))
         (when (boundp 'fzlemacs-dir--fzlemacs-lispsite)
           (let ((file (concat fzlemacs-dir--fzlemacs-lispsite "/init.el")))
             (when (file-exists-p file) file)))))
  "List of files to open in buffers at Emacs startup.")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. UI, Theme and Typography
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Theme to load (e.g. 'doom-one, 'doom-dracula, 'doom-solarized-dark, etc.)
(defvar fzl/theme 'doom-one
  "Theme to load.")

;; Font configuration
(defvar fzl/font-family "FiraCode Nerd Font Mono"
  "Primary font family for Emacs buffer and icons fallback.")

(defvar fzl/font-height 120
  "Font size height (120 = 12pt).")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Optional Machine-Local Overrides
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; If a `config.local.el` file exists in the lispsite directory, load it
;; to allow machine-specific overrides (e.g. different mount paths on laptop).
(let ((local-config (and (boundp 'fzlemacs-dir--fzlemacs-lispsite)
                         (expand-file-name "config.local.el" fzlemacs-dir--fzlemacs-lispsite))))
  (when (and local-config (file-exists-p local-config))
    (load-file local-config)))

(provide 'config)
;;; config.el ends here
