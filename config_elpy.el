(provide 'config_elpy)

;;https://github.com/jorgenschaefer/elpy/issues/1001
;;(pyvenv-activate)
;;(setq elpy-rpc-python-command "python3")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(setq elpy-rpc-backend "jedi")

             
(pyvenv-activate "./var/myPyenv")

(elpy-enable)
