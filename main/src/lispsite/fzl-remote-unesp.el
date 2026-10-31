;;; fzl-remote-unesp.el --- Remote UNESP Server via SSH & TRAMP -*- lexical-binding: t; -*-

;;; Commentary:
;; Este módulo integra o servidor remoto UNESP (200.145.9.174) com o Emacs,
;; fornecendo comandos para navegação no Dired via TRAMP, controle de versão
;; com Magit remoto, terminal SSH e verificação da VPN (tun0).

;;; Code:

(require 'tramp)
(require 'dired)

(defgroup fzl-remote-unesp nil
  "Configurações para acesso ao servidor remoto UNESP via TRAMP."
  :group 'tools)

(defcustom fzl/remote-unesp-host "200.145.9.174"
  "Endereço IP ou hostname do servidor UNESP."
  :type 'string
  :group 'fzl-remote-unesp)

(defcustom fzl/remote-unesp-user "wgn"
  "Nome de usuário para conexão SSH ao servidor UNESP."
  :type 'string
  :group 'fzl-remote-unesp)

(defcustom fzl/remote-unesp-default-dir "/home/wgn/"
  "Diretório padrão inicial no servidor remoto UNESP."
  :type 'string
  :group 'fzl-remote-unesp)

(defun fzl/remote-unesp--tramp-path (&optional rel-path)
  "Retorna o caminho TRAMP formatado para o servidor UNESP com REL-PATH opcional."
  (let ((subpath (or rel-path fzl/remote-unesp-default-dir)))
    (unless (string-prefix-p "/" subpath)
      (setq subpath (concat "/" subpath)))
    (format "/ssh:%s@%s:%s" fzl/remote-unesp-user fzl/remote-unesp-host subpath)))

(defun fzl/remote-unesp--vpn-active-p ()
  "Verifica se a interface de rede da VPN UNESP (tun0) está ativa."
  (or (file-exists-p "/sys/class/net/tun0")
      (and (fboundp 'fzl-vpn-running-p) (fzl-vpn-running-p))))

(defun fzl/remote-unesp--check-vpn-and-warn ()
  "Alerta o usuário caso a VPN UNESP pareça estar desconectada."
  (unless (fzl/remote-unesp--vpn-active-p)
    (message "Aviso: A VPN UNESP (tun0) parece inativa. Se a conexão falhar, conecte via `C-c d v c`.")))

;;;###autoload
(defun fzl/remote-unesp-dired (&optional arg)
  "Abre o Dired remotamente no servidor UNESP via TRAMP.
Com prefixo ARG (`C-u`), solicita interativamente o diretório remoto."
  (interactive "P")
  (fzl/remote-unesp--check-vpn-and-warn)
  (let ((target-dir
         (if arg
             (read-string "Diretório remoto UNESP: "
                          (fzl/remote-unesp--tramp-path))
           (fzl/remote-unesp--tramp-path))))
    (message "Conectando ao servidor UNESP (%s) via TRAMP..." fzl/remote-unesp-host)
    (dired target-dir)))

;;;###autoload
(defun fzl/remote-unesp-find-file ()
  "Abre o prompt `find-file` apontando diretamente para o servidor remoto UNESP via TRAMP."
  (interactive)
  (fzl/remote-unesp--check-vpn-and-warn)
  (let ((default-directory (fzl/remote-unesp--tramp-path)))
    (call-interactively #'find-file)))

;;;###autoload
(defun fzl/remote-unesp-magit (&optional arg)
  "Abre o `magit-status` em um repositório Git no servidor remoto UNESP via TRAMP.
Se o buffer atual já estiver em uma pasta remota no servidor, usa o diretório atual;
caso contrário, solicita o diretório do repositório no servidor."
  (interactive "P")
  (fzl/remote-unesp--check-vpn-and-warn)
  (unless (require 'magit nil t)
    (user-error "Magit não está instalado ou disponível"))
  (let* ((current-dir (or default-directory ""))
         (remote-prefix (format "/ssh:%s@%s:" fzl/remote-unesp-user fzl/remote-unesp-host))
         (repo-dir
          (if (and (not arg) (string-prefix-p remote-prefix current-dir))
              current-dir
            (read-directory-name "Repositório Git remoto UNESP: "
                                 (fzl/remote-unesp--tramp-path)))))
    (message "Iniciando Magit remoto em %s..." repo-dir)
    (magit-status repo-dir)))

;;;###autoload
(defun fzl/remote-unesp-terminal ()
  "Abre uma sessão de terminal dedicada conectada via SSH ao servidor UNESP."
  (interactive)
  (fzl/remote-unesp--check-vpn-and-warn)
  (let* ((buf-name (format "*terminal-unesp-%s*" fzl/remote-unesp-host))
         (ssh-cmd (executable-find "ssh")))
    (unless ssh-cmd
      (user-error "Comando `ssh` não encontrado no sistema"))
    (if (and (get-buffer buf-name) (buffer-live-p (get-buffer buf-name)))
        (pop-to-buffer buf-name)
      (let ((term-buf (make-term (format "terminal-unesp-%s" fzl/remote-unesp-host)
                                 ssh-cmd nil
                                 (format "%s@%s" fzl/remote-unesp-user fzl/remote-unesp-host))))
        (set-buffer term-buf)
        (term-mode)
        (term-char-mode)
        (pop-to-buffer term-buf)
        (message "Terminal SSH conectado a %s@%s." fzl/remote-unesp-user fzl/remote-unesp-host)))))

;;;###autoload
(defun fzl/remote-unesp-check-connection ()
  "Verifica o status da VPN (tun0) e a rota para o servidor UNESP."
  (interactive)
  (let ((vpn-ok (fzl/remote-unesp--vpn-active-p)))
    (if vpn-ok
        (message "VPN UNESP (tun0) ATIVA. Servidor %s está acessível." fzl/remote-unesp-host)
      (message "VPN UNESP (tun0) INATIVA. Conecte primeiro via `C-c d v c` para acessar %s."
               fzl/remote-unesp-host))))

(provide 'fzl-remote-unesp)
;;; fzl-remote-unesp.el ends here
