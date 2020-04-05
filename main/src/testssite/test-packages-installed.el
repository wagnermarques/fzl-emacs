;;THIS FILE ARE STILL NO WORKING AS I WOULD LIKE TO;;

;;statsu of this file
;;The purpose is to list packages to be installed
;;install its packages
;;test if its was really installed
;;Install packages automatically is  role of config_package_system.el



;; when we need to test packages
;; we need a brand new ~/.emacs.d without installed packages
;; in some cases, we will want to install packages and test if the package was installed
;; this is the case we need a brand new ~/.emacs.d
(defun resetDotEmacsDir()
  (shell-command "rm -rf /home/wagner/.emacs.d/ && mkdir -p ~/.emacs.d/"))

;;https://melpa.org/#/getting-started
;  (require 'package)
;  (package-initialize)
;  (package-list-packages)
;  (package-refresh-contents)
;  (package-install *pkgName*))


;;https://www.gnu.org/software/emacs/manual/html_node/ert/Fixtures-and-Test-Suites.html
(defun ert-test-if-package-is-instaled-fixture (body)  
  (unwind-protect ;https://www.gnu.org/software/emacs/manual/html_node/elisp/Cleanups.html
    (progn
      (require 'fzl_utils_package)
      (let* ((package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			         ("marmalade" . "http://marmalade-repo.org/packages/")
			         ("org" . "http://orgmode.org/elpa/")
			         ("melpa" . "http://melpa.milkbox.net/packages/")))
             (packages-to-be-installed-list '(ob-browser
                                              ob-http
                                              auto-complete
                                              auto-complete-c-headers
                                              yasnippet))))
        (resetDotEmacsDir)
        (funcall body))
    (unload-feature 'package)))


(ert-deftest ert-test-if-package-is-instaled()
  (ert-test-package-is-instaled-fixture
   (lambda ()
     (mapc (lambda(x) (print x) packages-to-be-installed-list)) 
     ;(install-list-of-packages packages-to-be-installed-list)
     ;;for each packaged listed in packages-to-be-installed-list
     ;;we want to test if package-installed-p returns non nil for them all
     ;(mapc (lambda(p) 
     ;        (should (eql (package-installed-p p) t)))))))
)))
(provide 'test-packages-installed)
