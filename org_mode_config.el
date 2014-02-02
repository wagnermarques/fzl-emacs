(provide 'org_mode_config)
;;CONFIGURING ORG-MODE
;;https://email.esm.psu.edu/pipermail/macosx-emacs/2011-October/003027.html
;; Conventional selection/deletion
(setq org-support-shift-select t)

; thanks to PT (org-mode list)
(defun my-org-mode-stuff ()
  "define selection by keyboard similar to Mac and Windows"
  (require 'pc-select)
  (local-set-key (kbd "C-S-<right>") 'forward-word-mark)
  (local-set-key (kbd "C-S-<left>") 'backward-word-mark)
  (local-set-key (kbd "S-<right>") 'forward-char-mark)
  (local-set-key (kbd "S-<left>") 'backward-char-mark)
  (local-set-key (kbd "S-<up>") 'previous-line-mark)
  (local-set-key (kbd "S-<down>") 'next-line-mark))

(add-hook 'org-mode-hook 'my-org-mode-stuff)




;http://floatsolutions.com/blog/2010/10/displaying-inline-images-in-emacs-org-mode/
;; -- Display images in org mode
;; enable image mode first
(iimage-mode)
;; add the org file link format to the iimage mode regex
(add-to-list 'iimage-mode-image-regex-alist
(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))
;; add a hook so we can display images on load
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))
;; function to setup images for display on load
(defun org-turn-on-iimage-in-org ()
"display images in your org file"
(interactive)
(turn-on-iimage-mode)
(set-face-underline-p 'org-link nil))

;; function to toggle images in a org bugger
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))

  (call-interactively 'iimage-mode))

