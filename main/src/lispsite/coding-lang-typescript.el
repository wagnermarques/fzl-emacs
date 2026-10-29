;;; coding-lang-typescript.el --- TypeScript development -*- lexical-binding: t -*-

;; tide for TypeScript development
(use-package tide
  :after (typescript-mode company flycheck)
  :hook (
         (typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(provide 'coding-lang-typescript)
;;; coding-lang-typescript.el ends here
