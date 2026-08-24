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
;;   INTEGRA_DEV_DB_HOST=186.217.0.21
;;   INTEGRA_DEV_DB_PORT=3306
;;   INTEGRA_DEV_DB_USER=uintegra
;;   INTEGRA_DEV_DB_PASS=42Ez0E+8
;;   INTEGRA_DEV_DB_NAME=integra_dev

;;; Code:

(require 'subr-x nil t)

;; Armazena o diretório de onde este arquivo foi carregado para localizar o .env
(defvar fzl-sql-connections-dir
  (file-name-directory (or load-file-name buffer-file-name default-directory))
  "Diretório base onde se encontra o arquivo sql-connections.el.")

;; --- SQL dentro de arquivos org (org-babel) ----------------------------------
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(require 'ob-sql-mode nil t)

(setq org-confirm-babel-evaluate nil)

;; --- Leitor de arquivo .env --------------------------------------------------

(defun fzl-load-env-file (&optional file-path)
  "Carrega variáveis de ambiente de um arquivo FILE-PATH (ex: .env) para o Emacs.
Procura automaticamente o arquivo .env subindo na árvore de diretórios."
  (let* ((base-dir (or file-path
                       (getenv "ENV_FILE")
                       (and (boundp 'fzl-sql-connections-dir) fzl-sql-connections-dir)
                       default-directory))
         (dom-dir (or (locate-dominating-file base-dir ".env")
                      (locate-dominating-file default-directory ".env")))
         (target-file (or (and (stringp file-path) (file-exists-p file-path) file-path)
                          (and dom-dir (expand-file-name ".env" dom-dir))
                          (expand-file-name ".env" base-dir))))
    (when (and target-file (file-exists-p target-file))
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
                      (setenv key val)))))))
          (forward-line 1))))))

;; Carrega as variáveis de ambiente do .env imediatamente ao carregar o arquivo
(fzl-load-env-file)

;;; ---------------------------------------------------------------------------
;;; SQL — integra-unesp (ambiente de dev)
;;; ---------------------------------------------------------------------------

(with-eval-after-load 'sql
  ;; -A desliga o auto-rehash (conexao mais rapida);
  ;; --protocol=tcp garante TCP mesmo se o host mudar para localhost.
  (setq sql-mysql-options '("-A" "--protocol=tcp"))

  ;; Recarrega .env ao inicializar o modo sql para garantir credenciais atualizadas
  (fzl-load-env-file)

  ;; Conexão Local
  (add-to-list
   'sql-connection-alist
   `(integra-local
     (sql-product 'mysql)
     (sql-server ,(or (getenv "INTEGRA_LOCAL_DB_HOST") (getenv "DB_HOST") "127.0.0.1"))
     (sql-port ,(string-to-number (or (getenv "INTEGRA_LOCAL_DB_PORT") (getenv "DB_PORT") "4306")))
     (sql-user ,(or (getenv "INTEGRA_LOCAL_DB_USER") (getenv "DB_USER") "root"))
     (sql-password ,(or (getenv "INTEGRA_LOCAL_DB_PASS") (getenv "DB_PASS") ""))
     (sql-database ,(or (getenv "INTEGRA_LOCAL_DB_NAME") (getenv "DB_NAME") "integra"))))

  ;; Conexão Dev
  (add-to-list
   'sql-connection-alist
   `(integra-dev
     (sql-product 'mysql)
     (sql-server ,(or (getenv "INTEGRA_DEV_DB_HOST") "127.0.0.1"))
     (sql-port ,(string-to-number (or (getenv "INTEGRA_DEV_DB_PORT") "3306")))
     (sql-user ,(or (getenv "INTEGRA_DEV_DB_USER") "uintegra"))
     (sql-password ,(or (getenv "INTEGRA_DEV_DB_PASS") ""))
     (sql-database ,(or (getenv "INTEGRA_DEV_DB_NAME") "integra_dev"))))

  ;; Conexao default ao abrir um SQLi sem escolher: M-x sql-connect RET RET
  (setq sql-connection-default-connection 'integra-dev))

;; Atalho: M-x integra-sql -> abre direto o REPL do banco de dev.
(defun integra-sql ()
  "Abre um buffer SQLi conectado ao MySQL de dev do integra-unesp."
  (interactive)
  (require 'sql)
  (sql-connect 'integra-dev "*SQL: integra-dev*"))

(provide 'sql-connections)
(provide 'init)
;;; sql-connections.el ends here
