;;; (lexical-binding: t)
;;; package --- Summary
;;; Tesaurus a partir de arquivo JSON

;;; tesaurus_from_json.el --- Tesaurus a partir de arquivo JSON -*- coding: utf-8; -*-
;;; Commentary:
;;; Este arquivo define funções para carregar, navegar e buscar em um tesaurus

;;; Code:

;; Função para carregar o tesaurus do JSON com caminho completo
(defun fzl-carregar-tesaurus (arquivo)
  "Carrega o tesaurus de um arquivo JSON."
  (interactive)
  (let ((caminho-completo (expand-file-name arquivo)))
    (unless (file-exists-p caminho-completo)
      (error "Arquivo não encontrado: %s" caminho-completo))
    (with-temp-buffer
      (insert-file-contents caminho-completo)
      (let ((json-data (json-read-from-string (buffer-string))))
        json-data))))

;; Função para navegar no tesaurus
(defun navegar-tesaurus (tesaurus &optional nivel-pai)
  "Navega recursivamente pelo tesaurus imprimindo a estrutura."
  (interactive)
  (let ((nivel-atual (or nivel-pai 0)))
    (mapcar (lambda (item)
              (let* ((chave (car item))
                     (valor (cdr item))
                     (nivel (assoc-default 'nivel valor))
                     (descricao (assoc-default 'descricao valor))
                     (subtopicos (assoc-default 'subtopicos valor)))
                
                ;; Imprime o item atual com indentação
                (message "%s%s (Nível %d): %s"
                         (make-string (* nivel-atual 2) ? )
                         chave nivel descricao)
                
                ;; Processa subtópicos recursivamente
                (when subtopicos
                  (navegar-tesaurus subtopicos (1+ nivel-atual)))))
            tesaurus)))

;; Função para buscar um tópico específico
(defun buscar-topico (tesaurus topico &optional caminho)
  "Busca um tópico específico no tesaurus e retorna seu caminho."
  (interactive)
  (catch 'encontrado
    (mapcar (lambda (item)
              (let* ((chave (car item))
                     (valor (cdr item))
                     (novo-caminho (append caminho (list chave)))
                     (subtopicos (assoc-default 'subtopicos valor)))
                
                (when (string-equal chave topico)
                  (throw 'encontrado novo-caminho))
                
                (when subtopicos
                  (buscar-topico subtopicos topico novo-caminho))))
            tesaurus)
    nil))


;; Função para listar todos os tópicos de um nível específico
(defun listar-por-nivel (tesaurus nivel-desejado &optional nivel-atual)
  "Lista todos os tópicos de um nível específico."
  (interactive)
  (let ((nivel (or nivel-atual 1))
        (resultado '()))
    (mapcar (lambda (item)
              (let* ((chave (car item))
                     (valor (cdr item))
                     (subtopicos (assoc-default 'subtopicos valor)))
                
                (when (= nivel nivel-desejado)
                  (push (list chave (assoc-default 'descricao valor)) resultado))
                
                (when subtopicos
                  (setq resultado 
                        (append resultado 
                                (listar-por-nivel subtopicos nivel-desejado (1+ nivel)))))))
            tesaurus)
    resultado))


;; Função principal para exibir o tesaurus com caminho personalizável
(defun exibir-tesaurus (&optional caminho-arquivo)
  "Função principal para carregar e exibir o tesaurus.
Se CAMINHO-ARQUIVO não for fornecido, pede ao usuário."
  (interactive "fCaminho para o arquivo JSON do tesaurus: ")
  (let* ((arquivo (or caminho-arquivo "tesaurus.json"))
         (tesaurus (carregar-tesaurus arquivo)))
    (message "=== ESTRUTURA DO TESAURO (%s) ===" arquivo)
    (navegar-tesaurus tesaurus)
    
    (message "\n=== TÓPICOS DO NÍVEL 1 ===")
    (dolist (topico (listar-por-nivel tesaurus 1))
      (message "- %s: %s" (car topico) (cadr topico)))
    
    (message "\n=== TÓPICOS DO NÍVEL 2 ===")
    (dolist (topico (listar-por-nivel tesaurus 2))
      (message "- %s: %s" (car topico) (cadr topico)))
    
    (message "\n=== TÓPICOS DO NÍVEL 3 ===")
    (dolist (topico (listar-por-nivel tesaurus 3))
      (message "- %s: %s" (car topico) (cadr topico)))))


;; Função para buscar caminho de um tópico com arquivo personalizável
(defun buscar-caminho-topico (topico &optional caminho-arquivo)
  "Busca e exibe o caminho completo de um tópico.
Se CAMINHO-ARQUIVO não for fornecido, usa 'tesaurus.json'."
  (interactive "sTópico a buscar: \nfArquivo JSON do tesaurus (opcional): ")
  (let* ((arquivo (or caminho-arquivo "tesaurus.json"))
         (tesaurus (carregar-tesaurus arquivo))
         (caminho (buscar-topico tesaurus topico)))
    (if caminho
        (message "Caminho para '%s' em %s: %s" 
                 topico arquivo (mapconcat 'identity caminho " → "))
      (message "Tópico '%s' não encontrado em %s" topico arquivo))))


;; Função para visualização gráfica simplificada com arquivo personalizável
(defun visualizar-grafo-tesaurus (&optional caminho-arquivo)
  "Exibe uma visualização simplificada do grafo do tesaurus.
Se CAMINHO-ARQUIVO não for fornecido, pede ao usuário."
  (interactive "fCaminho para o arquivo JSON do tesaurus: ")
  (let* ((arquivo (or caminho-arquivo "tesaurus.json"))
         (tesaurus (carregar-tesaurus arquivo)))
    (message "=== GRAFO DO TESAURO (%s) ===" arquivo)
    (mapcar (lambda (nivel1)
              (let ((chave1 (car nivel1))
                    (valor1 (cdr nivel1)))
                (message "• %s" chave1)
                (let ((sub1 (assoc-default 'subtopicos valor1)))
                  (when sub1
                    (mapcar (lambda (nivel2)
                              (let ((chave2 (car nivel2))
                                    (valor2 (cdr nivel2)))
                                (message "  └── %s" chave2)
                                (let ((sub2 (assoc-default 'subtopicos valor2)))
                                  (when sub2
                                    (mapcar (lambda (nivel3)
                                              (let ((chave3 (car nivel3)))
                                                (message "      └── %s" chave3)))
                                            sub2)))))
                            sub1)))))
            tesaurus)))


;; Função auxiliar para verificar se o arquivo existe
(defun fzl-tesaurus-verificar-arquivo-tesaurus (&optional caminho-arquivo)
  "Verifica se o arquivo do tesaurus existe e mostra informações."
  (interactive "ffzl-tesaurus-verificar arquivo JSON: ")
  (let ((arquivo (or caminho-arquivo "tesaurus.json"))
        (caminho-completo (expand-file-name (or caminho-arquivo "tesaurus.json"))))
    (if (file-exists-p caminho-completo)
        (message "✓ Arquivo encontrado: %s (%d bytes)"
                 caminho-completo
                 (nth 7 (file-attributes caminho-completo)))
      (message "✗ Arquivo não encontrado: %s" caminho-completo))))


;; Função para listar arquivos JSON no diretório atual
(defun listar-arquivos-json (&optional diretorio)
  (interactive)
  "Lista todos os arquivos JSON no diretório especificado."
  (interactive "DDiretório para listar arquivos JSON: ")
  (let ((dir (or diretorio default-directory)))
    (message "Arquivos JSON em %s:" dir)
    (dolist (arquivo (directory-files dir t "\\.json$"))
      (message "  %s" (file-name-nondirectory arquivo)))))


(fzl-carregar-tesaurus "~/meu-tesaurus.json")

(provide 'tesaurus_from_json)
;; Exemplos de uso comentados:

;; (exibir-tesaurus "c:/Users/Usuario/Documents/tesaurus.json")
;; (buscar-caminho-topico "biologia" "/caminho/completo/tesaurus.json")
;; (visualizar-grafo-tesaurus "~/documentos/meu-tesaurus.json")
