(defun fzl-open-url-in-browser (url)
  "Open the specified URL in the default web browser."
  (interactive "sEnter URL: ")
  (browse-url url))

(provide 'fzl-util-browser)
