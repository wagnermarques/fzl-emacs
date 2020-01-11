(defun fzl/print-all-installed-packages()
  (print package-activated-list))  

(defun fzl/install-all-packages-from-list(pkglist)
  "PKGLIST is a list of packages. Install all packages if it is not installed yet."  
  )


(defun fzl/org-feed-config()
  "Configure org-feed-config. Code from:https://melpa.org/#/getting-started"

  (let* (
         (orgfeed-file-path (concat "/home/wagner/wagnerdocri3@gmail.com/envs/env-dev/sources/emacsinitfile" "/org-feeds")))

    (require 'package)    
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
    (package-initialize)
    ))
    
(provide 'fzl_utils_package)
  
