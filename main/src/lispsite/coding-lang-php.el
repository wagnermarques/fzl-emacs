(setq phpDebugJs "/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/vscode-plugins/vscode-php-debug/out/phpDebug.js")

;; Configuração do lsp-mode com PHP
(use-package lsp-mode
  :ensure t
  :hook (php-mode . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)  ; Use Flycheck em vez de Flymake
  ;; Utilize company-capf como backend do company-mode para lsp-mode
  (add-to-list 'company-backends 'company-capf))

(use-package dap-mode
  :ensure t
  :after (lsp-mode dap-mode)
  :config 
  (dap-auto-configure-mode)
  ;; PHP debug template
  (require 'dap-php)

(dap-register-debug-template "PHP Xdebug"
  (list :type "php"
        :request "launch"
        :name "Xdebug::Run"
        :cwd "/media/wgn/EnvsBk/__devenv__/__devenv__eteczl/catracas-secretaria-yii2"
        :program nil
        :port 9003
        :log t
        :dap-server-log t
        :dap-server-path '("node" "/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/vscode-plugins/vscode-php-debug/out/phpDebug.js")))
  

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Configuração do PHP Mode
(use-package php-mode
  :ensure t
  :mode "\\.php\\'"
  :hook (php-mode . lsp))

;; Install and configure dap-mode

  ;; Enable logging
  (setq dap-print-io t)  ; Enable printing of debug I/O to the *Messages* buffer
  (setq dap-output-buffer-filter nil)  ; Disable output buffer filtering
  (setq dap-output-buffer-compilation-mode t)  ; Enable compilation mode for output buffer

  ;; To show logs in a separate buffer, you can use dap-output-buffer
  (defun my/dap-mode-setup ()
    (dap-ui-mode 1)
    (add-hook 'dap-stopped-hook
              (lambda (arg) (call-interactively #'dap-hydra)))
    ;; Additional logging for debug session lifecycle
    (add-hook 'dap-session-created-hook
              (lambda (session) (message "Dap session created: %s" session)))
    (add-hook 'dap-session-terminated-hook
              (lambda (session) (message "Dap session terminated: %s" session)))
    (add-hook 'dap-terminated-hook
              (lambda (_session) (message "Dap terminated"))))

  (add-hook 'dap-mode-hook 'my/dap-mode-setup))

;; Custom function to refresh breakpoints with error handling
(defun refresh-breakpoints-safe (&rest args)
  (ignore-errors
    (apply 'dap--refresh-breakpoints args)))

(advice-add 'dap--refresh-breakpoints :around #'refresh-breakpoints-safe)

(provide 'coding-lang-php)
