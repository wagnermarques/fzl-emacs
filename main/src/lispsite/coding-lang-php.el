;; Certifique-se de ter o use-package configurado
;; Certifique-se de ter o use-package configurado
(require 'use-package)
(setq use-package-always-ensure t)

;; Configuração do Company Mode
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        company-idle-delay 0.0))  ; Ajuste o tempo de atraso conforme necessário

;; Configuração do lsp-mode com PHP
(use-package lsp-mode
  :ensure t
  :hook (php-mode . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)  ; Use Flycheck em vez de Flymake
  ;; Utilize company-capf como backend do company-mode para lsp-mode
  (add-to-list 'company-backends 'company-capf))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Configuração do PHP Mode
(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :hook (php-mode . lsp))

;; Install and configure dap-mode
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config (dap-auto-configure-mode)
  ;; PHP debug template
  (require 'dap-php)
  (dap-register-debug-template "PHP Xdebug"
                               (list :type "php"
                                     :request "launch"
                                     :name "Xdebug::Run"
                                     :program nil
                                     :cwd nil
                                     :port 9003)))

(provide 'coding-lang-php)
