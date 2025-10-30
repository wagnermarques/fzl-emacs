
;; Enable LaTeX preview in Org-mode
(setq org-latex-create-formula-image-program 'dvisvgm)
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-preview-latex-image-directory "./tmp/latex")
(setq org-startup-with-latex-preview t)


;; Use the 'dvisvgm' process for LaTeX preview
(setq org-preview-latex-default-process 'dvisvgm)

;; Enable LaTeX previews inline
(add-hook 'org-mode-hook 'org-display-inline-images)

;; Automatically start with LaTeX preview
(setq org-startup-with-latex-preview t)

;; Bind LaTeX preview to a custom key combination (optional)
(global-set-key (kbd "C-c C-x C-p") 'org-latex-preview)

;; Ensure Org-mode displays inline images
(add-hook 'org-mode-hook 'org-display-inline-images)

(provide 'config-mode-orgmode-for-latex)

