# Feature: Persistência dos Bookmarks Buku em Texto (`bookmarks.sql`)

- **Status**: Completed
- **Date**: 2026-11-05
- **Author/Agent**: Claude Code (Claude Opus 5.5)
- **Target Components**: `main/src/lispsite/fzl-buku-sync.el`, `main/src/lispsite/desktoping-apps.el`, `bookmarks/`
- **Document Path**: `docs/features/buku-text-persistence.md`

---

## 1. Goal & Overview

### 1.1 Objective
Versionar os bookmarks do Buku em um arquivo **texto** (`bookmarks/bookmarks.sql`, uma linha por bookmark) em vez do binário SQLite (`bookmarks/bookmarks.db`). O `.db` passa a ser um cache local, ignorado pelo git, reconstruído a partir do `.sql`.

### 1.2 Motivation
- Arquivo binário no git não tem diff nem merge: cada alteração simultânea em duas máquinas gera conflito manual (como ocorreu no rebase de 2026-11-05).
- Em texto, `git diff` mostra exatamente quais bookmarks mudaram, e alterações em máquinas diferentes se mesclam automaticamente.
- Transparente para o usuário do Emacs: ele continua usando buku/ebuku/menus/extensão do navegador normalmente; a sincronização `.db` ⇄ `.sql` é automática.

### 1.3 Design
- **Formato**: cabeçalho com `CREATE TABLE IF NOT EXISTS` + uma linha `INSERT OR REPLACE ... VALUES(...)` por bookmark, **sem a coluna `id`** (evita colisão de ids entre máquinas), ordenadas por `id`. Quebras de linha em campos viram `char(10)`, garantindo uma linha por registro.
- **Merge no git**: `.gitattributes` com `merge=union` para o `.sql` → `git pull` nunca para em conflito; URLs duplicadas resultantes são resolvidas pelo `INSERT OR REPLACE` e normalizadas na próxima sincronização.
- **Sincronização (3 vias)**: um arquivo local `bookmarks/.bookmarks.sync-base.sql` (ignorado) guarda o último estado sincronizado. Comparando dump do `.db` (D), `.sql` (S) e base (B):
  - D = S → nada a fazer;
  - S = B → só o `.db` mudou → regrava `.sql`;
  - D = B → só o `.sql` mudou (ex.: `git pull`) → reconstrói `.db`;
  - ambos mudaram (ou sem base) → `git merge-file --union` e reconstrói ambos (nenhum registro é perdido).
- **Gatilhos**: ao iniciar o Emacs (ao carregar o módulo) e a cada alteração em `bookmarks.db` ou `bookmarks.sql` detectada via `file-notify` (cobre buku CLI, ebuku, menus e a extensão do navegador), com debounce.
- **Segurança**: se a leitura do `.db` falhar, nada é sobrescrito; o `.db` é reconstruído em arquivo novo e só então renomeado (atômico).

### 1.4 Scope & Acceptance Criteria
- [x] `bookmarks/bookmarks.sql` versionado com todos os 59 bookmarks atuais.
- [x] `bookmarks/bookmarks.db` removido do índice do git e ignorado.
- [x] Ao iniciar o Emacs sem `.db`, ele é criado a partir do `.sql`.
- [x] Alterar bookmarks via buku atualiza o `.sql` automaticamente.
- [x] Alterar o `.sql` (ex.: `git pull`) reconstrói o `.db` automaticamente.
- [x] Alterações concorrentes nos dois lados são mescladas sem perda.
- [x] Comando manual `M-x fzl-buku-sync-now` / `C-c d b y` / item de menu.

---

## 2. Task Breakdown & Justifications

### Task 1: Módulo `fzl-buku-sync.el`
- **Status**: [x] Completed
- **Justification**: Isolar a lógica de serialização/sincronização em um módulo próprio mantém `desktoping-apps.el` (já com ~1500 linhas) focado em menus/comandos e facilita testar a sincronização em `emacs --batch`.

### Task 2: Integração em `desktoping-apps.el`
- **Status**: [x] Completed
- **Justification**: O caminho do banco era resolvido só se o `.db` existisse; numa máquina nova só existirá o `.sql`, então a detecção precisa considerar o diretório `bookmarks/`. Também é preciso ativar o modo de sincronização na inicialização e expor um comando manual no menu/atalho.

### Task 3: Configuração do git (`.gitignore`, `.gitattributes`)
- **Status**: [x] Completed
- **Justification**: O `.db` e os arquivos auxiliares (base de sincronização, `.db.new`) não devem ir para o repositório; `merge=union` faz o git mesclar o `.sql` sem conflitos.

### Task 4: Migração e verificação
- **Status**: [x] Completed
- **Justification**: Gerar o `.sql` inicial a partir do banco atual, remover o `.db` do índice e provar com testes em `--batch` que os quatro cenários de sincronização funcionam sem perda.

---

## 3. What Was Done

### Arquivos criados/modificados
| Arquivo | Alteração |
|---|---|
| `main/src/lispsite/fzl-buku-sync.el` | **Novo.** Dump `.db`→`.sql` (via `sqlite3 -readonly`), rebuild atômico `.sql`→`.db` (`.db.new` + rename), sincronização 3 vias com `git merge-file --union`, `fzl-buku-sync-mode` (watcher `file-notify` no diretório, debounce 2 s), comando `fzl-buku-sync-now`. |
| `main/src/lispsite/desktoping-apps.el` | Detecção do caminho pelo diretório `bookmarks/` (não mais pela existência do `.db`); `(require 'fzl-buku-sync)` + `(fzl-buku-sync-mode 1)` ao carregar; atalho `C-c d b y`; item de menu *Sync bookmarks.db <-> bookmarks.sql*. |
| `bookmarks/bookmarks.sql` | **Novo, versionado.** 59 bookmarks, um por linha. |
| `bookmarks/bookmarks.db` | Removido do índice (`git rm --cached`); continua no disco como cache local. |
| `.gitignore` | Removidas as exceções `!bookmarks/bookmarks.db` e `!bookmarks/*.db`; ignorados `bookmarks/*.db.new` e `bookmarks/.bookmarks.sync-base.sql`. |
| `.gitattributes` | **Novo.** `bookmarks/bookmarks.sql merge=union`. |

### Comandos executados
```bash
emacs -Q --batch -L main/src/lispsite --eval '(byte-compile-file ".../fzl-buku-sync.el")'   # sem warnings
emacs -Q --batch -L main/src/lispsite --eval "(progn (require 'fzl-buku-sync) ... (fzl-buku-sync-run))"
#  => Buku: bookmarks.sql atualizado (59 favoritos)
git rm --cached bookmarks/bookmarks.db
git add bookmarks/bookmarks.sql .gitignore .gitattributes
```

### Verificação (`emacs --batch`, em cópia do banco no scratchpad)
```
1 db only -> sql criado                       PASS
  sql tem 59 linhas                           PASS
  segunda execucao in-sync                    PASS
2 sem db -> db criado do sql                  PASS
  conteudo identico ao original               PASS
3 db alterado (buku) -> sql atualizado        PASS
  sql continua 1 linha por registro           PASS
4 sql alterado (git pull) -> db recarregado   PASS
  b.example no db                             PASS
  newline/aspas preservados                   PASS
5 delete vindo do sql -> removido do db       PASS
6 ambos mudaram -> merge                      PASS
  local e remoto presentes                    PASS
  depois in-sync                              PASS
7 URL duplicada (merge=union) -> normalizado  PASS
8 db corrompido -> sql NAO sobrescrito        PASS
watcher db->sql                               PASS
watcher sql->db                               PASS
```
`(require 'desktoping-apps)` em `emacs -Q --batch` carrega sem erros com `fzl-buku-sync-mode` = `t`.

### Observações
- Após um rebuild a partir do `.sql`, os `id`s do buku são renumerados na ordem do arquivo (os `id`s não são versionados de propósito).
- Na primeira sincronização em outra máquina (sem arquivo de base), `.db` e `.sql` são unidos: nada se perde, mas um bookmark apagado só no outro lado pode reaparecer uma vez.
- Requer `sqlite3` e `git` no `PATH`; sem `sqlite3` o modo apenas avisa e não faz nada.
