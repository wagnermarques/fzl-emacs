(defun fzl-org-babel-list-result-options ()
  "List Org Babel result options in a new temporary buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*Org Babel Result Options*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert (concat
               "* Org Babel Result Options\n\n"
               "** Results Handling\n"
               "- \":results value\" - Insert the result in the Org buffer as a value.\n"
               "- \":results verbatim\" - Insert the result as verbatim text.\n"
               "- \":results raw\" - Insert the result as raw text.\n"
               "- \":results output\" - Capture and insert the standard output.\n"
               "- \":results file\" - Insert a link to a file returned by the code block.\n\n"
               "** Result Formatting\n"
               "- \":results silent\" - Do not insert any results.\n"
               "- \":results drawer\" - Wrap the result in an Org drawer.\n"
               "- \":results replace\" - Replace the previous result with the new one.\n"
               "- \":results append\" - Append the new result to the previous one.\n"
               "- \":results prepend\" - Prepend the new result to the previous one.\n\n"
               "** Miscellaneous\n"
               "- \":results code\" - Treat the result as code.\n"
               "- \":results graphics\" - Handle graphical output specially.\n"
               "- \":results latex\" - Format the result as LaTeX.\n"
               "- \":results html\" - Format the result as HTML.\n"
               "- \":results org\" - Format the result as Org mode syntax.\n"
               "- \":results list\" - Convert the result to an Org list.\n"
               "- \":results table\" - Convert the result to an Org table.\n\n"
               "** Cache Options\n"
               "- \":cache yes\" - Cache the results for faster re-evaluation.\n"))
      (goto-char (point-min))
      (org-mode))
    (pop-to-buffer buffer)))

;; Bind the function to a key combination for easy access (optional)
(global-set-key (kbd "C-c o r") 'org-babel-list-result-options)

(provide 'config-mode-orgmode-babel)
