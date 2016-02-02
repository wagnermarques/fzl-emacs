(provide 'fzl_functions)

(defun fzl-set-default-directory-to-FZL_HOME-etc() 
  'set default directory to FZL_HOME etc' 
  (interactive)
  (setq default-directory (concat *FZL_HOME* "/etc"))
  (speedbar-refresh))

(defun fzl-bash-find-files-with-grep (dir, grepPattern)
  "find dir -type f -exec grepPattern -l {} ';'"
  (interactive "sdir a ser pesquisado: \nsgrepPattern: ")
   (message (shell-command-to-string
    (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"))))

(defun fzl-bash-find-files-by-name-pattern (dir, namePattern)
  "find dir -type f -name '*namePattern'"
  (interactive "sdir to be searched: \nsnamePattern: ")
   (message (split-string (shell-command-to-string
    (format "find %s -type f -name '*namePattern*'")))))

;;eclipse modelling
(defun fzl-eclipse-modeling--start()
  "start eclipse modelling"
  (interactive)
  (message "(defun start_eclipse()...")
  (shell-command-to-string
   "/home/administrador/progsativos/fzlbpms/integrated/eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/eclipse"))

(defun fzl-eclipse-modeling--wrksp-dired-find-file()
  "list files in eclipse modelling workspace"
  (interactive)
  (message "(defun fzl-eclipse-modeling--wrksp-list-files()...")
  (dired-find-file
   "/home/administrador/progsativos/fzlbpms/wrksp-eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/"))

(defun fzl-eclipse-modeling--wrksp-log()
  "show error log"
  (interactive)
  (message "(defun fzl-eclipse-modeling--error-log()...")
  (find-file
   "/home/administrador/progsativos/fzlbpms/wrksp-eclipse/eclipse-modeling-mars-1-linux-gtk-x86_64/.metadata/.log"))




(defun fzl-eclipse-reporting--start()
  "start eclipse reporting"
  (interactive)
  (message "(defun start_eclipse()...")
  (shell-command-to-string
   "/home/administrador/progsativos/fzlbpms/integrated/eclipse/eclipse-reporting-mars-1-linux-gtk-x86_64/eclipse"))


(defun fzl-maven-settings()
  "open maven settings.xml"
  (interactive)
  (find-file (concat **M2_HOME** "/config/settings.xml")))

(defun fzl-open-log-emacsinitfile-logs()
  "open the wrapper.log nexus file"
  (interactive)
  (find-file **EMACSINITFILE_LOG_FILE**))

(defun fzl-nexus-settings-xml()
  "open the wrapper.log nexus file"
  (interactive)
  (find-file (concat **NEXUS_HOME** "/config/settings.xml")))

(defun fzl-nexus-url()
  "open nexus"
  (interactive)
  (shell-command "firefox http://localhost:8081/nexus/#welcome"))



;(svt 'klklkl')


;(defun svt-find-grep (sDiretorio, sGrepPattern)
;  "find dir -type f -exec grepIt -l {} ';'"
;  (interactive "sDiretorio a ser pesquisado \nsGrepPattern")
;  (shell-command-to-string
;   (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"
;           (expand-file-name dir t) 
;           (sGrepPattern))))


;(defun svt-find-and-grep-files (dir, grepIt)
;  "find dir -type f -exec grepIt -l {} ';'" 
; (shell-command-to-string
;    (format "find %s -type f -exec grep %s {} ';'"
;            (expand-file-name dir t) grepIt)));


;(svt-find-and-grep-files "." "auto-complete-config")

;(message (exec-to-string "pwd"))
;(defun multiple-hello (someone num)
;  "Say hello to SOMEONE via M-x hello, for NUM times."
;  (interactive "sWho do you want to say hello to? \nnHow many times? ")
;  (dotimes (i num)
;    (insert (format "Hello %s!\n" someone))))


;http://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Sequences.html


