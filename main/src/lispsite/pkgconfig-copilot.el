;; Ensure dependencies are installed
(use-package editorconfig
  :ensure t)
(use-package jsonrpc
  :ensure t)

;; Install and configure copilot
(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("TAB" . copilot-accept-completion)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)
              ("C-c C-c" . copilot-clear-overlay)
              ("C-c C-l" . copilot-login)
              ("C-c C-i" . copilot-install-server))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode . 2))
  (add-to-list 'copilot-indentation-alist '(org-mode . 2))
  (add-to-list 'copilot-indentation-alist '(text-mode . 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode . 2)))

(use-package copilot-chat
  :ensure t
  :after
  (request org markdown-mode shell-maker)
  :config
  (setq copilot-chat-indentation-alist '((prog-mode . 2) (org-mode . 2) (text-mode . 2) (emacs-lisp-mode . 2))))

;; Initial setup
(defun fzl/pkgconfig/copilot-install-server ()
  (interactive)
  (copilot-install-server))

(defun fzl/pkgconfig/copilot-login ()
  (interactive)
  (copilot-login))

(fzl/pkgconfig/copilot-install-server)
(fzl/pkgconfig/copilot-login)

(provide 'pkgconfig-copilot)


