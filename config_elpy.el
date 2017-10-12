(provide 'config_elpy)

;;https://github.com/jorgenschaefer/elpy/issues/1001
;;(pyvenv-activate)
;;(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-backend "jedi")
(pyvenv-activate "./var/myPyenv")
(elpy-enable)
