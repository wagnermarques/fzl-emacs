;; Carregar o pacote `ibuffer` usando use-package
(use-package ibuffer
  :ensure t  ;; Instalar o pacote se ainda não estiver instalado
  :bind ("C-x C-b" . ibuffer)  ;; Vincular a tecla C-x C-b ao comando `ibuffer`
  :config
  ;; Ativar agrupamento de buffers por modo
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("Dired" (mode . dired-mode))  ;; Agrupar buffers do `dired`
           ("Emacs" (or  ;; Agrupar buffers internos do Emacs
                      (name . "^\\*scratch\\*$")
                      (name . "^\\*Messages\\*$")))
           ("Programming" (or  ;; Agrupar buffers de programação
                             (mode . python-mode)
                             (mode . emacs-lisp-mode)
                             (mode . c-mode)))
           ("Org" (mode . org-mode))  ;; Agrupar buffers do Org mode
           ("Magit" (name . "^\\*magit")))))  ;; Agrupar buffers do Magit
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default")))  ;; Ativar grupos salvos ao iniciar `ibuffer`

  ;; Configurações visuais
  (setq ibuffer-expert t)  ;; Evitar mensagens de confirmação desnecessárias
  (setq ibuffer-display-summary nil)  ;; Desativar resumo na linha de modo
  (setq ibuffer-show-empty-filter-groups nil)  ;; Não mostrar grupos vazios

  ;; Ordenar buffers por nome ao iniciar `ibuffer`
  (setq ibuffer-default-sorting-mode 'alphabetic))



(provide 'config-mode-ibuffer)
