(provide 'config_fonts_and_themes)
;http://www.emacswiki.org/emacs/SetFonts
;http://www.emacswiki.org/emacs/GlobalTextScaleMode
;https://code.google.com/p/tron-theme-emacs/source/browse/tron-dark-theme.el
;http://www.gnu.org/software/emacs/manual/html_node/elisp/Around_002dAdvice.html

(defadvice text-scale-increase (around all-buffers (arg) activate)
  (dolist (buffer (buffer-list))
    (message "fzl_emacs... config_fonts_and_themes... (defadvice text-scale-increase (around all-buffers (arg) activate)")
    (with-current-buffer buffer ad-do-it)    
    ))

