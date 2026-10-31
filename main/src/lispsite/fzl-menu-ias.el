;;; fzl-menu-ias.el --- Unified AI menu (Antigravity & Copilot) -*- lexical-binding: t; -*-

;;; Commentary:
;; Este módulo define o menu de nível superior "IAs" no Emacs (`global-map`),
;; consolidando as ferramentas de Inteligência Artificial:
;; - Submenu "Antigravity": Controle remoto do Antigravity CLI (agy).
;; - Submenu "Copilot": Ações de Completions, Chat, Ações de Código, Git e Servidor.

;;; Code:

(require 'easymenu)

(defconst fzl/menu-ias-definition
  '("IAs"
    ;; =========================================================================
    ;; Submenu: Antigravity
    ;; =========================================================================
    ("Antigravity"
     ["Iniciar Sessão Remota na Pasta (Treemacs/Dired) (C-c a s)" fzl/agy-remote-start
      :enable (fboundp 'fzl/agy-remote-start)
      :help "Registra a pasta atual/selecionada e inicia a sessão remota no Antigravity"]
     ["Iniciar Sessão no Diretório de Trabalho do Dired (C-c a S)" fzl/agy-remote-start-dired-workdir
      :visible (derived-mode-p 'dired-mode)
      :enable (fboundp 'fzl/agy-remote-start-dired-workdir)
      :help "Inicia a sessão remota na pasta do buffer Dired atual"]
     ["Iniciar Sessão Interativa no Emacs (C-c a i)" fzl/agy-remote-start-interactive
      :enable (fboundp 'fzl/agy-remote-start-interactive)
      :help "Abre terminal interativo com a CLI agy dentro do Emacs"]
     ["Alternar (Start/Stop) na Pasta Atual (C-c a t)" fzl/agy-remote-toggle
      :enable (fboundp 'fzl/agy-remote-toggle)
      :help "Inicia ou para a sessão remota para a pasta atual"]
     "--"
     ["Parar Sessão Remota (C-c a k)" fzl/agy-remote-stop
      :enable (fboundp 'fzl/agy-remote-stop)
      :help "Encerra o processo remoto do Antigravity na pasta"]
     ["Parar TODAS as Sessões Remotas (C-c a K)" fzl/agy-remote-stop-all
      :enable (fboundp 'fzl/agy-remote-stop-all)
      :help "Encerra todos os processos remotos agy ativos"]
     "--"
     ["Status das Sessões Ativas (C-c a l)" fzl/agy-remote-status
      :enable (fboundp 'fzl/agy-remote-status)
      :help "Exibe status e sessões ativas do Antigravity CLI"]
     ["Ver Buffer de Log/Terminal (C-c a b)" fzl/agy-remote-open-buffer
      :enable (fboundp 'fzl/agy-remote-open-buffer)
      :help "Abre o buffer de logs/terminal do agy"]
     ["Abrir Painel Web Remote Control (C-c a w)" fzl/agy-remote-open-web
      :enable (fboundp 'fzl/agy-remote-open-web)
      :help "Abre https://antigravity.google.com no navegador"])

    ;; =========================================================================
    ;; Submenu: Copilot
    ;; =========================================================================
    ("Copilot"
     ;; --- Completions ---
     ("Completions"
      ["Ativar / Desativar Copilot Mode" copilot-mode
       :style toggle
       :selected (bound-and-true-p copilot-mode)
       :help "Alterna autocompletion do GitHub Copilot no buffer atual"]
      ["Aceitar Sugestão Completa (TAB)" copilot-accept-completion
       :enable (fboundp 'copilot-accept-completion)
       :help "Aceita a sugestão de código atual exibida pelo Copilot"]
      ["Aceitar por Palavra" copilot-accept-completion-by-word
       :enable (fboundp 'copilot-accept-completion-by-word)
       :help "Aceita apenas a próxima palavra da sugestão atual"]
      ["Aceitar por Linha" copilot-accept-completion-by-line
       :enable (fboundp 'copilot-accept-completion-by-line)
       :help "Aceita apenas a próxima linha da sugestão atual"]
      ["Próxima Sugestão (C-n)" copilot-next-completion
       :enable (fboundp 'copilot-next-completion)
       :help "Cicla para a próxima sugestão alternativa"]
      ["Sugestão Anterior (C-p)" copilot-previous-completion
       :enable (fboundp 'copilot-previous-completion)
       :help "Retorna para a sugestão alternativa anterior"]
      ["Limpar Sugestão (C-c C-c)" copilot-clear-overlay
       :enable (fboundp 'copilot-clear-overlay)
       :help "Remove a sobreposição de sugestão ativa"])

     ;; --- Chat & Assistente ---
     ("Chat & Assistente"
      ["Abrir Copilot Chat" copilot-chat-display
       :enable (fboundp 'copilot-chat-display)
       :help "Abre o painel interativo de chat do Copilot"]
      ["Menu Rápido Transient (copilot-chat)" copilot-chat-transient
       :enable (fboundp 'copilot-chat-transient)
       :help "Abre o menu transient magit-style do Copilot Chat"]
      ["Menu Geral Copilot (copilot-menu)" copilot-menu
       :enable (fboundp 'copilot-menu)
       :help "Abre o menu transient geral de autocompletion e chat"]
      ["Perguntar e Inserir no Ponto" copilot-chat-ask-and-insert
       :enable (fboundp 'copilot-chat-ask-and-insert)
       :help "Solicita prompt no minibuffer e insere a resposta na posição do cursor"]
      "--"
      ["Selecionar Modelo de IA" copilot-chat-set-model
       :enable (fboundp 'copilot-chat-set-model)
       :help "Configura o modelo de linguagem utilizado pelo Chat"]
      ["Resetar Lista de Modelos" copilot-chat-reset-models
       :enable (fboundp 'copilot-chat-reset-models)
       :help "Recarrega a lista de modelos de linguagem disponíveis"])

     ;; --- Ações no Código ---
     ("Ações no Código"
      ["Explicar Código Selecionado" copilot-chat-explain
       :enable (fboundp 'copilot-chat-explain)
       :help "Explica o funcionamento do código na região selecionada"]
      ["Explicar Função Atual (Defun)" copilot-chat-explain-defun
       :enable (fboundp 'copilot-chat-explain-defun)
       :help "Explica a definição da função sob o cursor"]
      ["Revisar Código Selecionado" copilot-chat-review
       :enable (fboundp 'copilot-chat-review)
       :help "Gera revisão técnica e sugestões para a região selecionada"]
      ["Revisar Todo o Buffer" copilot-chat-review-whole-buffer
       :enable (fboundp 'copilot-chat-review-whole-buffer)
       :help "Realiza revisão completa do arquivo atual"]
      ["Gerar Documentação (Docstring)" copilot-chat-doc
       :enable (fboundp 'copilot-chat-doc)
       :help "Gera comentários de documentação para a função ou bloco selecionado"]
      ["Corrigir Bugs / Erros" copilot-chat-fix
       :enable (fboundp 'copilot-chat-fix)
       :help "Sugere correções de bugs no código selecionado"]
      ["Otimizar Código" copilot-chat-optimize
       :enable (fboundp 'copilot-chat-optimize)
       :help "Propõe melhorias de performance e legibilidade"]
      ["Gerar Testes Unitários" copilot-chat-test
       :enable (fboundp 'copilot-chat-test)
       :help "Cria testes unitários para o código selecionado"])

     ;; --- Git & Controle de Versão ---
     ("Git & Controle de Versão"
      ["Gerar Mensagem de Commit" copilot-chat-insert-commit-message
       :enable (fboundp 'copilot-chat-insert-commit-message)
       :help "Gera e insere mensagem de commit com base nas alterações git"]
      ["Regenerar Mensagem de Commit" copilot-chat-regenerate-commit-message
       :enable (fboundp 'copilot-chat-regenerate-commit-message)
       :help "Gera uma versão alternativa da mensagem de commit"]
      ["Definir Modelo para Mensagens de Commit" copilot-chat-set-commit-model
       :enable (fboundp 'copilot-chat-set-commit-model)
       :help "Escolhe o modelo de IA específico para geração de commits"])

     ;; --- Conta & Servidor ---
     ("Conta & Servidor"
      ["Fazer Login no GitHub Copilot" fzl/pkgconfig/copilot-login
       :enable (fboundp 'copilot-login)
       :help "Inicia o fluxo de autenticação por dispositivo (OAuth)"]
      ["Fazer Logout do GitHub Copilot" copilot-logout
       :enable (fboundp 'copilot-logout)
       :help "Desconecta da conta do GitHub Copilot"]
      ["Instalar / Atualizar Servidor Copilot" fzl/pkgconfig/copilot-install-server
       :enable (fboundp 'copilot-install-server)
       :help "Instala ou atualiza o binário do copilot-language-server via npm"]
      ["Diagnóstico e Reinício do Servidor" copilot-diagnose
       :enable (fboundp 'copilot-diagnose)
       :help "Executa diagnóstico do language server e reinicia a conexão"])))
  "Definição do menu unificado 'IAs' para Emacs.")

;; Define e instala o menu na barra global
(easy-menu-define fzl/ai-menu global-map "Menu de Inteligência Artificial (IAs)." fzl/menu-ias-definition)

(provide 'fzl-menu-ias)
;;; fzl-menu-ias.el ends here
