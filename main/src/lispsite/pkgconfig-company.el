;; Configuração do Company Mode

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        company-idle-delay 0.0))  ; Ajuste o tempo de atraso conforme necessário


;; in another .el file
;; we (require 'pkgconfig-company) to run this file
;; and sets up specific language as below

;; Configuração para PHP
;;(use-package php-mode 
;;  :mode ("\\.php\\'" . php-mode)
;;  :config
;;  (add-hook 'php-mode-hook 'company-mode))
;;
;;;; Configuração para Java
;;(use-package lsp-java
;;  :config
;;  (add-hook 'java-mode-hook #'lsp))
;;

(provide 'pkgconfig-company)
