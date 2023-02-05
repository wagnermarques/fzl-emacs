;;references
;;https://gist.github.com/mattss/31afc04b8c27b5c67469d9bcba6b48ea
;;https://gist.github.com/JohnL4/8e2ffb31aa371a2d9a74d5defa72587e
;;https://github.com/ananthakumaran/tide

;;; tide setup
;;; https://github.com/ananthakumaran/tide/blob/master/README.md
(provide 'tide_config)

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;;(company-mode)
  (company-mode +1))


;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


;;              (setq fill-column 120)
;;              (local-set-key "\C-j" 'newline)
;;              (local-set-key "\r" 'newline-and-indent) ;Auto-indent.
;;              (local-set-key "\M-o" 'one-line-section-break)
;;              (local-set-key (kbd "<f2> r") 'tide-rename-symbol)
;;              (local-set-key (kbd "S-<f12>") 'tide-references)


;; Note that the following don't work for me when set inside the mode hook.  Don't know why.
;;(setq typescript-indent-level 3)
;;(setq tide-format-options '(:placeOpenBraceOnNewLineForFunctions t :placeOpenBraceOnNewLineForControlBlocks t))
;;(setq company-tooltip-align-annotations t)


(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(setq tide-tsserver-process-environment '(concat("TSS_LOG=-level verbose -file",**tide-tsserver_LOG_FILE**,sep=" ")))
