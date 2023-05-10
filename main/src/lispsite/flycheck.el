;;http://www.flycheck.org/en/latest/user/quickstart.html
;;https://www.gnu.org/software/emacs/manual/html_node/flymake/Installing-Flymake.html
;;http://www.flycheck.org/en/latest/user/installation.html

;;
;;Flycheck does not check buffers itself but relies on external programs to check buffers.
;;These programs must be installed separately.
;;Please take a look at the list of supported languages to find out what tools are required for a particular language.
;;
;;https://www.flycheck.org/en/latest/
;;https://www.flycheck.org/en/latest/user/installation.html

;;; Code:

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Dockerfile
;;https://github.com/hadolint/hadolint
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;https://emacs.stackexchange.com/questions/14551/whats-the-difference-between-after-init-hook-and-emacs-startup-hook
;;(add-hook 'after-init-hook 'global-flycheck-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;YAML
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;yaml-mode.el enforces spaces instead of TABs in yaml-mode, regardless of emacs configuration.
;;If you wish to have Return key automatically indent cursor on new line, add the following to emacs config:
;;https://www.emacswiki.org/emacs/YamlMode
;;(add-hook 'yaml-mode-hook
;;          (lambda ()
;;            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;https://github.com/krzysztof-magosa/flycheck-yamllint
;;(require 'flycheck-yamllint)
;;(eval-after-load 'flycheck
;;  '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))



;;https://www.emacswiki.org/emacs/YamlMode
(provide 'flycheck)
