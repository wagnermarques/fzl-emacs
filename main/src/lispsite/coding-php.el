(use-package php-mode
  :ensure t
  :mode (("\\.php\\'" . php-mode))
  :init
  (setq php-mode-code-style 'psr4)
  (setq php-search-documentation-browser-function 'eww-browse-url)
  (setq php-style-delete-trailing-whitespace 1)
  (if
      (file-exists-p "~/.config/composer/vendor/bin")
      (progn
        (setq flycheck-php-phpcs-executable "~/.config/composer/vendor/bin/phpcs")
        (setq flycheck-php-phpmd-executable "~/.config/composer/vendor/bin/phpmd")
        )))


        
(provide 'coding-php)
