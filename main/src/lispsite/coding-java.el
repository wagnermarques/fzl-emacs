(use-package java-snippets
  :ensure t)


(setq *JAVA_HOME* (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-jdks/jdk-17.0.3"))
(setq *GRADLE_HOME* (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-build/gradle-7.4.2"))
(setq *M2_HOME* (concat (getenv "HOME") "/mnt/ext4/PROGSATIVOS/java-build/apache-maven-3.8.4"))
(setq *ANT_HOME* " ")

(setenv "JAVA_HOME" *JAVA_HOME*)
(setenv "GRADLE_HOME" *GRADLE_HOME*)

;;Linux PATH separated by :
(setq gradleExecPath (concat (getenv "JAVA_HOME") "/bin:"))
(setq javaExecPath (concat (getenv "GRADLE_HOME") "/bin:"))
(setq mvnExecPath (concat (getenv "M2_HOME") "/bin:"))



(defun fzl-add-to-path(pathToBeAdded)
  (setenv "PATH" (concat pathToBeAdded (getenv "PATH"))))  

(fzl-add-to-path gradleExecPath)
(fzl-add-to-path javaExecPath)
(fzl-add-to-path mvnExecPath)

(message (getenv "PATH"))
(provide 'coding-java)
