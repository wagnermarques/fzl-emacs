(provide 'config_code_system)
;http://www.emacswiki.org/emacs/LanguageEnvironment
;http://www.masteringemacs.org/articles/2012/08/09/working-coding-systems-unicode-emacs/

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))



(defvar universal-coding-system-env-list '("PYTHONIOENCODING")
  "List of environment variables \\[universal-coding-system-argument] should set")
 
(defadvice universal-coding-system-argument (around provide-env-handler activate)
  "Augments \\[universal-coding-system-argument] so it also sets environment variables
 
   Naively sets all environment variables specified in
   `universal-coding-system-env-list' to the literal string
    representation of the argument `coding-system'.
 
   No guarantees are made that the environment variables set by this advice support
    the same coding systems as Emacs."
  (let ((process-environment (copy-alist process-environment)))
    (dolist (extra-env universal-coding-system-env-list)
      (setenv extra-env (symbol-name (ad-get-arg 0))))
    ad-do-it))



;aprendi isso em http://snipplr.com/view/18678/loadmyfavoritefile/
;pra usar he so fazer o seguinte depois que o emacs tiver carregado
;M-x load-emacs-initfile RET
;seguir o exemplo por demais arquivos

;(defun fzl-dev-edit-emacs-initfile ()
;  " abre arquivo de configuracao/customizacao do emacs do fzlbpms"
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-etc/etc/emacs/emacsinitfile/init.el"))
;)

;(defun fzl-dev-edit-fzl-message-org-file()
;  (interactive)
;  (find-file (concat *FZL_APPS_HOME* "/fzlbpms-etc/etc/emacs/fzl-messages.org"))
;  (org-toggle-inline-images)
;)

;(defun fzl-dev-edit-scripts-de-builds-fzlbpms()
;  (interactive)
;  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/exportar_fzlbpms.sh")
;  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlfn_exportadir_etc.sh")
;  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlfn_exportadir_bin")
;  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlbpms_utils___shared_functions.sh")
;  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlbpms_utils___handle_script_parameters.sh")
;)


