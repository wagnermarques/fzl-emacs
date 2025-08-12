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
;(use-package eshell
;  :ensure t
;  :config
;  (add-hook 'eshell-mode-hook 'eshell-cd))

;; Configuração do comint-mode (integrado ao Emacs)
(require 'comint)

;; Configuração opcional do fzf para busca aprimorada de comandos de shell
;(use-package fzf
;  :ensure t
;  :config
;  (add-hook 'eshell-mode-hook 'fzf-eshell-mode))

;; Habilitar sh-mode para arquivos de script de shell
(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))


;; Define a function that makes script files executable upon saving
(defun make-script-executable ()
  "Make the current file executable if it's a script with a shebang line."
  ;; Use 'when' conditional (similar to 'if' but with implicit 'progn' for multiple forms)
  (when (and 
         ;; First condition: check if the file starts with a shebang (#!) line
         (save-excursion                  ; Save current cursor position
           (save-restriction              ; Save current buffer restrictions
             (widen)                      ; Remove any narrowing to make sure we check the whole file
             (goto-char (point-min))      ; Go to the beginning of the buffer
             (save-match-data             ; Save the current match data to not interfere with other regex operations
               (looking-at "^#!"))))      ; Check if buffer starts with #! (shebang)
         
         ;; Second condition: check if the file is NOT already executable
         (not (file-executable-p buffer-file-name)))
    
    ;; If both conditions are true, execute this body:
    
    ;; Set file permissions to add executable bit for user, group, and others
    ;; - (file-modes buffer-file-name) gets the current permissions
    ;; - #o111 is octal for executable bits (100 for user, 010 for group, 001 for others)
    ;; - logior performs bitwise OR to add these bits without affecting other permissions
    (set-file-modes buffer-file-name
                    (logior (file-modes buffer-file-name) #o111))
    
    ;; Display a message in the minibuffer to inform the user
    (message "Made %s executable" buffer-file-name)))

;; Register the function to be called automatically every time a file is saved
(add-hook 'after-save-hook 'make-script-executable)


(provide 'coding-lang-shellscript)
