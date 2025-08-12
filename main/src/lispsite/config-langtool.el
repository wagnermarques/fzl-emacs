;;; config-langtool.el --- Configuration for LanguageTool grammar checker.

(print "===> config-langtool.el running...")

;; The `use-package` macro handles package installation and configuration.
(use-package langtool
  :ensure t  ; Ensures the package is installed from MELPA.
  :defer t   ; Delays loading the package until it's actually needed.

  ;; The :init block runs before the package is loaded.
  ;; We set the JAR path here so it's available when needed.
  :init
  (setq langtool-language-tool-jar fzlemacs-integration-languagetool-commandline-jar)

  ;; The :config block runs after the package has been loaded.
  :config
  ;; Set your preferred languages.
  (setq langtool-default-language "pt-BR")
  (setq langtool-mother-tongue "pt-BR")

  ;; A simple check to ensure Java and the JAR file are available when langtool runs.
  (unless (and (file-exists-p langtool-language-tool-jar) (executable-find "java"))
    (warn "LanguageTool setup incomplete. Java or JAR file not found: %s" 
          langtool-language-tool-jar))

  (message "LanguageTool configured successfully for pt-BR.")

  ;; Define keybindings here, where they belong.
  :bind (("C-c l c" . langtool-check)
         ("C-c l x" . langtool-check-done)
         ("C-c l n" . langtool-goto-next-error)))

(provide 'config-langtool)
