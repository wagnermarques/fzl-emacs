(setq **thisFileDir** (getenv "PWD"))

;; when we need to test packages
;; we need a brand new ~/.emacs.d without installed packages
;; in some cases, we will want to install packages and test if the package was installed
;; this is the case we need a brand new ~/.emacs.d
(defun resetDotEmacsDir()
  (shell-command "rm -rf /home/wagner/.emacs.d/ && mkdir -p ~/.emacs.d/"))

;;"add-node-modules-path"
(setq *pkgName* "eclim")


;;https://melpa.org/#/getting-started
(defun configureRepositories()
  (require 'package)

  (setq package-archives '(("gnu"  "https://elpa.gnu.org/packages/")
			   ("marmalade"  "http://marmalade-repo.org/packages")
			   ("melpa"  "http://melpa.org/packages/")))
 ) 
;  (package-initialize)
;  (package-list-packages)
  ;(package-refresh-contents)
 ; (package-install *pkgName*))

(defun ert-test-if-package-is-instaled-fixture (body)  
  (unwind-protect ;https://www.gnu.org/software/emacs/manual/html_node/elisp/Cleanups.html
      (progn
        (resetDotEmacsDir)
        (configureRepositories)
        ;(package-install *pkgName*)
        (load "./fzl_utils_package.el")
        ;(require 'package)
        ;(package-initialize)
        (funcall body))
    (unload-feature 'package)))


(ert-deftest ert-test-if-package-is-instaled()
  (ert-test-package-is-instaled-fixture
   (lambda ()
     (should (eql (package-installed-p *pkgName*) nil)))))


;(ert-deftest ert-test-mismatch ()
;  (should (eql (cl-mismatch "" "") nil))
;  (should (eql (cl-mismatch "" "a") 0))
;  (should (eql (cl-mismatch "a" "a") nil))
;  (should (eql (cl-mismatch "ab" "a") 1))
;  (should (eql (cl-mismatch "Aa" "aA") 0))
;  (should (eql (cl-mismatch '(a b c) '(a b d)) 2)))
