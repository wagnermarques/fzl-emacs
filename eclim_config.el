(provide 'eclim_config)

(require 'eclim)
(add-hook 'java-mode-hook 'eclim-mode)
(require 'eclimd)
(start-eclimd)


;;Refs
;;http://www.goldsborough.me/emacs,/java/2016/02/24/22-54-16-setting_up_emacs_for_java_development/
