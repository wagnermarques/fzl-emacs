(use-package js-react-redux-yasnippets
  :ensure t)


(use-package react-snippets
  :ensure t)


;;TODO: fix it
;; the first httpd_root dir is get from EMCAS_SIMPLE_HTTPD_ROOT environment variable
;; if its nil, we user default one in **EMACSINITFILE_HOME**
;;(if (equal "" (getenv "EMACS_SIMPLE_HTTPD_ROOT"))
;;    (progn
;;      (setq **config_simple_httpd_root** (getenv "EMACS_SIMPLE_HTTPD_ROOT"))
;;      (message (concat "**config_simple_httpd_root** (setted by environment variable) = " **config_simple_httpd_root**)))
;;  (progn
;;    (setq **config_simple_httpd_root** (concat **EMACSINITFILE_HOME** "/httpd-root"))
;;    (message (concat "**config_simple_httpd_root** (using default) = " **config_simple_httpd_root**))))


(provide 'coding-javascript)
;;  buster-snippets                20151125.1010  available    melpa    Yasnippets for the Buster javascript testing framework
;;  conkeror-minor-mode            20150114.1604  available    melpa    Mode for editing conkeror javascript files.
;;  eslint-fix                     20211005.221   available    melpa    Fix JavaScript files using ESLint
;;  firefox-javascript-repl        0.9.5          available    gnu      Jack into Firefox
;;  fish-mode                      20230326.1604  available    melpa    Major mode for fish shell scripts
;;  flymake-eslint                 20230301.1441  available    melpa    A Flymake backend for Javascript using eslint
;;  flymake-gjshint                20130327.1232  available    melpa    A flymake handler for javascript using both jshint and gjslint
;;  frontside-javascript           20220315.1057  available    melpa    JS  development that just work™️
;;  gnuplot-mode                   20171013.1616  available    melpa    Major mode for editing gnuplot scripts
