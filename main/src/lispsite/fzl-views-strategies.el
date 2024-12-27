
;;cada funcao formata a tela do emacs com uma estrategia especifica de visualizacao

(defun fzl/view/open-this-buffers()  
  (let ((buffer-names '("dot_env" "Readme.org" "init.el")))
      (dolist (buffer-name buffer-names)
        (find-file buffer-name))))


(defun fzl/view/open-ibuffer-and-dired()
  "Abre o ibuffer e o dired no diretório atual em janelas divididas."
  (interactive)
  (delete-other-windows)  ;; Fechar outras janelas
  (split-window-below)  ;; Dividir a janela horizontalmente
  (other-window 1)  ;; Mover para a nova janela
  (dired default-directory)  ;; Abrir dired no diretório atual
  (other-window -1)  ;; Voltar para a janela superior
  (ibuffer))  ;; Abrir ibuffer

;; Vincular a função a uma tecla de atalho, se desejar
(global-set-key (kbd "C-c i d") 'fzl/view/open-ibuffer-and-dired)


(provide 'fzl-views-strategies)
