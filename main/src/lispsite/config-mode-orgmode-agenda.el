;;; config-mode-orgmode-agenda.el --- Org Agenda configuration and persistence -*- lexical-binding: t -*-

;;; Commentary:
;; Configures Org Agenda with persistence in external storage / git repository,
;; interactive fallback directory selection, and automated git sync (add/commit/push).

;;; Code:

(require 'org)
(require 'org-agenda)

(defgroup fzl-org-agenda nil
  "Configurações do Org Agenda no FZL Emacs."
  :group 'org)

(defcustom fzl-org-agenda-preferred-dir
  "/home/wgn/mnt/ext4/Projects-Srcs/Projects-Srcs-FzlSoft/fzl-tasktodayapp/persistence/emacs-org-agenda"
  "Caminho padrão preferencial para a persistência dos arquivos da agenda."
  :type 'directory
  :group 'fzl-org-agenda)

(defcustom fzl-org-agenda-file-name "agenda.org"
  "Nome do arquivo org padrão para compromissos e tarefas."
  :type 'string
  :group 'fzl-org-agenda)

(defvar fzl-org-agenda-active-dir nil
  "Diretório ativo selecionado para o Org Agenda na sessão.")

(defun fzl-org-agenda--candidate-dirs ()
  "Retorna lista de diretórios candidatos para a persistência da agenda."
  (delq nil
        (list
         fzl-org-agenda-preferred-dir
         ;; Caminho via partição /home/wgn/WORKING
         (expand-file-name "Projects-Srcs/Projects-Srcs-FzlSoft/fzl-tasktodayapp/persistence/emacs-org-agenda"
                           (or (and (bound-and-true-p externaldisk_partition2) externaldisk_partition2)
                               (expand-file-name "~/WORKING")))
         ;; Caminho via /run/media
         "/run/media/wgn/ext4/Projects-Srcs/Projects-Srcs-FzlSoft/fzl-tasktodayapp/persistence/emacs-org-agenda"
         ;; Fallback local do usuário
         (expand-file-name "~/.local/share/fzl-emacs/emacs-org-agenda"))))

(defun fzl-org-agenda-resolve-dir (&optional interactive)
  "Localiza o diretório de persistência ou solicita interativamente se não encontrado."
  (let ((found (seq-find #'file-directory-p (fzl-org-agenda--candidate-dirs))))
    (cond
     (found
      (setq fzl-org-agenda-active-dir found)
      found)
     (t
      (if (or interactive (called-interactively-p 'interactive))
          (fzl-org-agenda-prompt-for-dir)
        ;; Tentativa automática de criar o diretório preferencial se o caminho pai existir
        (let ((parent (file-name-directory (directory-file-name fzl-org-agenda-preferred-dir))))
          (if (and parent (file-directory-p parent))
              (progn
                (make-directory fzl-org-agenda-preferred-dir t)
                (setq fzl-org-agenda-active-dir fzl-org-agenda-preferred-dir)
                fzl-org-agenda-preferred-dir)
            ;; Caso contrário, usa fallback local seguro e avisa
            (let ((fallback (expand-file-name "~/.local/share/fzl-emacs/emacs-org-agenda")))
              (make-directory fallback t)
              (setq fzl-org-agenda-active-dir fallback)
              (message "Aviso Org-Agenda: HD externo não encontrado. Usando fallback local: %s (M-x fzl-org-agenda-set-directory para alterar)" fallback)
              fallback))))))))

(defun fzl-org-agenda-prompt-for-dir ()
  "Pergunta interativamente ao usuário qual diretório utilizar."
  (interactive)
  (let* ((default-choice (expand-file-name "Projects-Srcs/Projects-Srcs-FzlSoft/fzl-tasktodayapp/persistence/emacs-org-agenda"
                                           (or (and (bound-and-true-p externaldisk_partition2) externaldisk_partition2)
                                               (expand-file-name "~/WORKING"))))
         (dir (read-directory-name
               (format "Diretório de persistência do Org Agenda (Default: %s): " default-choice)
               nil default-choice t)))
    (unless (file-directory-p dir)
      (when (y-or-n-p (format "Diretório %s não existe. Deseja criá-lo? " dir))
        (make-directory dir t)))
    (setq fzl-org-agenda-active-dir dir)
    (fzl-org-agenda-init-file)
    (fzl-org-agenda-setup-agenda-files)
    (message "Org Agenda configurado para: %s" dir)
    dir))

(defun fzl-org-agenda-get-file ()
  "Retorna o caminho completo para o arquivo de agenda ativo."
  (let ((dir (or fzl-org-agenda-active-dir (fzl-org-agenda-resolve-dir))))
    (expand-file-name fzl-org-agenda-file-name dir)))

(defun fzl-org-agenda-init-file ()
  "Garante que o arquivo de agenda exista com modelo inicial."
  (let ((file (fzl-org-agenda-get-file)))
    (unless (file-exists-p file)
      (let ((dir (file-name-directory file)))
        (unless (file-directory-p dir)
          (make-directory dir t)))
      (with-temp-file file
        (insert "#+TITLE: FZL TaskToday - Compromissos & Tarefas Org Agenda\n")
        (insert "#+STARTUP: overview\n")
        (insert "#+CATEGORY: Geral\n\n")
        (insert "* Compromissos\n\n")
        (insert "* Tarefas Diárias\n")
        (insert "** TODO Bem-vindo ao Org Agenda no FZL Emacs\n")
        (insert (format "   SCHEDULED: <%s>\n" (format-time-string "%Y-%m-%d %a")))))
    file))

(defun fzl-org-agenda-setup-agenda-files ()
  "Registra o arquivo da agenda em `org-agenda-files`."
  (let ((file (fzl-org-agenda-init-file)))
    (unless (member file org-agenda-files)
      (setq org-agenda-files (list file)))))

(defun fzl-org-agenda-open-file ()
  "Abre o arquivo principal de compromissos do Org Agenda para edição."
  (interactive)
  (let ((file (fzl-org-agenda-get-file)))
    (find-file file)))

;;; ============================================================================
;;; Git Integration (Local check, Commit and Push)
;;; ============================================================================

(defun fzl-org-agenda--git-dir-p (dir)
  "Verifica se DIR está sob controle de versão Git."
  (when (and dir (file-directory-p dir))
    (let ((default-directory dir))
      (= 0 (call-process "git" nil nil nil "rev-parse" "--is-inside-work-tree")))))

(defun fzl-org-agenda-git-sync (&optional user-message)
  "Salva todos os buffers da agenda e faz git commit & push se o diretório for um repo git."
  (interactive)
  ;; Salva os arquivos de agenda abertos
  (org-save-all-org-buffers)
  (let* ((dir (or fzl-org-agenda-active-dir (fzl-org-agenda-resolve-dir)))
         (is-git (fzl-org-agenda--git-dir-p dir)))
    (if (not is-git)
        (message "Org-Agenda: O diretório %s não é um repositório Git. Arquivos salvos localmente." dir)
      (let* ((default-directory dir)
             (msg (or user-message
                      (format "chore(agenda): sync compromissos %s" (format-time-string "%Y-%m-%d %H:%M:%S"))))
             (cmd (format "git add %s && (git diff --cached --quiet || git commit -m %s) && git push origin HEAD"
                          (shell-quote-argument (fzl-org-agenda-get-file))
                          (shell-quote-argument msg))))
        (message "Org-Agenda: Sincronizando com Git...")
        (let ((output (shell-command-to-string cmd)))
          (message "Org-Agenda Git Sync concluído com sucesso!")
          (when (called-interactively-p 'interactive)
            (message "Git output: %s" (string-trim output))))))))

(defun fzl-org-agenda-open-today ()
  "Abre a visão diária da agenda (buffer *Org Agenda*)."
  (interactive)
  (fzl-org-agenda-setup-agenda-files)
  (org-agenda nil "a")
  (org-agenda-day-view))

;; Inicializa os arquivos da agenda ao carregar o módulo
(fzl-org-agenda-resolve-dir)
(fzl-org-agenda-setup-agenda-files)

(provide 'config-mode-orgmode-agenda)
;;; config-mode-orgmode-agenda.el ends here
