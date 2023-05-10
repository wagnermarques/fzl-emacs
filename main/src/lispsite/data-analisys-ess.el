(message "==>data-analisys-ess.el loaded sucessfully!!!")

;;R language support
;; proposals package for installations for R support
;; ess                20230419.1527 available  melpa      Emacs Speaks Statistics
;; ess-R-data-view    20130509.1158 available  melpa      Data viewer for GNU R
;; ess-r-insert-obj   20220610.1406 available  melpa      Insert objects in ESS-R
;; ess-smart-equals   20210411.1333 available  melpa      flexible, context-sensitive assignment key for R/S
;; ess-smart-under... 20190309.101  available  melpa      Ess Smart Underscore
;; ess-view           20181001.1730 available  melpa      View R dataframes in a spreadsheet software


(use-package ess
  :ensure t
  :config
  (setq ess-use-company 'script-only))
;  (define-key company-active-map [return] nil)
;  (define-key company-active-map [tab] 'company-complete-common)
;  (define-key company-active-map (kbd "TAB") 'company-complete-common)
;  (define-key company-active-map (kbd "M-TAB") 'company-complete-selection)
;  (setq company-selection-wrap-around t
;        company-tooltip-align-annotations t
;        company-idle-delay 0.36
;        company-minimum-prefix-length 2
;        company-tooltip-limit 10));;https://www.emacswiki.org/emacs/ESS-company 


(provide 'data-analisys-ess)
