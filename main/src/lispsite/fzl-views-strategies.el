(print "===> windows-and-frames loaded sucessfully")
(print (getenv "FZLEMACS_KEY_SHOW_WINDOW_SPEEDBAR_AT_LEFT"))

;;cada funcao formata a tela do emacs com uma estrategia especifica de visualizacao

(defun fzl/view/open-theese-buffers()  
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


(defun fzl/copilot/display()
  "Display copilot chat in a new window."
  (interactive)
  (delete-other-windows)  ;; Fechar outras janelas)
  (split-window-right)  ;; Dividir a janela horizontalmente
  (other-window 1)  ;; Mover para a nova janela
  (copilot-chat-display)
  (other-window -1))  ;; Voltar para a janela superior

(global-set-key (kbd (getenv "FZLEMACS_COPILOT_CHAT_DISPLAY_KEYBINDING")) 'fzl/copilot/display)


;;MESSAGE BUFFER AT THE BOTTON OF THE FRAME
(defun fzl/buffers/show-messages-buffer-at-bottom ()
  (interactive)
  "Display the *Messages* buffer in a window at the bottom of the frame."
  (let ((messages-buffer (get-buffer "*Messages*")))
    (when messages-buffer
      (let ((window (split-window-vertically)))
        (set-window-buffer window messages-buffer)
        (select-window window)
        ;; Optionally make the window smaller:
        (shrink-window (- (window-height) 10))))))

;;C-c m to show the message buffer
(global-set-key (kbd (getenv "FZLEMACS_KEY_SHOW_WINDOW_MESSAGE_BUFFER_AT_BOTTON")) 'fzl/buffers/show-messages-buffer-at-bottom)



;;;SPEEDBAR AT THE LEFT OF THE FRAME
(defun fzl/buffers/show-speedbar-on-left ()
  "Open the speedbar in a frame on the left."
  (interactive)
  (let ((speedbar-buffer (get-buffer "*SPEEDBAR*")))
    (if (and speedbar-buffer (frame-live-p (window-frame (get-buffer-window speedbar-buffer t))))
        (select-frame-set-input-focus (window-frame (get-buffer-window speedbar-buffer t)))
      (progn
        ;; Start speedbar
        (speedbar-get-focus)
        ;; Adjust its position and size
        (let ((frame (selected-frame)))
          (set-frame-position frame 0 0)
          (set-frame-width frame 30))))))

;; Optional: Bind the function to a key combination
(global-set-key (kbd (getenv "FZLEMACS_KEY_SHOW_WINDOW_SPEEDBAR_AT_LEFT")) 'fzl/buffers/show-speedbar-on-left)



(provide 'fzl-views-strategies)
