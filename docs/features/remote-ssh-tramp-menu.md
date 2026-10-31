# Feature: Integração de Servidor Remoto UNESP (SSH / TRAMP) com Dired, Magit e Menus

- **Status**: Completed
- **Date**: 2026-10-30
- **Author/Agent**: Antigravity (Gemini)
- **Target Components**: `fzl-emacs` (`main/src/lispsite/fzl-remote-unesp.el`, `desktoping-apps.el`, `init.el`)
- **Document Path**: `docs/features/remote-ssh-tramp-menu.md`

---

## 1. Goal & Overview

### 1.1 Objective
Implementar um módulo de integração remota via SSH/TRAMP para o servidor de trabalho UNESP (`200.145.9.174`), fornecendo comandos interativos e atalhos no menu do Emacs para:
1. Abrir **Dired** remotamente no diretório home do usuário (`/ssh:wgn@200.145.9.174:/home/wgn/`) ou em diretório escolhido via prompt.
2. Abrir **Magit Status** remotamente em qualquer repositório Git hospedado no servidor.
3. Abrir arquivos remotos (`find-file`) diretamente no servidor remoto via TRAMP.
4. Abrir sessão de **Terminal SSH** dedicada no Emacs.
5. Verificar conectividade/status de rede (alertando caso a VPN da UNESP esteja desconectada).
6. Integrar as ações ao menu `Desktoping` e mapa de teclas `C-c d s`.

### 1.2 Motivation & Business/Technical Value
O usuário acessa frequentemente o servidor `200.145.9.174` via SSH. O acesso manual via linha de comando frequentemente sofre com timeouts caso a VPN UNESP não esteja conectada, e a navegação por arquivos e controle de versão no servidor exigem múltiplos comandos manuais de terminal. Com o TRAMP nativo do Emacs e a integração no menu `Desktoping`, o usuário passa a ter navegação visual no Dired, edição remota transparente e painel completo do Magit em apenas 1 clique ou atalho de teclado.

### 1.3 Scope & Acceptance Criteria
- [x] Módulo `fzl-remote-unesp.el` criado com variáveis configuráveis de host, usuário e diretório padrão.
- [x] Função `fzl/remote-unesp-dired` para abrir o Dired remoto via caminho TRAMP `/ssh:wgn@200.145.9.174:...`.
- [x] Função `fzl/remote-unesp-magit` para disparar o `magit-status` em repositórios remotos.
- [x] Função `fzl/remote-unesp-find-file` para abrir arquivos diretamente na máquina remota.
- [x] Função `fzl/remote-unesp-terminal` para abrir terminal SSH interativo.
- [x] Função `fzl/remote-unesp-check-connection` para checar rota/VPN antes de abrir a conexão.
- [x] Submenu `"Servidor Remoto UNESP (SSH / TRAMP)"` integrado ao menu `"Desktoping"`.
- [x] Teclas de atalho sob o prefixo `C-c d s` configuradas.
- [x] Carregamento sem erros de compilação ou regressões no startup do Emacs.

---

## 2. Task Breakdown & Justifications

### Task 1: Criar Módulo `fzl-remote-unesp.el`
- **Status**: [x] Completed
- **Justification**: Centraliza toda a lógica de TRAMP, caminhos remotos, validação de conectividade VPN e comandos interativos para o servidor UNESP em um componente limpo e reutilizável.
- **Affected Components/Files**:
  - `main/src/lispsite/fzl-remote-unesp.el`
- **What Was Done**:
  - Criado o arquivo `main/src/lispsite/fzl-remote-unesp.el`.
  - Definidas opções customizáveis `fzl/remote-unesp-host`, `fzl/remote-unesp-user` e `fzl/remote-unesp-default-dir`.
  - Implementadas as funções `fzl/remote-unesp-dired`, `fzl/remote-unesp-find-file`, `fzl/remote-unesp-magit`, `fzl/remote-unesp-terminal` e `fzl/remote-unesp-check-connection`.
  - Adicionado alerta automático caso a interface `tun0` (VPN UNESP) esteja desconectada.

### Task 2: Integrar Comandos e Submenu ao `desktoping-apps.el`
- **Status**: [x] Completed
- **Justification**: O menu `Desktoping` já hospeda os controles de VPN da UNESP e terminais do sistema; adicionar o servidor remoto logo abaixo da VPN cria um fluxo de trabalho natural (conectar VPN -> abrir servidor).
- **Affected Components/Files**:
  - `main/src/lispsite/desktoping-apps.el`
- **What Was Done**:
  - Adicionado `(require 'fzl-remote-unesp nil t)`.
  - Mapeadas teclas `C-c d s d`, `C-c d s f`, `C-c d s m`, `C-c d s t` e `C-c d s c` em `desktoping-apps-map`.
  - Adicionado submenu `"Servidor Remoto UNESP (SSH / TRAMP)"` dentro de `"Desktoping"`.

### Task 3: Carregar Módulo no `init.el`
- **Status**: [x] Completed
- **Justification**: Registrar o novo módulo na sequência de inicialização do Emacs.
- **Affected Components/Files**:
  - `main/src/lispsite/init.el`
- **What Was Done**:
  - Adicionado `(require 'fzl-remote-unesp)` logo após `(require 'desktoping-apps)`.

### Task 4: Verificação e Validação Técnica
- **Status**: [x] Completed
- **Justification**: Assegurar sintaxe correta do Elisp, presença dos comandos no mapa de teclas e renderização correta do menu sem impactos no boot.
- **Affected Components/Files**:
  - `main/src/lispsite/*`
- **What Was Done**:
  - Teste de carregamento em batch mode executado com sucesso (código 0).
  - Validação de mapa de teclas e estrutura do submenu no `[menu-bar Desktoping]` confirmada.

---

## 3. Verification & Validation

### 3.1 Test Scenarios
- [x] Test Scenario 1: Carregamento dos módulos em batch mode
  - **Expected Outcome**: Código de saída 0 sem erros.
  - **Actual Result**: `SUCCESS: fzl-remote-unesp and desktoping-apps loaded cleanly!`.
- [x] Test Scenario 2: Verificação do submenu e atalhos de teclado
  - **Expected Outcome**: Submenu presente em `Desktoping` e teclas mapeadas para suas respectivas funções.
  - **Actual Result**:
    ```text
    Submenu in Desktoping: OK
    Key s d: fzl/remote-unesp-dired
    Key s f: fzl/remote-unesp-find-file
    Key s m: fzl/remote-unesp-magit
    Key s t: fzl/remote-unesp-terminal
    Key s c: fzl/remote-unesp-check-connection
    ```

---

## 4. Execution Summary & Deliverables

### 4.1 Summary of Changes
- Criado o módulo `fzl-remote-unesp.el` permitindo acesso remoto transparente ao servidor `200.145.9.174` via TRAMP.
- Habilitada navegação em diretórios remotos via Dired com suporte a edição direta de arquivos.
- Habilitado suporte completo ao Magit em repositórios remotos no servidor.
- Submenu `"Servidor Remoto UNESP (SSH / TRAMP)"` integrado logo abaixo de `"VPN Trabalho (UNESP)"` no menu `"Desktoping"`.
- Atalhos `C-c d s [d/f/m/t/c]` configurados.
