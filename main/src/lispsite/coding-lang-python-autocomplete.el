(require 'pkgconfig-company)
(use-package elpy
  :init
  (elpy-enable)
  :config
  (setq elpy-rpc-python-command "python3"
        python-shell-interpreter "python3"))

(provide 'coding-lang-python-autocomplete)
