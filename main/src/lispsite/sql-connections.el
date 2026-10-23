;;; sql-connections.el --- Configuração SQL do projeto integra-unesp -*- lexical-binding: t -*-

;;; Commentary:

;; Configuração de conexões SQL (`integra-local` e `integra-dev`) para Emacs.
;;
;; AS CREDENCIAIS FORAM ANONIMIZADAS PARA PERMITIR PUSH SEGURO NO GIT.
;; As informações sensíveis de conexão (host, porta, usuário, senha, banco) são
;; obtidas dinamicamente a partir de variáveis de ambiente do sistema ou de um
;; arquivo `.env` localizado no projeto.
;;
;; Exemplo de arquivo `.env` local (na raiz do projeto):
;;
;;   # Conexão Local
;;   INTEGRA_LOCAL_DB_HOST=127.0.0.1
;;   INTEGRA_LOCAL_DB_PORT=4306
;;   INTEGRA_LOCAL_DB_USER=root
;;   INTEGRA_LOCAL_DB_PASS=1234
;;   INTEGRA_LOCAL_DB_NAME=integra
;;
;;   # Conexão Dev
;;   INTEGRA_DEV_DB_HOST=ip_do_servidor_dev
;;   INTEGRA_DEV_DB_PORT=porta_do_servidor_dev
;;   INTEGRA_DEV_DB_USER=usuario_no_servidor_dev
;;   INTEGRA_DEV_DB_PASS=suasenhadev
;;   INTEGRA_DEV_DB_NAME=nome_do_banco_no_servidor_dev

;;; Code:

(require 'subr-x nil t)
(require 'easymenu)
(require 'seq)

;; Armazena o diretório de onde este arquivo foi carregado para localizar o .env
(defvar fzl-sql-connections-dir
  (file-name-directory (or load-file-name buffer-file-name default-directory))
  "Diretório base onde se encontra o arquivo sql-connections.el.")

(defvar fzl-sql-last-env-file nil
  "Caminho do último arquivo `.env` carregado pelo `fzl-load-env-file`.")

(defvar fzl-sql-env-profiles nil
  "Alist de perfis de banco de dados descobertos no `.env`.
Formato: ((SYMBOL . (:prefix STR :product SYM :host STR :port INT :user STR :password STR :database STR)) ...)")

(defvar fzl-sql-active-org-babel-profile 'integra-dev
  "Símbolo do perfil `.env` atualmente ativo para blocos `sql` do Org-Babel.")

;; --- SQL dentro de arquivos org (org-babel) ----------------------------------
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(require 'ob-sql-mode nil t)

(setq org-confirm-babel-evaluate nil)

(defun fzl-sql--resolve-env-file (&optional file-path)
  "Localiza o arquivo `.env` do projeto subindo na hierarquia de diretórios."
  (let* ((base-dir (or file-path
                       (getenv "ENV_FILE")
                       (and (boundp 'fzl-sql-connections-dir) fzl-sql-connections-dir)
                       default-directory))
         (dom-dir (or (locate-dominating-file base-dir ".env")
                      (locate-dominating-file default-directory ".env")
                      (locate-dominating-file base-dir ".env.example")))
         (target-file (or (and (stringp file-path) (file-exists-p file-path) file-path)
                          (and dom-dir (expand-file-name ".env" dom-dir))
                          (expand-file-name ".env" base-dir))))
    target-file))

(defun fzl-sql--build-profile-plist (prefix &optional default-host default-port default-user default-pass default-db)
  "Constrói um plist de conexão SQL a partir de variáveis `<PREFIX>_DB_*`."
  (let* ((p (if (or (null prefix) (string-empty-p prefix)) "" (concat prefix "_")))
         (raw-product (or (getenv (concat p "DB_PRODUCT"))
                          (getenv (concat p "DB_ENGINE"))
                          "mysql"))
         (product (intern (downcase raw-product)))
         (host (or (getenv (concat p "DB_HOST")) default-host "127.0.0.1"))
         (port-str (or (getenv (concat p "DB_PORT")) default-port "3306"))
         (port (if (numberp port-str) port-str (string-to-number port-str)))
         (user (or (getenv (concat p "DB_USER")) default-user "root"))
         (pass (or (getenv (concat p "DB_PASS")) default-pass ""))
         (db   (or (getenv (concat p "DB_NAME")) default-db "")))
    (list :prefix prefix
          :product product
          :host host
          :port port
          :user user
          :password pass
          :database db)))

(defun fzl-sql--discover-env-profiles (&optional prefixes)
  "Descobre e atualiza `fzl-sql-env-profiles` a partir dos PREFIXES e do ambiente."
  (let ((all-prefixes (delete-dups (append prefixes '("INTEGRA_LOCAL" "INTEGRA_DEV"))))
        (profiles nil))
    ;; Também vasculha `process-environment` por qualquer `<PREFIX>_DB_HOST=`
    (dolist (entry process-environment)
      (when (string-match "^\\([A-Za-z0-9_]+\\)_DB_HOST=" entry)
        (let ((pfx (match-string 1 entry)))
          (unless (member pfx all-prefixes)
            (setq all-prefixes (append all-prefixes (list pfx)))))))
    (dolist (pfx all-prefixes)
      (let* ((sym-name (downcase (replace-regexp-in-string "_" "-" pfx)))
             (sym (intern sym-name))
             (plist (cond
                     ((string= pfx "INTEGRA_LOCAL")
                      (fzl-sql--build-profile-plist
                       "INTEGRA_LOCAL"
                       (or (getenv "DB_HOST") "127.0.0.1")
                       (or (getenv "DB_PORT") "4306")
                       (or (getenv "DB_USER") "root")
                       (or (getenv "DB_PASS") "")
                       (or (getenv "DB_NAME") "integra")))
                     ((string= pfx "INTEGRA_DEV")
                      (fzl-sql--build-profile-plist
                       "INTEGRA_DEV"
                       (or (getenv "DB_HOST") "127.0.0.1")
                       (or (getenv "DB_PORT") "3306")
                       (or (getenv "DB_USER") "uintegra")
                       (or (getenv "DB_PASS") "")
                       (or (getenv "DB_NAME") "integra_dev")))
                     (t
                      (fzl-sql--build-profile-plist pfx)))))
        (push (cons sym plist) profiles)))
    (setq fzl-sql-env-profiles (nreverse profiles))))

(defun fzl-update-sql-org-babel-header-args (&optional profile-sym)
  "Atualiza as credenciais default do Org-Babel para blocos `sql` a partir do .env.
Se PROFILE-SYM for informado, passa a utilizá-lo como perfil ativo do Org-Babel."
  (when profile-sym
    (setq fzl-sql-active-org-babel-profile profile-sym))
  (let* ((active (or fzl-sql-active-org-babel-profile 'integra-dev))
         (plist (cdr (assq active fzl-sql-env-profiles))))
    (if plist
        (setq org-babel-default-header-args:sql
              `((:engine . ,(symbol-name (or (plist-get plist :product) 'mysql)))
                (:dbhost . ,(plist-get plist :host))
                (:dbport . ,(number-to-string (or (plist-get plist :port) 3306)))
                (:dbuser . ,(plist-get plist :user))
                (:dbpassword . ,(plist-get plist :password))
                (:database . ,(plist-get plist :database))))
      (setq org-babel-default-header-args:sql
            `((:engine . "mysql")
              (:dbhost . ,(or (getenv "INTEGRA_DEV_DB_HOST") (getenv "DB_HOST") "127.0.0.1"))
              (:dbport . ,(or (getenv "INTEGRA_DEV_DB_PORT") (getenv "DB_PORT") "3306"))
              (:dbuser . ,(or (getenv "INTEGRA_DEV_DB_USER") (getenv "DB_USER") "root"))
              (:dbpassword . ,(or (getenv "INTEGRA_DEV_DB_PASS") (getenv "DB_PASS") ""))
              (:database . ,(or (getenv "INTEGRA_DEV_DB_NAME") (getenv "DB_NAME") "integra_dev")))))))

(defun fzl-sql-register-connections ()
  "Registra ou atualiza todos os perfis de `fzl-sql-env-profiles` em `sql-connection-alist`."
  (when (boundp 'sql-connection-alist)
    (dolist (entry fzl-sql-env-profiles)
      (let* ((sym (car entry))
             (plist (cdr entry))
             (product (or (plist-get plist :product) 'mysql))
             (host (plist-get plist :host))
             (port (plist-get plist :port))
             (user (plist-get plist :user))
             (pass (plist-get plist :password))
             (db   (plist-get plist :database))
             (conn-spec `((sql-product ',product)
                          (sql-server ,host)
                          (sql-port ,port)
                          (sql-user ,user)
                          (sql-password ,pass)
                          (sql-database ,db))))
        (setf (alist-get sym sql-connection-alist nil nil #'equal) conn-spec)))))

;; --- Leitor de arquivo .env --------------------------------------------------

(defun fzl-load-env-file (&optional file-path)
  "Carrega variáveis de ambiente de um arquivo FILE-PATH (ex: .env) para o Emacs.
Procura automaticamente o arquivo .env subindo na árvore de diretórios e
registra dinamicamente todas as conexões `<PREFIX>_DB_*` encontradas."
  (interactive)
  (let ((target-file (fzl-sql--resolve-env-file file-path))
        (found-prefixes nil))
    (when (and target-file (file-exists-p target-file))
      (setq fzl-sql-last-env-file target-file)
      (with-temp-buffer
        (insert-file-contents target-file)
        (goto-char (point-min))
        (while (not (eobp))
          (let ((line (string-trim (buffer-substring-no-properties
                                    (line-beginning-position)
                                    (line-end-position)))))
            (unless (or (string-empty-p line)
                        (string-prefix-p "#" line))
              (when (string-prefix-p "export " line)
                (setq line (string-trim (substring line 7))))
              (let ((equal-pos (string-match "=" line)))
                (when equal-pos
                  (let ((key (string-trim (substring line 0 equal-pos)))
                        (val (string-trim (substring line (1+ equal-pos)))))
                    ;; Remove aspas simples ou duplas ao redor do valor
                    (when (and (> (length val) 1)
                               (or (and (string-prefix-p "\"" val) (string-suffix-p "\"" val))
                                   (and (string-prefix-p "'" val) (string-suffix-p "'" val))))
                      (setq val (substring val 1 (1- (length val)))))
                    (unless (string-empty-p key)
                      (setenv key val)
                      (when (string-match "^\\([A-Za-z0-9_]+\\)_DB_HOST$" key)
                        (let ((pfx (match-string 1 key)))
                          (unless (member pfx found-prefixes)
                            (push pfx found-prefixes))))))))))
          (forward-line 1))))
    (fzl-sql--discover-env-profiles (nreverse found-prefixes))
    (fzl-sql-register-connections)
    ;; Atualiza os parâmetros default do org-babel sql
    (fzl-update-sql-org-babel-header-args)
    (when (called-interactively-p 'any)
      (message "SQL (.env): carregados %d perfis de %s (Org-Babel ativo: %s)"
               (length fzl-sql-env-profiles)
               (or fzl-sql-last-env-file "variáveis de ambiente")
               fzl-sql-active-org-babel-profile))))

;; Carrega as variáveis de ambiente do .env imediatamente ao carregar o arquivo
(fzl-load-env-file)

;;; ---------------------------------------------------------------------------
;;; SQL — Inicialização do `sql-connection-alist`
;;; ---------------------------------------------------------------------------

(with-eval-after-load 'sql
  ;; -A desliga o auto-rehash (conexao mais rapida);
  ;; --protocol=tcp garante TCP mesmo se o host mudar para localhost.
  (setq sql-mysql-options '("-A" "--protocol=tcp"))

  ;; Recarrega .env ao inicializar o modo sql para garantir credenciais atualizadas
  (fzl-load-env-file)
  (fzl-sql-register-connections)

  ;; Conexao default ao abrir um SQLi sem escolher: M-x sql-connect RET RET
  (setq sql-connection-default-connection 'integra-dev))

;;; ---------------------------------------------------------------------------
;;; Comandos Interativos & Utilitários de Conexão SQL (.env)
;;; ---------------------------------------------------------------------------

(defun fzl-sql-connect-profile (profile)
  "Abre um buffer SQLi conectado ao PROFILE definido no `.env` ou em `sql-connection-alist`."
  (interactive
   (list
    (progn
      (require 'sql)
      (fzl-load-env-file)
      (let* ((candidates
              (mapcar (lambda (entry)
                        (let* ((sym (car entry))
                               (name (if (symbolp sym) (symbol-name sym) (format "%s" sym)))
                               (env-plist (cdr (assq (if (symbolp sym) sym (intern name))
                                                     fzl-sql-env-profiles)))
                               (label (if env-plist
                                          (format "%s  [%s://%s@%s:%s/%s]"
                                                  name
                                                  (plist-get env-plist :product)
                                                  (plist-get env-plist :user)
                                                  (plist-get env-plist :host)
                                                  (plist-get env-plist :port)
                                                  (plist-get env-plist :database))
                                        (format "%s  (sql-connection-alist)" name))))
                          (cons label sym)))
                      (or (and (boundp 'sql-connection-alist) sql-connection-alist)
                          fzl-sql-env-profiles)))
             (choice (completing-read "Conectar ao banco SQL (.env): "
                                      (mapcar #'car candidates) nil t)))
        (cdr (assoc choice candidates))))))
  (require 'sql)
  (fzl-load-env-file)
  (when profile
    (let* ((name (if (symbolp profile) (symbol-name profile) (format "%s" profile)))
           (buf-name (format "*SQL: %s*" name)))
      (sql-connect profile buf-name))))

(defalias 'fzl-sql-connect #'fzl-sql-connect-profile)

;; Atalho: M-x integra-sql -> abre direto o REPL do banco de dev.
(defun integra-sql ()
  "Abre um buffer SQLi conectado ao MySQL de dev do integra-unesp."
  (interactive)
  (fzl-sql-connect-profile 'integra-dev))

(defun integra-local-sql ()
  "Abre um buffer SQLi conectado ao MySQL local (`integra-local`)."
  (interactive)
  (fzl-sql-connect-profile 'integra-local))

(defun fzl-sql-switch-org-babel-profile (&optional profile-sym)
  "Alterna o perfil de banco do `.env` usado como padrão nos blocos `sql` do Org-Babel."
  (interactive)
  (fzl-load-env-file)
  (let* ((chosen
          (or profile-sym
              (let* ((candidates
                      (mapcar (lambda (entry)
                                (let* ((sym (car entry))
                                       (pl (cdr entry))
                                       (active-p (eq sym fzl-sql-active-org-babel-profile))
                                       (label (format "%s%s  (%s://%s@%s:%s/%s)"
                                                      (symbol-name sym)
                                                      (if active-p " [ATIVO]" "")
                                                      (plist-get pl :product)
                                                      (plist-get pl :user)
                                                      (plist-get pl :host)
                                                      (plist-get pl :port)
                                                      (plist-get pl :database))))
                                  (cons label sym)))
                              fzl-sql-env-profiles))
                     (sel (completing-read "Perfil Org-Babel SQL (.env): "
                                           (mapcar #'car candidates) nil t)))
                (cdr (assoc sel candidates)))))
         (plist (cdr (assq chosen fzl-sql-env-profiles))))
    (when chosen
      (fzl-update-sql-org-babel-header-args chosen)
      (if plist
          (message "Org-Babel SQL agora aponta para [%s] -> %s@%s:%s/%s"
                   chosen
                   (plist-get plist :user)
                   (plist-get plist :host)
                   (plist-get plist :port)
                   (plist-get plist :database))
        (message "Org-Babel SQL agora aponta para [%s]" chosen)))))

(defun fzl-sql-open-env-file ()
  "Abre o arquivo `.env` do projeto para edição.
Se o `.env` ainda não existir e houver `.env.example`, copia o template automaticamente."
  (interactive)
  (let* ((env-file (fzl-sql--resolve-env-file))
         (dir (file-name-directory env-file))
         (example-file (expand-file-name ".env.example" dir)))
    (when (and (not (file-exists-p env-file))
               (file-exists-p example-file)
               (yes-or-no-p (format "Arquivo %s não existe. Criar a partir de .env.example? " env-file)))
      (copy-file example-file env-file))
    (find-file env-file)))

(defun fzl-sql-open-consultas-org ()
  "Abre o arquivo `sql-connect/consultas.org` do projeto."
  (interactive)
  (let* ((env-file (fzl-sql--resolve-env-file))
         (root-dir (if env-file (file-name-directory env-file) default-directory))
         (consultas (expand-file-name "sql-connect/consultas.org" root-dir)))
    (if (file-exists-p consultas)
        (find-file consultas)
      (user-error "Arquivo não encontrado: %s" consultas))))

(defun fzl-sql-list-sqli-buffers ()
  "Lista ou alterna para um buffer SQLi interativo aberto."
  (interactive)
  (let ((bufs (seq-filter (lambda (b)
                            (with-current-buffer b
                              (derived-mode-p 'sql-interactive-mode)))
                          (buffer-list))))
    (if (not bufs)
        (message "Nenhum buffer SQLi ativo no momento. Use `M-x fzl-sql-connect` para conectar.")
      (let ((chosen (completing-read "Alternar para buffer SQLi: "
                                     (mapcar #'buffer-name bufs) nil t)))
        (when (and chosen (not (string-empty-p chosen)))
          (pop-to-buffer chosen))))))

(defun fzl-sql-show-status ()
  "Exibe um resumo dos perfis SQL carregados do `.env` e conexões ativas."
  (interactive)
  (fzl-load-env-file)
  (let ((buf (get-buffer-create "*FZL SQL (.env) Status*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "#+TITLE: 🗄️ Conexões SQL Definidas via .env\n")
        (insert "#+STARTUP: showall\n\n")
        (insert (format "- *Arquivo .env carregado*: =%s=\n"
                        (or fzl-sql-last-env-file "(não encontrado, usando defaults)")))
        (insert (format "- *Perfil ativo no Org-Babel*: =%s=\n\n"
                        fzl-sql-active-org-babel-profile))
        (insert "* 📋 Perfis Descobertos no `.env`\n\n")
        (insert "| Perfil | Engine | Host | Porta | Usuário | Banco | Org-Babel |\n")
        (insert "|--------+--------+------+-------+---------+-------+-----------|\n")
        (dolist (entry fzl-sql-env-profiles)
          (let* ((sym (car entry))
                 (pl (cdr entry))
                 (active (if (eq sym fzl-sql-active-org-babel-profile) "ATIVO" "")))
            (insert (format "| =%s= | %s | =%s= | %s | =%s= | =%s= | %s |\n"
                            sym
                            (plist-get pl :product)
                            (plist-get pl :host)
                            (plist-get pl :port)
                            (plist-get pl :user)
                            (plist-get pl :database)
                            active))))
        (insert "\n* ⌨️ Atalhos Rápidos neste Buffer\n")
        (insert "- =c= : Conectar a um banco (=fzl-sql-connect=)\n")
        (insert "- =b= : Trocar perfil ativo do Org-Babel (=fzl-sql-switch-org-babel-profile=)\n")
        (insert "- =e= : Editar arquivo =.env= (=fzl-sql-open-env-file=)\n")
        (insert "- =r= : Recarregar =.env= (=fzl-load-env-file=)\n")
        (insert "- =o= : Abrir =sql-connect/consultas.org=\n")
        (insert "- =q= : Fechar janela\n")
        (org-mode)
        (local-set-key (kbd "c") #'fzl-sql-connect)
        (local-set-key (kbd "b") (lambda () (interactive) (call-interactively #'fzl-sql-switch-org-babel-profile) (fzl-sql-show-status)))
        (local-set-key (kbd "e") #'fzl-sql-open-env-file)
        (local-set-key (kbd "r") (lambda () (interactive) (fzl-load-env-file) (fzl-sql-show-status)))
        (local-set-key (kbd "o") #'fzl-sql-open-consultas-org)
        (local-set-key (kbd "q") #'quit-window)
        (setq-local buffer-read-only t)))
    (pop-to-buffer buf)))

;;; ---------------------------------------------------------------------------
;;; VPN (OpenVPN / UNESP) — Integração com .env
;;; ---------------------------------------------------------------------------

(defvar fzl-vpn-buffer-name "*fzl-vpn-unesp*"
  "Nome do buffer onde o processo OpenVPN é executado.")

(defvar fzl-vpn--sudo-password nil
  "Armazenamento temporário em memória da senha sudo durante o handshake inicial.")

(defvar fzl-vpn--connected nil
  "Indica se a sessão OpenVPN completou a inicialização (`Initialization Sequence Completed`).")

(defun fzl-vpn--get-config ()
  "Obtém a configuração de VPN a partir do `.env`."
  (fzl-load-env-file)
  (let* ((vpn-dir (expand-file-name (or (getenv "UNESP_VPN_DIR") "~/WORKING/HOME/vpn")))
         (ovpn-file (expand-file-name (or (getenv "UNESP_VPN_OVPN_FILE")
                                          (expand-file-name "unesp.ovpn" vpn-dir))))
         (vpn-user (or (getenv "UNESP_VPN_USER") ""))
         (vpn-pass (or (getenv "UNESP_VPN_PASS") "")))
    (list :dir vpn-dir :ovpn ovpn-file :user vpn-user :pass vpn-pass)))

(defun fzl-vpn-running-p ()
  "Retorna non-nil se o processo OpenVPN do Emacs ou do sistema estiver em execução."
  (let ((proc (get-buffer-process fzl-vpn-buffer-name)))
    (or (and proc (process-live-p proc))
        (= 0 (call-process "pgrep" nil nil nil "-x" "openvpn")))))

(defun fzl-vpn--tun-ip ()
  "Retorna o endereço IP da interface `tun0` (ou `tun*`) caso ativa, ou nil."
  (let ((out (shell-command-to-string "ip -4 -o addr show dev tun0 2>/dev/null")))
    (when (string-match "inet \\([0-9.]+\\)" out)
      (match-string 1 out))))

(defun fzl-vpn--sudo-needs-password-p ()
  "Retorna non-nil se `sudo` exigir senha no momento."
  (/= 0 (call-process "sudo" nil nil nil "-n" "true")))

(defun fzl-vpn--process-filter (proc output)
  "Filtro de processo do OpenVPN para responder automaticamente sudo, usuário e senha do `.env`."
  (let ((clean-output (replace-regexp-in-string "\r" "" output)))
    ;; Insere no buffer de log (ocultando ecos de senha caso existam)
    (when (buffer-live-p (process-buffer proc))
      (with-current-buffer (process-buffer proc)
        (let ((inhibit-read-only t)
              (moving (= (point) (process-mark proc))))
          (save-excursion
            (goto-char (process-mark proc))
            (insert clean-output)
            (set-marker (process-mark proc) (point)))
          (when moving
            (goto-char (process-mark proc))))))
    ;; 1. Prompt de senha do sudo
    (when (string-match-p "\\(\\[sudo\\]\\|Password for\\|senha para\\).*:" clean-output)
      (let ((pw (or fzl-vpn--sudo-password
                    (read-passwd (format "[sudo] senha para %s: " (user-login-name))))))
        (setq fzl-vpn--sudo-password nil)
        (process-send-string proc (concat pw "\n"))))
    ;; 2. Prompt de Usuário do OpenVPN (Enter Auth Username:)
    (when (string-match-p "Enter Auth Username:" clean-output)
      (let* ((cfg (fzl-vpn--get-config))
             (user (plist-get cfg :user)))
        (when (string-empty-p user)
          (setq user (read-string "OpenVPN Username: ")))
        (process-send-string proc (concat user "\n"))
        (message "VPN (.env): enviando usuário '%s'..." user)))
    ;; 3. Prompt de Senha do OpenVPN (Enter Auth Password:)
    (when (string-match-p "Enter Auth Password:" clean-output)
      (let* ((cfg (fzl-vpn--get-config))
             (pass (plist-get cfg :pass)))
        (when (string-empty-p pass)
          (setq pass (read-passwd "OpenVPN Password: ")))
        (process-send-string proc (concat pass "\n"))
        (message "VPN (.env): enviando senha do .env...")))
    ;; 4. Confirmação de conexão estabelecida
    (when (string-match-p "Initialization Sequence Completed" clean-output)
      (setq fzl-vpn--connected t)
      (let ((ip (fzl-vpn--tun-ip)))
        (message "✅ VPN UNESP conectada com sucesso!%s"
                 (if ip (format " (tun0: %s)" ip) ""))))
    ;; 5. Falha de autenticação
    (when (string-match-p "AUTH_FAILED" clean-output)
      (setq fzl-vpn--connected nil)
      (message "❌ VPN UNESP: Falha de autenticação (AUTH_FAILED). Verifique UNESP_VPN_USER e UNESP_VPN_PASS no .env."))))

(defun fzl-vpn--process-sentinel (proc event)
  "Sentinel para monitorar o encerramento do processo OpenVPN."
  (setq fzl-vpn--sudo-password nil)
  (when (memq (process-status proc) '(exit signal))
    (setq fzl-vpn--connected nil)
    (when (buffer-live-p (process-buffer proc))
      (with-current-buffer (process-buffer proc)
        (let ((inhibit-read-only t))
          (goto-char (point-max))
          (insert (format "\n--- Processo OpenVPN finalizado: %s ---\n" (string-trim event))))))
    (message "🔌 VPN UNESP desconectada (%s)." (string-trim event))))

(defun fzl-vpn-connect ()
  "Inicia a conexão OpenVPN da UNESP usando usuário e senha definidos no `.env`.
Pede a senha do `sudo` no minibuffer caso necessário."
  (interactive)
  (let* ((cfg (fzl-vpn--get-config))
         (vpn-dir (plist-get cfg :dir))
         (ovpn-file (plist-get cfg :ovpn))
         (existing-proc (get-buffer-process fzl-vpn-buffer-name)))
    (unless (file-exists-p ovpn-file)
      (user-error "Arquivo OpenVPN não encontrado: %s" ovpn-file))
    (if (and existing-proc (process-live-p existing-proc))
        (progn
          (pop-to-buffer fzl-vpn-buffer-name)
          (message "VPN já está em execução no buffer %s." fzl-vpn-buffer-name))
      (when (fzl-vpn--sudo-needs-password-p)
        (setq fzl-vpn--sudo-password
              (read-passwd (format "[sudo] senha para %s (OpenVPN): " (user-login-name)))))
      (let ((buf (get-buffer-create fzl-vpn-buffer-name))
            (process-connection-type t))
        (with-current-buffer buf
          (let ((inhibit-read-only t))
            (erase-buffer)
            (insert (format "=== Iniciando OpenVPN (%s) em %s ===\n"
                            (file-name-nondirectory ovpn-file) vpn-dir))
            (insert "Teclas: [q] fechar janela  |  [d] desconectar VPN  |  [r] reconectar  |  [s] status\n\n"))
          (setq default-directory (file-name-as-directory vpn-dir))
          (local-set-key (kbd "q") #'quit-window)
          (local-set-key (kbd "d") #'fzl-vpn-disconnect)
          (local-set-key (kbd "r") (lambda () (interactive) (fzl-vpn-disconnect) (sit-for 1) (fzl-vpn-connect)))
          (local-set-key (kbd "s") #'fzl-vpn-status)
          (setq-local buffer-read-only t))
        (let ((proc (start-process "fzl-openvpn" buf
                                   "sudo" "openvpn" (file-name-nondirectory ovpn-file))))
          (set-process-filter proc #'fzl-vpn--process-filter)
          (set-process-sentinel proc #'fzl-vpn--process-sentinel)
          (pop-to-buffer buf)
          (message "Iniciando OpenVPN UNESP..."))))))

(defun fzl-vpn-disconnect ()
  "Encerra a conexão OpenVPN ativa."
  (interactive)
  (let ((proc (get-buffer-process fzl-vpn-buffer-name)))
    (if (not (fzl-vpn-running-p))
        (message "Nenhuma conexão OpenVPN ativa no momento.")
      (let ((sudo-pw (when (fzl-vpn--sudo-needs-password-p)
                       (read-passwd (format "[sudo] senha para %s (encerrar OpenVPN): " (user-login-name))))))
        (if sudo-pw
            (call-process-region (concat sudo-pw "\n") nil "sudo" nil nil nil "-S" "killall" "-SIGINT" "openvpn")
          (call-process "sudo" nil nil nil "killall" "-SIGINT" "openvpn"))
        (when (and proc (process-live-p proc))
          (ignore-errors (interrupt-process proc)))
        (setq fzl-vpn--connected nil)
        (message "Sinal de desconexão enviado ao OpenVPN.")))))

(defun fzl-vpn-status ()
  "Verifica e informa o status atual da VPN (processo `openvpn` e interface `tun0`)."
  (interactive)
  (let ((running (fzl-vpn-running-p))
        (ip (fzl-vpn--tun-ip)))
    (cond
     ((and running ip)
      (message "✅ VPN UNESP ATIVA — Interface tun0: %s" ip))
     (running
      (message "⏳ Processo OpenVPN em execução (aguardando tun0 / autenticação)..."))
     (t
      (message "🔌 VPN UNESP DESCONECTADA.")))))

(defun fzl-vpn-show-logs ()
  "Abre o buffer de logs da sessão OpenVPN (`*fzl-vpn-unesp*`)."
  (interactive)
  (let ((buf (get-buffer fzl-vpn-buffer-name)))
    (if buf
        (pop-to-buffer buf)
      (message "Buffer %s ainda não foi criado. Use `M-x fzl-vpn-connect` para iniciar a VPN."
               fzl-vpn-buffer-name))))

(defun fzl-vpn-open-dir ()
  "Abre o diretório de configuração da VPN (`UNESP_VPN_DIR`) no Dired."
  (interactive)
  (let* ((cfg (fzl-vpn--get-config))
         (dir (plist-get cfg :dir)))
    (if (file-directory-p dir)
        (dired dir)
      (user-error "Diretório VPN não encontrado: %s" dir))))

;;; ---------------------------------------------------------------------------
;;; Menu Dinâmico: "SQL (.env)"
;;; ---------------------------------------------------------------------------

(defun fzl-sql--menu-connect-filter (&optional _menu-items)
  "Filtro dinâmico para listar conexões SQLi a partir do `.env` e `sql-connection-alist`."
  (condition-case err
      (let ((items nil))
        ;; 1. Perfis vindos do .env
        (dolist (entry fzl-sql-env-profiles)
          (let* ((sym (car entry))
                 (pl (cdr entry))
                 (label (format "%s  (%s@%s:%s/%s)"
                                (symbol-name sym)
                                (plist-get pl :user)
                                (plist-get pl :host)
                                (plist-get pl :port)
                                (plist-get pl :database)))
                 (help (format "Abrir REPL SQLi conectado ao perfil .env '%s'" sym)))
            (push (vector label `(fzl-sql-connect-profile ',sym) t :help help) items)))
        (setq items (nreverse items))
        ;; 2. Conexões adicionais em `sql-connection-alist` (ex: fzlbpms)
        (when (boundp 'sql-connection-alist)
          (let ((extra nil))
            (dolist (conn sql-connection-alist)
              (let* ((key (car conn))
                     (sym (if (symbolp key) key (intern (format "%s" key)))))
                (unless (assq sym fzl-sql-env-profiles)
                  (push (vector (format "%s" key)
                                `(fzl-sql-connect-profile ',key)
                                t
                                :help (format "Conectar a %s" key))
                        extra))))
            (when extra
              (setq items (append items (list "---") (nreverse extra))))))
        (or items (list ["(Nenhuma conexão encontrada)" nil :active nil])))
    (error
     (list (vector (format "(Erro: %s)" (error-message-string err)) nil :active nil)))))

(defun fzl-sql--menu-org-babel-filter (&optional _menu-items)
  "Filtro dinâmico para selecionar o perfil `.env` ativo para blocos `sql` do Org-Babel."
  (condition-case err
      (if (not fzl-sql-env-profiles)
          (list ["(Nenhum perfil .env carregado)" nil :active nil])
        (mapcar
         (lambda (entry)
           (let* ((sym (car entry))
                  (pl (cdr entry))
                  (label (format "%s  (%s@%s:%s/%s)"
                                 (symbol-name sym)
                                 (plist-get pl :user)
                                 (plist-get pl :host)
                                 (plist-get pl :port)
                                 (plist-get pl :database))))
             (vector label
                     `(fzl-sql-switch-org-babel-profile ',sym)
                     :style 'radio
                     :selected `(eq fzl-sql-active-org-babel-profile ',sym)
                     :help (format "Usar perfil '%s' nos blocos Org-Babel SQL" sym))))
         fzl-sql-env-profiles))
    (error
     (list (vector (format "(Erro: %s)" (error-message-string err)) nil :active nil)))))

(easy-menu-define fzl-sql-menu global-map "Menu de Conexões SQL (.env)"
  '("SQL (.env)"
    ("Conectar SQLi (REPL)" :filter fzl-sql--menu-connect-filter)
    ("Perfil Ativo no Org-Babel" :filter fzl-sql--menu-org-babel-filter)
    "---"
    ["Conectar Interativamente (Prompt)..." fzl-sql-connect :keys "C-c d q c" :help "Escolher conexão SQL (.env) via minibuffer/Helm"]
    ["Conectar: integra-dev (Rápido)" integra-sql :keys "C-c d q d" :help "Abrir REPL SQLi conectado ao integra-dev"]
    ["Conectar: integra-local (Rápido)" integra-local-sql :keys "C-c d q l" :help "Abrir REPL SQLi conectado ao integra-local"]
    ["Alternar para Buffer SQLi Ativo..." fzl-sql-list-sqli-buffers :keys "C-c d q i" :help "Listar e focar em um buffer SQLi aberto"]
    "---"
    ["Painel de Status SQL (.env)" fzl-sql-show-status :keys "C-c d q s" :help "Exibir tabela com todos os bancos carregados do .env"]
    ["Abrir Consultas (consultas.org)" fzl-sql-open-consultas-org :keys "C-c d q o" :help "Abrir arquivo sql-connect/consultas.org"]
    "---"
    ["Editar Arquivo .env" fzl-sql-open-env-file :keys "C-c d q e" :help "Abrir o arquivo .env do projeto para edição"]
    ["Recarregar Credenciais (.env)" fzl-load-env-file :keys "C-c d q r" :help "Reler variáveis do arquivo .env e atualizar conexões"]))

;;; ---------------------------------------------------------------------------
;;; Menu: "VPN (UNESP)"
;;; ---------------------------------------------------------------------------

(easy-menu-define fzl-vpn-menu global-map "Menu VPN Trabalho (UNESP OpenVPN)"
  '("VPN (UNESP)"
    ["Conectar VPN (unesp.ovpn)" fzl-vpn-connect :keys "C-c d v c" :help "Iniciar OpenVPN com credenciais do .env"]
    ["Desconectar VPN" fzl-vpn-disconnect :keys "C-c d v d" :help "Encerrar conexão OpenVPN ativa"]
    "---"
    ["Status da VPN (tun0)" fzl-vpn-status :keys "C-c d v s" :help "Verificar status da VPN e IP tun0"]
    ["Ver Buffer de Logs da VPN" fzl-vpn-show-logs :keys "C-c d v l" :help "Abrir buffer *fzl-vpn-unesp*"]
    ["Abrir Pasta da VPN (Dired)" fzl-vpn-open-dir :keys "C-c d v o" :help "Abrir ~/WORKING/HOME/vpn no Dired"]
    "---"
    ["Editar Arquivo .env" fzl-sql-open-env-file :keys "C-c d q e" :help "Abrir o arquivo .env do projeto para edição"]))

(provide 'sql-connections)
(provide 'init)
;;; sql-connections.el ends here
