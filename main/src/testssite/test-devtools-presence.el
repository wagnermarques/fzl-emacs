;;test java,ant,maven,gradle,karaf,android,jekill,sqlite,hqlsl,squirrel

(print " =>=>=> test-devtools-presence.el was loaded sucessfully!!!")

(require 'global_variables_setup)

(defun ert-test-if-java-jdk-is-present-fixture (body)
  (unwind-protect ;https://www.gnu.org/software/emacs/manual/html_node/elisp/Cleanups.html
      (progn
	(require 'test-devtools-presence)
        (funcall body))
    (unload-feature 'package)))


(ert-deftest ert-test-if-java-jdk-is-present()
  )


(provide 'test-devtools-presence)
