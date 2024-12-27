(print "===> windows-and-frames loaded sucessfully")
(print (getenv "FZLEMACS_KEY_SHOW_WINDOW_SPEEDBAR_AT_LEFT"))



;;MESSAGE BUFFER AT THE BOTTON OF THE FRAME
(defun fzl/show-messages-buffer-at-bottom ()
  (interactive)
  "Display the *Messages* buffer in a window at the bottom of the frame."
  (let ((messages-buffer (get-buffer "*Messages*")))
    (when messages-buffer
      (let ((window (split-window-vertically)))
        (set-window-buffer window messages-buffer)
        (select-window window)
        ;; Optionally make the window smaller:
        (shrink-window (- (window-height) 10))))))

;;C-c m to show the message buffer
(global-set-key (kbd (getenv "FZLEMACS_KEY_SHOW_WINDOW_MESSAGE_BUFFER_AT_BOTTON")) 'fzl/show-messages-buffer-at-bottom)



;;;SPEEDBAR AT THE LEFT OF THE FRAME
(defun fzl/show-speedbar-on-left ()
  "Open the speedbar in a frame on the left."
  (interactive)
  (let ((speedbar-buffer (get-buffer "*SPEEDBAR*")))
    (if (and speedbar-buffer (frame-live-p (window-frame (get-buffer-window speedbar-buffer t))))
        (select-frame-set-input-focus (window-frame (get-buffer-window speedbar-buffer t)))
      (progn
        ;; Start speedbar
        (speedbar-get-focus)
        ;; Adjust its position and size
        (let ((frame (selected-frame)))
          (set-frame-position frame 0 0)
          (set-frame-width frame 30))))))

;; Optional: Bind the function to a key combination
(global-set-key (kbd (getenv "FZLEMACS_KEY_SHOW_WINDOW_SPEEDBAR_AT_LEFT")) 'fzl/show-speedbar-on-left)



(provide 'config-emacs-windows-and-frames)

