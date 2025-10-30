;; Ensure yaml-mode is installed and used for .yml and .yaml files
(use-package yaml-mode
  :ensure t
  :mode ("\.yml\'" "\.yaml\'"))

;; Add flycheck for YAML linting
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Enable flycheck for YAML files
(use-package flycheck-yamllint
  :ensure t
  :after (flycheck yaml-mode)
  :config
  (flycheck-add-mode 'yaml-yamllint 'yaml-mode))


;; Optionally, you can add yaml-imenu for better navigation
(use-package yaml-imenu
  :ensure t
  :after yaml-mode
  :hook (yaml-mode . yaml-imenu-enable))

(require 'coding-yaml-ansible)

(provide 'coding-yaml)
