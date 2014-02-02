(provide 'util-minibuffer-as-a-promp)
;(setq debug-on-error t)
;(defun fzl_prompt()
;  "transforma o minibuffer num promp de comando"
;  (interactive)
;  (eval 
;   (read-minibuffer
;    "Enter an expression: " (format "%s" '(str)))))

(defun minibuffer-prompt ()
  "Do stuff..."
  (interactive)
  (read-from-minibuffer "Regexp [cmd]? " (first query-replace-defaults)))


