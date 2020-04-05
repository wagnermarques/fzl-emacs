(setq **thisFileDir** (getenv "PWD"))
(setq **lispsiteDir** (concat **thisFileDir** "/main/src/lispsite"))
(setq **testssiteDir** (concat **thisFileDir** "/main/src/testssite"))

(add-to-list 'load-path **lispsiteDir**)
(add-to-list 'load-path **testssiteDir**)


;;test if automatically installing process is working correctly
(require 'test-packages-installed)

;;test load load path
;(require 'test-load-path)

;;test if devtools is present
;;test if os path is configured for each devtool present
(require 'test-devtools-presence)


;(ert-deftest ert-test-mismatch ()
;  (should (eql (cl-mismatch "" "") nil))
;  (should (eql (cl-mismatch "" "a") 0))
;  (should (eql (cl-mismatch "a" "a") nil))
;  (should (eql (cl-mismatch "ab" "a") 1))
;  (should (eql (cl-mismatch "Aa" "aA") 0))
;  (should (eql (cl-mismatch '(a b c) '(a b d)) 2)))
