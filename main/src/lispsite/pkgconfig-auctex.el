(use-package auctex
  :ensure t 
  :mode ("\\.tex\\'" . latex-mode) ; Associate .tex files with LaTeX mode.
  :config ; Configuration settings for AUCTeX.
  (setq TeX-parse-self t) ; Enable AUCTeX to parse the current LaTeX file.
  (setq TeX-auto-save t) ; Automatically save the LaTeX file when compiling.
  (setq TeX-PDF-mode t) ; Enable PDF mode by default.
  (setq TeX-view-program-selection '((output-pdf "zathura"))) ; Set the PDF viewer (replace "zathura" with your preferred viewer).
  (setq TeX-view-program-list '(("zathura" "zathura %o"))) ; Configure the command to launch the PDF viewer.
  (setq LaTeX-bibtex-tool 'bibtex) ; Set the bibliography tool (use 'biber' if you use Biber).
  (setq LaTeX-default-style "article") ; Set the default LaTeX document class (e.g., 'article', 'report', 'book').
  (setq LaTeX-command-style '(("" "%(PDF)%(latex) -interaction=nonstopmode -synctex=1 %S"))) ; Configure the default compilation command.
  (setq LaTeX-command-options ; Configure specific compilation commands.
        '(("pdfLaTeX" "%(PDF)%(latex) -interaction=nonstopmode -synctex=1 %S")
          ("LaTeX" "%(latex) -interaction=nonstopmode -synctex=1 %S")
          ("XeLaTeX" "xelatex -interaction=nonstopmode -synctex=1 %S")
          ("LuaLaTeX" "lualatex -interaction=nonstopmode -synctex=1 %S")))
  (setq TeX-source-correlate-mode t) ; Enable source-PDF synchronization.
  (setq TeX-source-correlate-start-server t) ; Start the source-PDF synchronization server.
  (setq TeX-electric-math t) ; Enable electric insertion of math sequences.
  (setq TeX-electric-escape t) ; Enable electric insertion of escape sequences.
  (setq TeX-save-query nil) ; Disable the save query when compiling.
  (setq TeX-complete-symbol 'always) ; Enable symbol completion.
  (setq TeX-install-font-lock t) ; Enable font locking.
  (setq TeX-PDF-mode t) ; Ensure PDF mode is enabled.
  (add-hook 'LaTeX-mode-hook #'TeX-source-correlate-mode) ; Add source-PDF correlation to LaTeX mode hook.
  (add-hook 'LaTeX-mode-hook #'TeX-source-correlate-start-server) ; Start the server when LaTeX mode is activated.
  (add-hook 'LaTeX-mode-hook #'turn-on-reftex) ; Enable RefTeX in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'flyspell-mode) ; Enable spell checking in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'TeX-electric-math) ; Enable electric math in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'TeX-electric-escape) ; Enable electric escapes in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'TeX-save-query) ; Disable save query in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'TeX-install-font-lock) ; Enable font lock in LaTeX mode.
  (add-hook 'LaTeX-mode-hook #'TeX-PDF-mode) ; Enable PDF mode in LaTeX mode.
)

(use-package reftex
  :ensure t ; Ensure that RefTeX is installed.
  :config ; Configuration settings for RefTeX.
  (setq reftex-plug-into-AUCTeX t) ; Integrate RefTeX with AUCTeX.
  (setq reftex-use-multiple-selection-input t) ; Enable multiple selection input for RefTeX.
  (setq reftex-enable-partial-scans t)) ; Enable partial scans for RefTeX.

;;This is useful for setting default options, paths, or behaviors that are common across a group of users.7
;;If you are the only user of your emacs configuration, it is unlikely that you will need to directly edit or configure the tex-site package.
;;(use-package tex-site
;;  :ensure t) ; Ensure that tex-site is installed.

(provide 'pkgconfig-auctex)
