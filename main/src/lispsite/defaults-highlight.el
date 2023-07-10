;;https://www.emacswiki.org/emacs/ShowWhiteSpace

(defface extra-whitespace-face
  '((t (:background "pale green")))
  "Used for tabs and such.")

(defvar my-extra-keywords
  '(("\t" . 'extra-whitespace-face)))

(add-hook 'emacs-lisp-mode-hook
          (lambda () (font-lock-add-keywords nil my-extra-keywords)))

(add-hook 'text-mode-hook
          (lambda () (font-lock-add-keywords nil my-extra-keywords)))


;; Draw tabs with the same color as trailing whitespace  
(add-hook 'font-lock-mode-hook  
          (lambda ()  
            (font-lock-add-keywords  
             nil  
             '(("\t" 0 'trailing-whitespace prepend)))))


;;(setq nobreak-space-display (cons ?. ?.))
;;check prog-mode-hooks.el that are some hingligths definition in there




(provide 'defaults-higligth)
