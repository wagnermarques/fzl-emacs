(provide 'fzl_utils)

;;https://www.gnu.org/software/emacs/manual/html_node/eintr/car-_0026-cdr.html
(defun print-elements-of-list (list)
  "Print each element of LIST on a line of its own."
  (while list
    (print (car list))
    (setq list (cdr list))))

