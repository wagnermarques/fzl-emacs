(require 'org)
(require 'ess)

;; Enable Babel support for R
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))

;; Optional: Do not prompt before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

;; Optional: Display images inline after executing code blocks
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; Optional: Set default R session
(setq org-babel-R-command "R --slave --no-save")

;; Optional: Enable syntax highlighting in source blocks
(setq org-src-fontify-natively t)

;; Use ESS for R code blocks in Org-mode
(setq org-babel-R-eval-with-ess t)

;; Optional: Automatically start an R session when opening an R code block
(add-hook 'org-mode-hook
          (lambda ()
            (when (and buffer-file-name
                       (string= (file-name-extension buffer-file-name) "org"))
              (ess-set-style 'RStudio))))

;; Optional: Keybinding to send code block to ESS R session
(defun my-org-babel-execute-src-block ()
  (interactive)
  (let ((org-babel-noweb-wrap-start "<<noweb-wrap>>")
        (org-babel-noweb-wrap-end "<<noweb-wrap>>"))
    (org-babel-execute-src-block)))

(define-key org-mode-map (kbd "C-c C-v") 'my-org-babel-execute-src-block)

(provide 'config-mode-orgmode-babel-R)
