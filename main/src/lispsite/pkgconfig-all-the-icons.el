;;https://github.com/domtronn/all-the-icons.el

;; Instalar e configurar all-the-icons
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Display-Feature-Testing.html

(use-package all-the-icons
  :ensure t)

;(use-package all-the-icons
;  :if (display-graphic-p)
;  :ensure t)
;  :config
;  ;; Instalar as fontes de ícones, se necessário
;  (unless (member "all-the-icons" (font-family-list)) (all-the-icons-install-fonts t))
;  (unless (all-the-icons-install-fonts t)
;    (error "Unable to install all-the-icons fonts. Check your internet connection or font directory permissions.")))
;(all-the-icons-install-fonts)

;(when (display-graphic-p)
;  (require 'all-the-icons))


;; Opcional: Configurar pacotes que utilizam all-the-icons
;(use-package neotree
;  :ensure t
;  :config
;  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;
;(use-package treemacs
;  :ensure t
;  :defer t
;  :config
;  (use-package treemacs-all-the-icons
;    :ensure t
;    :config
;    (treemacs-load-theme "all-the-icons")))
;
;(use-package doom-modeline
;  :ensure t
;  :hook (after-init . doom-modeline-mode)
;  :config
;  (setq doom-modeline-icon (display-graphic-p)))  ; Usar ícones se estiver em modo gráfico
;
;(all-the-icons-install-fonts)

(provide 'pkgconfig-all-the-icons)
