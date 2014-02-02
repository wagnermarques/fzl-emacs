(provide 'fzl_find_file_functions)

(defun fzl-open-initel-file()
  "svt-open-initel-file"
  (find-file (concat *FZL_HOME*  "etc/emacs/sitelisp/emacsinitfile/init.el")))

(defun fzl-open-yasnippet-config()
  (interactive)
  "open yasnippet_config.el"
  (find-file (concat *FZL_HOME*  "etc/emacs/sitelisp/emacsinitfile/yasnippet_config.el")))


(defun fzl-open-find_file_functions()
  (interactive)
  ""
  (find-file (concat *FZL_HOME*  "etc/emacs/sitelisp/emacsinitfile/fzl_find_file_functions.el")))
                                                                   
;(defun fzl-open-yasnippet-el()
;  (interactive)
;  ""
;  (find-file (concat *FZL_HOME*  "etc/emacs/sitelisp/checkouts/yasnippet/yasnippet.el")))



;(fzl-open-initel-file)
;(fzl-open-yasnippet-config)
;(fzl-open-yasnippet-el)
;(fzl-open-find_file_functions)

