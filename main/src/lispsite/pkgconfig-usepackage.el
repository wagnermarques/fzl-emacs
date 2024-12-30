;; Certifique-se de ter o use-package instalado
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configurar use-package
(require 'use-package)
(setq use-package-always-ensure t)


(provide 'pkgconfig-usepackage)

