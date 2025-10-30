;;; package --- Summary

;;; Commentary:
;;https://magit.vc/manual/magit/Performance.html#Performance

;;Magit also reverts buffers for visited files located inside the current repository when the visited file changes on disk. That is implemented on top of auto-revert-mode

;;; Code:

;; Carregar o pacote `magit` usando use-package
(use-package magit
  :ensure t  ;; Instalar o pacote se ainda não estiver instalado
  :bind (("C-x g" . magit-status))  ;; Vincular a tecla C-x g ao comando `magit-status`
  :config
  ;; Configurações adicionais do `magit`
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (setq magit-save-repository-buffers 'dontask)
  (setq magit-commit-ask-to-stage t)
  ;; Definir atalhos adicionais para o `magit`
  (define-key magit-status-mode-map (kbd "C-c C-g") 'magit-refresh)
  (define-key magit-status-mode-map (kbd "C-c C-c") 'magit-commit)

  ;; Configurações de cores personalizadas para buffers do `magit`
  (custom-set-faces
   ;; Cabeçalhos e seções
   '(magit-section-highlight ((t (:background "gray20"))))
   '(magit-section-heading ((t (:foreground "light blue" :weight bold))))
   '(magit-section-heading-selection ((t (:foreground "deep sky blue" :weight bold))))
   
   ;; Diferenciação de commits
   '(magit-diff-added ((t (:background "#335533" :foreground "green"))))
   '(magit-diff-added-highlight ((t (:background "#336633" :foreground "green"))))
   '(magit-diff-removed ((t (:background "#553333" :foreground "red"))))
   '(magit-diff-removed-highlight ((t (:background "#663333" :foreground "red"))))

   ;; Linhas de contexto
   '(magit-diff-context ((t (:foreground "grey70"))))
   '(magit-diff-context-highlight ((t (:background "grey20" :foreground "grey70"))))
   
   ;; Outros elementos
   '(magit-diff-file-heading ((t (:foreground "light blue" :weight bold))))
   '(magit-diff-file-heading-highlight ((t (:background "gray20" :weight bold))))
   '(magit-diff-file-heading-selection ((t (:background "gray20" :foreground "deep sky blue" :weight bold))))
   '(magit-diff-hunk-heading ((t (:background "gray35"))))
   '(magit-diff-hunk-heading-highlight ((t (:background "gray45"))))
   '(magit-diff-hunk-heading-selection ((t (:background "gray45" :foreground "deep sky blue"))))))


(provide 'pkgconfig-magit)
