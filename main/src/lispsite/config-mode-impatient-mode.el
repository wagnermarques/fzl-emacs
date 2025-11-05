;; ==============================================================================
;; 1. Garantir que os pacotes estejam instalados
;; ==============================================================================

;; Garante que o servidor esteja instalado e define a porta
(use-package simple-httpd
  :ensure t
  :init
  ;; Define a porta do servidor AQUI
  (setq httpd-port 8898))

;; Apenas garante que o impatient-mode esteja instalado
(use-package impatient-mode
  :ensure t
  :after simple-httpd)

;; Garante que o 'browse-url' (usado internamente pelo impatient-mode) esteja instalado
(use-package browse-url
  :ensure t)

;; ==============================================================================
;; 2. Definições de Funções (Fora do use-package)
;; ==============================================================================

;; Função para iniciar o servidor, se não estiver rodando.
(defun fzl-start-httpd-if-needed ()
  "Starts the simple-httpd server if it is not already running."
  ;; Força o carregamento do 'simple-httpd' ANTES de usar suas funções
  (require 'simple-httpd)
  (unless (bound-and-true-p httpd-server-process)
    (message "Starting Impatient Mode HTTP Server on port %s..." httpd-port)
    (httpd-start)))

;; Função principal que será chamada pelo hook
(defun fzl-impatient-mode-init-and-open ()
  "Starts httpd, enables impatient-mode, and opens the URL."
  (interactive)
  
  ;; Força o carregamento dos pacotes ANTES de chamar suas funções
  (require 'impatient-mode)
  (require 'browse-url)

  ;; 1. Inicia o servidor
  (fzl-start-httpd-if-needed)
  
  ;; 2. Ativa o modo
  (impatient-mode 1)
  
  ;; 3. Abre o navegador (AGORA COM A FUNÇÃO CORRETA)
  ;; 'imp-visit-buffer' é o comando interativo do impatient-mode para isso.
  (imp-visit-buffer))

;; ==============================================================================
;; 3. Adicionar o Hook Manualmente
;; ==============================================================================

;; Adiciona o hook globalmente, agora que a função está definida
(add-hook 'html-mode-hook 'fzl-impatient-mode-init-and-open)

(provide 'config-mode-impatient-mode)
