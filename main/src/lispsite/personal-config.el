;; open dired at specific directory
;;; Code:
(setq keybindingDiredAtFinancialDir (getenv "FZLEMACS_PERSONAL_CONFIG__DIRED_AT_FINANCIAL_DIR__KEYBINDING"))
(setq personalFinancialDirPath      (getenv "FZLEMACS_PERSONAL_CONFIG__DIRED_AT_FINANCIAL_DIR__DIRPATH"))


(defun fzl/personal/openDiredAtFinancialDir ()
  (interactive)
  (dired personalFinancialDirPath))

(global-set-key (kbd keybindingDiredAtFinancialDir) 'fzl/personal/openDiredAtFinancialDir)

(provide 'personal-config)
