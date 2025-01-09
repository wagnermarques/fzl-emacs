;; Load the PlantUML and Org packages.
(require 'ob-plantuml)
(require 'org)

;; Ensure that `org-src-lang-modes` is initialized.
(unless (boundp 'org-src-lang-modes)
  (setq org-src-lang-modes ()))

;; Add PlantUML to the list of Org source languages.
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

;; Enable PlantUML support in Org Babel.
(add-to-list 'org-babel-load-languages '(plantuml . t))

;; Set the path to the PlantUML jar file.
(setq org-plantuml-jar-path (expand-file-name "./plantuml.jar"))

;; Function to disable confirmation for evaluating PlantUML code blocks.
(defun my/org-confirm-babel-evaluate (lang body)
  "Do not ask for confirmation to evaluate PlantUML."
  (not (string= lang "plantuml")))

;; Set the function to disable confirmation for PlantUML code blocks.
(setq org-confirm-babel-evaluate #'my/org-confirm-babel-evaluate)

;; Check if the PlantUML jar file exists; if not, download it.
(unless (file-exists-p org-plantuml-jar-path)
  (url-copy-file "https://nchc.dl.sourceforge.net/project/plantuml/plantuml.jar" org-plantuml-jar-path t))


(provide 'config-mode-orgmode-babel-plantuml)
;;; config-mode-orgmode-babel-plantuml.el ends here
