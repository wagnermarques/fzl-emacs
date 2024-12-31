;; Certifique-se de ter o use-package configurado
(require 'use-package)
(setq use-package-always-ensure t)

;; Configuração do company-mode
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        company-idle-delay 0.0))  ; Ajuste o tempo de atraso conforme necessário
(add-hook 'sh-mode-hook 'company-mode)

;; Configuração do flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'sh-mode-hook 'flycheck-mode)

;; Configuração do eshell
(use-package eshell
  :ensure t
  :config
  (add-hook 'eshell-mode-hook 'eshell-cd))

;; Configuração do comint-mode (integrado ao Emacs)
(require 'comint)

;; Configuração opcional do fzf para busca aprimorada de comandos de shell
(use-package fzf
  :ensure t
  :config
  (add-hook 'eshell-mode-hook 'fzf-eshell-mode))

;; Habilitar sh-mode para arquivos de script de shell
(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(provide 'coding-lang-shellscript)
