
;; To customization be applied to all kinds of file buffers opened in Emacs,
;; The prog-mode hook is run whenever a major mode that represents a programming language is enabled.
;; Many major modes for programming languages derive from prog-mode,
;; so this hook is suitable for applying customizations that should be common across different programming modes.

(defun fzl-coding-progmode-hooks-setup ()
  (print "[hoot-prog-mode] ===> defun fzl-coding-progmode-hooks-setup ()...")
  (fzl-dotenv-variables-setup)
  (standard-display-ascii ?\t "^T")
  (setq nobreak-space-display (cons ?. ?.)))

(add-hook 'prog-mode-hook 'fzl-coding-progmode-hooks-setup)



(defun fzl-coding-restclient-hooks ()
  (when (and (buffer-file-name)
             (string-equal (file-name-extension (buffer-file-name)) "rest"))
    (print "[hoot-prog-mode] ===> defun fzl-coding-restclient-hooks ()...")
    (fzl-dotenv-variables-setup)
    (standard-display-ascii ?\t "^T")
    (setq nobreak-space-display (cons ?. ?.))))

(add-hook 'find-file-hook 'fzl-coding-restclient-hooks)


(provide 'hooks-prog-mode)
