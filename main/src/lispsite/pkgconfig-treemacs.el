;;; pkgconfig-treemacs.el
(use-package treemacs
  :ensure t
  :config
  ;; All your settings go here
  (setq treemacs-width 35) ; A fixed width is often more stable
  (setq treemacs-follow-mode t)
  (setq treemacs-file-follow-delay 0.2)
  
  ;; This is handled by doom-themes, but is good to know
  (treemacs-load-theme "doom-atom")
  
  :bind
  ;; It's good practice to define keys inside :bind
  (("C-c t" . treemacs-toggle)))

(provide 'pkgconfig-treemacs)


;;Font Name to Use in Emacs Config,Corresponds to File
;;FiraCode Nerd Font Mono-12          for FiraCodeNerdFontMono-Regular.ttf
;;FiraCode Nerd Font Mono Retina-12   for FiraCodeNerdFontMono-Retina.ttf
;;"FiraCode Nerd Font-12 (Original, if it had worked)" for  FiraCodeNerdFont-Regular.ttf

;;wgn@fedora:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-domadmin/desktop-scripts$ fc-list | grep fira
;;/usr/share/fonts/fira-code/FiraCode-Bold.ttf: Fira Code:style=Bold
;;/usr/share/fonts/fira-code/FiraCode-Retina.ttf: Fira Code,Fira Code Retina:style=Retina,Regular
;;/usr/share/fonts/fira-code/FiraCode-Regular.ttf: Fira Code:style=Regular
;;/usr/share/fonts/fira-code/FiraCode-Medium.ttf: Fira Code,Fira Code Medium:style=Medium,Regular
;;/usr/share/fonts/fira-code/FiraCode-SemiBold.ttf: Fira Code,Fira Code SemiBold:style=SemiBold,Regular
;;/usr/share/fonts/fira-code/FiraCode-Light.ttf: Fira Code,Fira Code Light:style=Light,Regular
;;wgn@fedora:/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-domadmin/desktop-scripts$ 

;;(set-face-attribute 'default nil :font "FiraCode Nerd Font-12")
;;(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono-12")
;;(set-face-attribute
;; 'default nil :font (font-spec :family "FiraCode Nerd Font Mono" :size 12))

;; Try one of these options in your init.el
;; Option A: Using the explicit font-spec for Fira Code Nerd Font Mono
(set-face-attribute
 'default nil :family "FiraCode Nerd Font Mono" :height 120)

(provide 'pkgconfig-treemacs)
