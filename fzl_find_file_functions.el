(provide 'fzl_find_file_functions)

(defun fzl-open-initel-file()
  "open-initel-file"
  (interactive)
  (find-file (concat *fzl_emacsinitfile_dir*  "/init.el"))
  (find-file (concat *fzl_emacsinitfile_dir*  "/init2.el"))
)

(defun fzl-open-config-files()
  (interactive)
  "open configurations files"
  (find-file (concat *fzl_emacsinitfile_dir*  "/yasnippet_config.el"))
)

(defun fzl-open-find_file_functions()
  (interactive)
  ""
  (find-file (concat *fzl_emacsinitfile_dir*  "/fzl_find_file_functions.el")))
                                                                   
;(defun fzl-open-yasnippet-el()
;  (interactive)
;  ""
;  (find-file (concat *FZL_HOME*  "etc/emacs/sitelisp/checkouts/yasnippet/yasnippet.el")))



;(fzl-open-initel-file)
;(fzl-open-yasnippet-config)
;(fzl-open-yasnippet-el)
;(fzl-open-find_file_functions)

