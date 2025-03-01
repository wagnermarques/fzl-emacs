   ;; Use use-package to install and configure Impatient Mode
   (use-package impatient-mode
     :ensure t
     :hook (html-mode . fzl-impatient-mode-start)
     :config
     (defun fzl-impatient-mode-start ()
       "Start HTTP server, enable Impatient Mode, and open Firefox."
       (httpd-start)
       (impatient-mode 1)
       (browse-url-firefox "http://localhost:8080/imp/")))

(provide 'pkgconfig-impatientmode)
