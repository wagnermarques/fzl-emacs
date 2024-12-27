;; Iniciar Emacs com um buffer `dired` no diretório atual
(add-hook 'emacs-startup-hook (lambda () (dired default-directory)))

(provide 'hook-emacs-startup)
