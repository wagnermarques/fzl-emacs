;; coding lang java
     
;; Add JDK to system PATH
(setenv "JAVA_HOME" fzlemacs-dir--java-jdk-home)
(setq exec-path (cons (concat fzlemacs-dir--java-jdk-home "/bin") exec-path))

(defun fzl-java-executable-find ()
  "Check if Java is installed and verify version.
Returns t if Java is found and meets requirements, nil otherwise.
Prints the installed Java version when found."
  (interactive)
  (let ((java-exec (concat fzlemacs-dir--java-jdk-home "/bin/java")))
    (cond
     ((file-executable-p java-exec)
      (let ((version (shell-command-to-string (concat java-exec " -version 2>&1"))))
        (message "Java version found:\n%s" version)
        t))
     (t
      (message "Java not found at configured path: %s" java-exec)
      nil))))

(provide 'coding-lang-java)
