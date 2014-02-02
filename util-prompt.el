;http://www.gnu.org/software/emacs/manual/html_node/elisp/Object-from-Minibuffer.html
;ftp://ftp.gnu.org/old-gnu/Manuals/elisp/html_node/elisp_271.html
;http://stackoverflow.com/questions/754327/emacs-elisp-dynamic-interactive-prompt
(defun fzl_prompt ()
  "convert minibuffer in a prompt for one command each time this func is issued"
  (interactive)
  (eval 
   (read-from-minibuffer "prompt >" (type lisp here)))
