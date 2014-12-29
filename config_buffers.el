


;; turn off welcome screen
(setq inhibit-startup-message t)

(find-file *index_document_path*)
;(switch-to-buffer indexdocume)

;;CONFIG SHELL BUFFER
;will position cursor to end of output in shell mode automatically.
;(auto-show-make-point-visible) ;TODO see why this...
;Debugger entered--Lisp error: (void-function auto-show-make-point-visible)
;  (auto-show-make-point-visible)
;  eval-buffer(#<buffer  *load*<2>> nil "/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/buffers_config.el" nil t)  ; Reading at buffer position 215
;  load-with-code-conversion("/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/buffers_config.el" "/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/buffers_config.el" nil t)
;  require(buffers_config)
;  eval-buffer(#<buffer  *load*> nil "/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/init.el" nil t)  ; Reading at buffer position 3145
;  load-with-code-conversion("/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/init.el" "/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/init.el" nil t)
;  load("/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/init.el" nil t)
;  command-line-1(("-l" "/home/wagner/dev_env/fzlbpms/etc/emacs/sitelisp/emacsinitfile/init.el"))
;  command-line()
;  normal-top-level()

(provide 'config_buffers)

