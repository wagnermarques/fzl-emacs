; i n s t a l a n d o c e d e t

;;http://stackoverflow.com/questions/12711765/status-of-cedet-and-ecb-in-emacs-24-2

(provide 'cedet_config)

;turn on semantic
(semantic-mode t)

(defun my:add-semmantic-as-backend-of-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))

(add-hook 'c-mode-common-hook 'my:add-semmantic-as-backend-of-autocomplete)



;IN CASE OF SOURCE CODE TRUNK INSTALLATION...
;(load-file
; (concat *cedet_home* "/common/cedet.el"))

(global-ede-mode 1) ; Enable the Project management system
;TODO abilitate this litle features... are getting void functions...
;(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1) ; Enable template insertion menu



