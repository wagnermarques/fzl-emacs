;;; fzl-dashboard.el --- Startup & Features Health Dashboard for FZL Emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; Este módulo cria o buffer temporário `*FZL Emacs Dashboard*` que exibe
;; o status consolidado de saúde e inicialização das principais features:
;; Buku (bookmarks & sync), IAs (Copilot & Antigravity), VPN e Servidores UNESP,
;; além de parâmetros gerais do sistema.
;; Pressione `q` para fechar o painel e `g` para atualizar.

;;; Code:

(require 'subr-x)

(defgroup fzl-dashboard nil
  "Painel de status das features do FZL Emacs."
  :group 'convenience)

(defcustom fzl/dashboard-show-on-startup t
  "Se não-nulo, exibe o painel de status das features na inicialização."
  :type 'boolean
  :group 'fzl-dashboard)

(defconst fzl/dashboard-buffer-name "*FZL Emacs Dashboard*"
  "Nome do buffer do dashboard de features.")

(defvar fzl-dashboard-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q") #'quit-window)
    (define-key map (kbd "g") #'fzl/dashboard-refresh)
    (define-key map (kbd "h") #'describe-mode)
    map)
  "Keymap para o modo `fzl-dashboard-mode`.")

(define-derived-mode fzl-dashboard-mode special-mode "FZL-Dashboard"
  "Major mode para o painel de status das features do FZL Emacs."
  (setq truncate-lines t)
  (setq buffer-read-only t))

;;; ============================================================================
;;; Coleta de Status dos Subsistemas
;;; ============================================================================

(defun fzl/dashboard--buku-status ()
  "Retorna uma lista com informações sobre o estado do Buku."
  (let* ((bin (if (fboundp 'desktoping--buku-bin)
                  (desktoping--buku-bin)
                (or (executable-find "buku") (expand-file-name "~/.local/bin/buku"))))
         (bin-ok (and bin (or (file-executable-p bin) (executable-find bin))))
         (db-path (or (bound-and-true-p desktoping-buku-db-path)
                      (getenv "BUKU_DB_PATH")
                      (expand-file-name "bookmarks/bookmarks.db"
                                        (bound-and-true-p fzlemacs-dir--fzlemacs-home))))
         (db-ok (and db-path (file-exists-p db-path)))
         (sql-path (when db-path (concat (file-name-sans-extension db-path) ".sql")))
         (sql-ok (and sql-path (file-exists-p sql-path)))
         (count
          (cond
           ((and sql-ok (fboundp 'fzl-buku-sync--read) (fboundp 'fzl-buku-sync--count))
            (ignore-errors (fzl-buku-sync--count (fzl-buku-sync--read sql-path))))
           (db-ok
            (let ((out (ignore-errors
                         (string-trim (shell-command-to-string
                                       (format "sqlite3 %s \"SELECT COUNT(*) FROM bookmarks;\" 2>/dev/null"
                                               (shell-quote-argument db-path)))))))
              (if (and out (string-match-p "^[0-9]+$" out))
                  (string-to-number out)
                nil)))
           (t nil)))
         (sync-ok (and (boundp 'fzl-buku-sync-mode) fzl-buku-sync-mode)))
    (list :bin (if bin-ok (format "Presente (%s)" bin) "Não encontrado")
          :bin-ok bin-ok
          :db (if db-ok (file-name-nondirectory db-path) "Ausente")
          :db-path db-path
          :db-ok db-ok
          :count count
          :sync (if sync-ok "Ativa (bookmarks.sql <-> bookmarks.db)" "Inativa")
          :sync-ok sync-ok)))

(defun fzl/dashboard--ai-status ()
  "Retorna status das integrações de IA (Antigravity e Copilot)."
  (let* ((copilot-pkg (featurep 'copilot))
         (copilot-srv-bin (expand-file-name "~/.emacs.d/.cache/copilot/bin/copilot-language-server"))
         (copilot-srv-ok (file-exists-p copilot-srv-bin))
         (copilot-chat-ok (featurep 'copilot-chat))
         (agy-pkg (featurep 'pkgconfig-antigravity))
         (agy-cfg (expand-file-name ".gemini/antigravity-cli/settings.json" "~"))
         (agy-cfg-ok (file-exists-p agy-cfg))
         (menu-ias (lookup-key global-map [menu-bar IAs])))
    (list :copilot-pkg copilot-pkg
          :copilot-server (if copilot-srv-ok "Instalado (~/.emacs.d/.cache/copilot)" "Não instalado (C-c C-i)")
          :copilot-server-ok copilot-srv-ok
          :copilot-chat (if copilot-chat-ok "Carregado" "Disponível sob demanda")
          :agy-pkg agy-pkg
          :agy-cfg (if agy-cfg-ok "Presente (~/.gemini/antigravity-cli)" "Padrão")
          :menu-ias-ok (not (null menu-ias)))))

(defun fzl/dashboard--network-status ()
  "Retorna status da VPN UNESP e servidor remoto."
  (let* ((vpn-active (or (file-exists-p "/sys/class/net/tun0")
                         (and (fboundp 'fzl-vpn-running-p) (fzl-vpn-running-p))))
         (remote-host (or (bound-and-true-p fzl/remote-unesp-host) "200.145.9.174"))
         (remote-user (or (bound-and-true-p fzl/remote-unesp-user) "wgn"))
         (sql-profiles (if (boundp 'fzl-sql-env-profiles) (length fzl-sql-env-profiles) 0)))
    (list :vpn-active vpn-active
          :vpn (if vpn-active "Conectada (tun0 ativa)" "Inativa (Conecte via C-c d v c)")
          :remote-host (format "%s@%s" remote-user remote-host)
          :sql-profiles sql-profiles)))

(defun fzl/dashboard--system-status ()
  "Retorna parâmetros básicos do sistema Emacs."
  (let* ((server-ok (and (fboundp 'server-running-p) (server-running-p)))
         (view-strat (or (and (boundp 'fzl/startup-view-strategy) fzl/startup-view-strategy)
                         "ibuffer-and-dired"))
         (font-name (or (and (boundp 'fzl/font-family) fzl/font-family) "FiraCode Nerd Font Mono"))
         (font-ok (find-font (font-spec :name font-name))))
    (list :version (format "%s (%s)" emacs-version (if (featurep 'native-compile) "Native-comp" "Byte-code"))
          :server (if server-ok "Ativo (emacsclient pronto)" "Inativo")
          :server-ok server-ok
          :view-strategy (format "%s" view-strat)
          :font (if font-ok (format "%s [OK]" font-name) (format "%s [Não encontrada]" font-name)))))

;;; ============================================================================
;;; Renderização do Painel
;;; ============================================================================

(defun fzl/dashboard--render ()
  "Renderiza o conteúdo do dashboard no buffer atual."
  (let ((inhibit-read-only t)
        (buku (fzl/dashboard--buku-status))
        (ai (fzl/dashboard--ai-status))
        (net (fzl/dashboard--network-status))
        (sys (fzl/dashboard--system-status)))
    (erase-buffer)
    (insert "================================================================================\n")
    (insert "                    🚀 FZL Emacs — Status das Features\n")
    (insert "================================================================================\n\n")

    ;; 1. Bookmarks & Buku
    (insert "  [🔖 Bookmarks & Buku]\n")
    (insert (format "    • CLI Buku:         %s\n"
                    (if (plist-get buku :bin-ok)
                        (propertize (format "[OK] %s" (plist-get buku :bin)) 'face 'success)
                      (propertize "[--] Não encontrado no PATH" 'face 'warning))))
    (insert (format "    • Banco SQLite:     %s%s\n"
                    (if (plist-get buku :db-ok)
                        (propertize (format "[OK] %s" (plist-get buku :db)) 'face 'success)
                      (propertize "[--] Banco ainda não criado" 'face 'warning))
                    (if (plist-get buku :count)
                        (format " (%d favoritos cadastrados)" (plist-get buku :count))
                      "")))
    (insert (format "    • Sincronização:    %s\n"
                    (if (plist-get buku :sync-ok)
                        (propertize (format "[OK] %s" (plist-get buku :sync)) 'face 'success)
                      (propertize "[--] Inativa" 'face 'font-lock-comment-face))))
    (insert (propertize "      Atalhos: C-c d b s (Buscar) | C-c d b a (Adicionar) | C-c d b b (Gerenciador)\n\n"
                        'face 'font-lock-comment-face))

    ;; 2. Inteligências Artificiais
    (insert "  [🤖 Inteligências Artificiais]\n")
    (insert (format "    • Menu IAs:         %s\n"
                    (if (plist-get ai :menu-ias-ok)
                        (propertize "[OK] Instalado na barra global (global-map)" 'face 'success)
                      (propertize "[--] Não registrado" 'face 'warning))))
    (insert (format "    • Antigravity CLI:  %s (%s)\n"
                    (if (plist-get ai :agy-pkg)
                        (propertize "[OK] Módulo carregado" 'face 'success)
                      (propertize "[--] Não carregado" 'face 'warning))
                    (plist-get ai :agy-cfg)))
    (insert (format "    • GitHub Copilot:   %s\n"
                    (if (plist-get ai :copilot-server-ok)
                        (propertize (format "[OK] %s" (plist-get ai :copilot-server)) 'face 'success)
                      (propertize (format "[--] %s" (plist-get ai :copilot-server)) 'face 'warning))))
    (insert (format "    • Copilot Chat:     %s\n"
                    (propertize (format "[OK] %s" (plist-get ai :copilot-chat)) 'face 'success)))
    (insert (propertize "      Atalhos: C-c a (Antigravity) | C-c C-l (Copilot Login) | Menu [IAs]\n\n"
                        'face 'font-lock-comment-face))

    ;; 3. Rede & UNESP
    (insert "  [🌐 Rede & Servidores UNESP]\n")
    (insert (format "    • VPN UNESP:        %s\n"
                    (if (plist-get net :vpn-active)
                        (propertize "[OK] Conectada (tun0 ativa)" 'face 'success)
                      (propertize "[--] Inativa (Pressione C-c d v c para conectar)" 'face 'warning))))
    (insert (format "    • Servidor Remoto:  %s\n"
                    (propertize (format "[OK] %s configurado (TRAMP / SSH)" (plist-get net :remote-host)) 'face 'success)))
    (insert (format "    • Conexões SQL:     %s\n"
                    (propertize (format "[OK] %d perfil(is) carregados do .env" (plist-get net :sql-profiles)) 'face 'success)))
    (insert (propertize "      Atalhos: C-c d v c (Conectar VPN) | C-c d s d (Dired Remoto) | C-c d s m (Magit)\n\n"
                        'face 'font-lock-comment-face))

    ;; 4. Sistema
    (insert "  [⚙️ Sistema & Ambiente]\n")
    (insert (format "    • GNU Emacs:        %s\n" (plist-get sys :version)))
    (insert (format "    • Emacs Server:     %s\n"
                    (if (plist-get sys :server-ok)
                        (propertize (format "[OK] %s" (plist-get sys :server)) 'face 'success)
                      (propertize "[--] Inativo" 'face 'warning))))
    (insert (format "    • Fonte Padrão:     %s\n" (plist-get sys :font)))
    (insert (format "    • Estratégia View:  %s\n\n" (plist-get sys :view-strategy)))

    (insert "================================================================================\n")
    (insert (propertize "  [q] Fechar painel   |   [g] Atualizar status   |   [h] Ajuda\n"
                        'face 'font-lock-keyword-face))
    (insert "================================================================================\n")
    (goto-char (point-min))))

;;;###autoload
(defun fzl/dashboard-show ()
  "Exibe o painel de status das features do FZL Emacs."
  (interactive)
  (let ((buf (get-buffer-create fzl/dashboard-buffer-name)))
    (with-current-buffer buf
      (fzl-dashboard-mode)
      (fzl/dashboard--render))
    (pop-to-buffer buf)
    (message "FZL Dashboard atualizado. Pressione 'q' para fechar ou 'g' para atualizar.")))

;;;###autoload
(defun fzl/dashboard-refresh ()
  "Atualiza as informações do painel atual."
  (interactive)
  (when (get-buffer fzl/dashboard-buffer-name)
    (with-current-buffer (get-buffer fzl/dashboard-buffer-name)
      (fzl/dashboard--render)
      (message "Painel FZL Dashboard atualizado com sucesso."))))

(provide 'fzl-dashboard)
;;; fzl-dashboard.el ends here
