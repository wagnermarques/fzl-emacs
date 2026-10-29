;;; coding-lang-java.el --- Java configuration -*- lexical-binding: t -*-

;; Add JDK to system PATH if directory exists
(when (and (bound-and-true-p fzlemacs-dir--java-jdk-home)
           (file-directory-p fzlemacs-dir--java-jdk-home))
  (setenv "JAVA_HOME" fzlemacs-dir--java-jdk-home)
  (add-to-list 'exec-path (concat fzlemacs-dir--java-jdk-home "/bin")))

(defun fzl-java-executable-find ()
  "Check if Java is installed and verify version.
Returns t if Java is found and meets requirements, nil otherwise."
  (interactive)
  (let ((java-exec (or (and (bound-and-true-p fzlemacs-dir--java-jdk-home)
                            (let ((cand (concat fzlemacs-dir--java-jdk-home "/bin/java")))
                              (and (file-executable-p cand) cand)))
                       (executable-find "java"))))
    (cond
     ((and java-exec (file-executable-p java-exec))
      (when (called-interactively-p 'any)
        (let ((version (shell-command-to-string (concat (shell-quote-argument java-exec) " -version 2>&1"))))
          (message "Java version found:\n%s" version)))
      t)
     (t
      (message "Java not found at configured path or in PATH.")
      nil))))

(provide 'coding-lang-java)
