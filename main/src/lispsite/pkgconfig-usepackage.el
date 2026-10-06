;;; pkgconfig-usepackage.el --- Configuration for package and use-package -*- lexical-binding: t -*-

(print "pkgconfig-usepackage running...")
;; Certifique-se de ter o use-package instalado
(require 'package)

;; Configuração de repositórios (incluindo espelhos para o GNU ELPA caso o oficial fique inacessível)
(setq package-archives
      '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (ignore-errors (package-refresh-contents))
  (package-install 'use-package))

;; Configurar use-package
(require 'use-package)
(setq use-package-always-ensure t)

(provide 'pkgconfig-usepackage)


