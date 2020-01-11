"-*- forms -*-"

;;;;https://www.gnu.org/software/emacs/manual/html_mono/forms.html#Forms-Example
;;(setq forms-file "properties-form-data-file.el")
(setq forms-file "properties.csv")

;;;;https://www.gnu.org/software/emacs/manual/html_mono/forms.html#Format-Description
(setq forms-number-of-fields 7)
(setq forms-read-only t)                 ; to make sure

;;(setq forms-read-only nil)                 
(setq forms-field-sep ";")


;; Don’t allow multi-line fields.
;;(setq forms-multi-line nil)
(setq forms-format-list
      (list
       "====== emacsinitfile properties.csv ======\n\n"
       "integrated : "    1
       "\n"
       "   Enviroment Variable : \t"   2
       "\n"
       "   Env Variable Value: \t\t"   3
       "\n"))
