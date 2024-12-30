(defun fzl/grep-recursive-in-current-dir()
  "Perform grep string ignorecase recursive"
  (interactive)
  (let ((currDir current-dir)
        (grepCmd "grep -r -n -i")
        (shell-command grepCmd))))

(defun fzl-ide-feat-grep-region-string-to-new-buffer ()
  "Obtém uma string a partir de uma região selecionada no buffer, executa grep -r -i e lista os resultados em um novo buffer temporário."
  (interactive)
  (if (use-region-p)
      (let* ((search-string (buffer-substring-no-properties (region-beginning) (region-end)))
             (grep-command (concat "grep -r -n -i \"" search-string "\" .")))
        (with-output-to-temp-buffer "*grep-results*"
          (shell-command grep-command "*grep-results*")
          (pop-to-buffer "*grep-results*")))
    (message "Nenhuma região selecionada.")))

;; Vincular a função a uma tecla de atalho, se desejar
(global-set-key (kbd "C-c g r") 'fzl-ide-feat-grep-region-string-to-new-buffer)


(provide 'fzl-ide-feat-grep)
