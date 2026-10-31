# Feature: Menu Unificado de Inteligência Artificial (IAs)

- **Status**: Completed
- **Date**: 2026-10-30
- **Author/Agent**: Antigravity (Gemini)
- **Target Components**: `fzl-emacs` UI / Menus (`main/src/lispsite`)
- **Document Path**: `docs/features/ias-unified-menu.md`

---

## 1. Goal & Overview

### 1.1 Objective
Criar um menu principal no Emacs intitulado **`IAs`** na barra de menus global (`global-map`), consolidando sob ele as ferramentas de inteligência artificial disponíveis no ambiente `fzl-emacs`:
1. Submenu **`Antigravity`**: migrar as ações atuais de controle remoto do Antigravity CLI (`agy`) para dentro de `IAs`.
2. Submenu **`Copilot`**: submenu irmão de `Antigravity`, agregando de forma estruturada e intuitiva as funcionalidades do GitHub Copilot e Copilot Chat (Completions, Chat & Assistente, Ações no Código, Git & Commits, Conta & Servidor).

### 1.2 Motivation & Business/Technical Value
Atualmente, as funcionalidades do Antigravity ocupavam uma entrada de nível superior separada na barra de menus, enquanto as opções do GitHub Copilot ficavam dispersas apenas em atalhos de teclado ou comandos `M-x`. A unificação sob o menu `IAs` organiza a experiência do desenvolvedor, tornando todos os recursos de IA facilmente descobríveis e acessíveis visualmente tanto em modo gráfico quanto via terminal (`F10`).

### 1.3 Scope & Acceptance Criteria
- [x] O menu de nível superior `IAs` aparece na barra de menus (`global-map`).
- [x] O submenu `Antigravity` reside dentro de `IAs` com todas as funcionalidades de controle de sessão remota preservadas.
- [x] O submenu `Copilot` reside dentro de `IAs` no mesmo nível de `Antigravity`.
- [x] O submenu `Copilot` contém submenus organizados por categoria de uso:
  - **Completions** (ativar/desativar, aceitar, navegar sugestões, aceitar por palavra/linha, limpar overlay).
  - **Chat & Assistente** (abrir chat, interface transient rápida, perguntar e inserir, seleção de modelo).
  - **Ações no Código** (explicar código/função, revisar seleção/buffer, gerar docstrings, corrigir bugs, otimizar, gerar testes).
  - **Git & Controle de Versão** (geração e regeneração de mensagens de commit).
  - **Conta & Servidor** (login, logout, instalar/atualizar servidor, diagnóstico).
- [x] O menu não causa regressões na inicialização do Emacs e carrega sem erros de sintaxe.

---

## 2. Task Breakdown & Justifications

### Task 1: Criar Módulo Dedicado para o Menu `IAs` (`fzl-menu-ias.el`)
- **Status**: [x] Completed
- **Justification**: Centralizar a especificação do menu `IAs` em um módulo modular e desacoplado (`fzl-menu-ias.el`) evita poluição em múltiplos arquivos e garante fácil manutenção e extensão para futuras IAs.
- **Affected Components/Files**:
  - `main/src/lispsite/fzl-menu-ias.el`
- **What Was Done**:
  - Criado o arquivo `main/src/lispsite/fzl-menu-ias.el`.
  - Definido `fzl/menu-ias-definition` usando `easymenu`, contendo a estrutura `IAs` -> `Antigravity` e `IAs` -> `Copilot`.
  - Estruturado `Copilot` com 5 submenus (`Completions`, `Chat & Assistente`, `Ações no Código`, `Git & Controle de Versão`, `Conta & Servidor`).
  - Instalado o menu na barra global via `(easy-menu-define fzl/ai-menu global-map ... fzl/menu-ias-definition)`.

### Task 2: Atualizar `pkgconfig-antigravity.el` para Integrar ao `IAs`
- **Status**: [x] Completed
- **Justification**: Remover a definição isolada do menu de nível superior "Antigravity" em `pkgconfig-antigravity.el` para evitar duplicidade de itens na barra global, mantendo a compatibilidade dos comandos e atalhos (`C-c a`).
- **Affected Components/Files**:
  - `main/src/lispsite/pkgconfig-antigravity.el`
- **What Was Done**:
  - Removido `(easy-menu-define fzl/agy-menu global-map ...)` de `pkgconfig-antigravity.el`.
  - Adicionado comentário indicando a migração centralizada das opções para `fzl-menu-ias.el`.
  - Mantidos intactos todos os atalhos (`C-c a`) e funções de controle remoto.

### Task 3: Conectar o Menu no Carregamento Principal (`init.el`)
- **Status**: [x] Completed
- **Justification**: Garantir que o novo menu seja carregado na ordem correta da inicialização do Emacs, após as dependências de `pkgconfig-antigravity` e `pkgconfig-copilot`.
- **Affected Components/Files**:
  - `main/src/lispsite/init.el`
- **What Was Done**:
  - Adicionado `(require 'fzl-menu-ias)` logo após o bloco do `pkgconfig-copilot` no `init.el`.

### Task 4: Verificação e Testes de Inicialização
- **Status**: [x] Completed
- **Justification**: Validar sintaxe Elisp e ausência de erros em lote e modo interativo para garantir que o Emacs inicia com sucesso.
- **Affected Components/Files**:
  - `main/src/lispsite/fzl-menu-ias.el`
  - `main/src/lispsite/init.el`
- **What Was Done**:
  - Executado teste em batch mode validando carregamento com código de saída 0.
  - Executada verificação de keymaps via script Elisp inspecionando `[menu-bar IAs]`, confirmando a presença de todos os submenus esperados.

---

## 3. Verification & Validation

### 3.1 Test Scenarios
- [x] Test Scenario 1: Carregamento do arquivo `fzl-menu-ias.el` em batch mode
  - **Expected Outcome**: Arquivo carrega com código de saída 0 sem warnings ou erros de sintaxe.
  - **Actual Result**: `fzl-menu-ias loaded successfully!` (código 0).
- [x] Test Scenario 2: Inspecionar estrutura de submenus no `global-map`
  - **Expected Outcome**: Keymaps `[menu-bar IAs]`, `[Antigravity]`, `[Copilot]` e seus submenus registrados corretamente.
  - **Actual Result**:
    ```text
    Antigravity submenu: OK
    Copilot submenu: OK
      - Completions: OK
      - Chat & Assistente: OK
      - Ações no Código: OK
      - Git & Controle: OK
      - Conta & Servidor: OK
    ```

---

## 4. Execution Summary & Deliverables

### 4.1 Summary of Changes
- Criado o módulo `main/src/lispsite/fzl-menu-ias.el` que consolida os assistentes de IA sob o menu `IAs`.
- Submenu `Antigravity` migrado para dentro de `IAs`, mantendo todas as funcionalidades do remote control CLI (`agy`).
- Submenu `Copilot` introduzido com suporte a autocompletion, chat interativo, ações inteligentes em código, geração de commits git e administração de servidor/login.
- `init.el` e `pkgconfig-antigravity.el` devidamente integrados sem qualquer conflito ou regressão.
