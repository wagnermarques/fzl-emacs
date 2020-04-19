(provide 'config_elpy)

;;https://github.com/jorgenschaefer/elpy/issues/1001
;;(pyvenv-activate)
;;(setq elpy-rpc-python-command "python3")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(setq elpy-rpc-backend "jedi")

             
;;(pyvenv-activate "./var/myPyenv")

;;https://stackoverflow.com/questions/22239451/emacs-fix-tab-indentation-for-python
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq python-indent 4)
        (setq tab-width 4))
      (untabify (point-min) (point-max)))

(elpy-enable)
