; i n s t a l a n d o c e d e t

(provide 'cedet_config)

(load-file
 (concat *cedet_home* "/common/cedet.el"))

(global-ede-mode 1) ; Enable the Project management system
;TODO abilitate this litle features... are getting void functions...
;(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1) ; Enable template insertion menu



