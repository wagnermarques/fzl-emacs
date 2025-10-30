;; Carregar o pacote `dired` usando use-package
(require 'ls-lisp)

(use-package dired
  :ensure nil  ;; Não instalar o pacote, pois `dired` já vem com o Emacs
  ;;:commands (dired dired-jump)  ;; Comandos que serão carregados sob demanda
  ;;:bind ((\C-x\C-j . dired-jump))  ;; Vincular C-x C-j ao comando `dired-jump`
  :config
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-use-ls-dired nil)
  (setq ls-lisp-use-insert-directory-program nil)
  (setq dired-listing-switches "-alh")
  ;; Configurações adicionais do dired
  (setq dired-dwim-target t)  ;; Ativar o comportamento "Do What I Mean" (DWIM)
  (setq dired-hide-dotfiles nil)  ;; Ocultar arquivos e diretórios iniciados por ponto
  (setq dired-auto-save-file-name "~/.emacs.d/.dired"))  ;; Definir nome do arquivo de auto-salvamento

(provide 'config-mode-dired)
