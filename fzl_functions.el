(provide 'fzl_functions)


(defun fzl_new_shell(shell_name)
  (interactive shell_name)
  (fzl_open_shell_in_a_buffer shell_name)
  )

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
  (find-file (concat **M2_HOME** "conf/settings.xml")))

(defun fzl-open-log-emacsinitfile-logs()
  "open emacsinitfile log"
  (interactive)
  (find-file **EMACSINITFILE_LOG_FILE**))

(defun fzl-nexus-settings-xml()
  "open the wrapper.log nexus file"
  (interactive)
  (find-file (concat **NEXUS_HOME** "/config/settings.xml")))

(defun fzl-nexus-url()
  "open nexus welcome url"
  (interactive)
  (shell-command "firefox http://localhost:8081/#browse/welcome"))




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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; fzlbpms functions definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(defun open-fzlbpms-initfile ()
; "open emacs init file"
; (find-file " /run/media/wagner/Mass memory/fzlbpms/etc/emacs/checkouts/emacsinitfile/init.el"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C U S T O M I Z A N D O A S M E S S A G E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;credits of (defun what-line ()
;http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/what_002dline.html
;(defun line-num ()
; "Print the current line number (in the buffer) of point."
; (save-restriction
; (widen)
; (save-excursion
; (beginning-of-line)
; (1+ (count-lines 1 (point))))))
;(message (line-num))
;(concatenate 'stringc "abcd" "efg")
;(message 'stringc)

;(defun fzl-string-message (strMsg)
; (setq buffer_name (buffer-name))
; (setq line_num (line-num))
; (setq msg_prefix (concat buffer_name line_num))
; ;(message (concat msg_prefix strMsg))
;)

;;;;temp(fzl-string-message "mensagem..." )

;(defun fzl-string-message (strMsg)
; (message (concat
;         (get-buffer-name) strMsg)))
;
;(defun fzl-list-message (listMsg)
; (message "init.el (list message) -> %S" listMsg))

;(fzl-string-message "printin string mensagem...")
;(fzl-list-message (1 2 3 4))



;(defun fzl-task-manager-file ()
; " abre arquivo de configuracao do emacs do fzlbpms
; The function is poorly named, didn't really want to 'load' it, just open it."
; (interactive)
; (find-file (concat *FZL_HOME* "/workspaces/administrador/tasks.org"))
;)

;(defun fzl-guia-de-instalacao ()
; " abre guia de instalação do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms_guia_de_instalacao"))
;)


;(defun fzl-documentacao ()
; " abre arquivo de documentacao do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms_documentacao"))
;)

;(defun fzl-calendar-controller ()
; " abre arquivo calendar controller"
; (interactive)
; (find-file (concat *FZL_HOME* "/workspaces/ant_projects/fzlbpms_ant_projects_enviroment/libjs/fzlViews/calendar/calendarController.js"))
;)

;(defun fzl-configurar-orbeon()
; " abre arquivo calendar controller"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-orbeon.org"))
;)

;(defun fzl-configurar-maven()
; " abre arquivos de configuracao do maven"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-maven.org"))
;)


;(defun fzl-configurar-existdb()
; " abre arquivos de configuracao do existdb"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-existdb.org"))
;)



;(defun fzl-configurar-tomcat7()
; " abre arquivos de configuracao do tomcat7"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-tomcat7.org"))
;)

;(defun fzl-configurar-liferay()
; " abre arquivos de configuracao do liferay"
; (interactive)
; (find-file (concat *FZL_HOME* "/etc/fzl-configurar-liferay.org"))
;)


;(defun fzl-comandos()
; " abre arquivo de comandos do fzlbpms"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms-comandos.org"))
;)

;(defun fzl-bookmark()uff
; " abre arquivo de bookmark"
; (interactive)
; (find-file (concat *FZL_HOME* "/fzlbpms-bookmark.org"))
;)






;;; UTILITY FUNCTION FOR MESSAGE
;Directive Interpretation
; --------- --------------
; ~% new line
; ~& fresh line
; ~| page break
; ~T tab stop
; ~< justification
; ~> terminate ~<
; ~C character
; ~( case conversion
; ~) terminate ~(
; ~D decimal integer
; ~B binary integer
; ~O octal integer
; ~X hexadecimal integer
; ~bR base-b integer
; ~R spell an integer
; ~P plural
; ~F floating point
; ~E scientific notation
; ~G ~F or ~E, depending upon magnitude
; ~$ monetary
; ~A legibly, without escapes
; ~S READably, with escapes
; ~~ ~

;;; format t
;https://github.com/m2ym/auto-complete

;(defun fzl-message (msg)
; (message
; (format t         
;         "init.el -> %s" "msg")))
;(defun fzl-string-message (strMsg)
 ; (format t "~A" strMsg ))


;(message (fzl-string-message "CARREGADO COM SUCESSO"))


; (let ((groceries '(eggs bread butter carrots)))
; (format t "~{~A~^, ~}.~%" groceries) ; Prints in uppercase
; (format t "~@(~{~A~^, ~}~).~%" groceries)) ; Capitalizes output
 ;; ⇒ EGGS, BREAD, BUTTER, CARROTS.
 ;; ⇒ Eggs, bread, butter, carrots.

(provide 'fzl_customization_functions)








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; fzlbpms functions definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(defun open-fzlbpms-initfile ()
;  "open emacs init file"
;  (find-file " /run/media/wagner/Mass memory/fzlbpms/etc/emacs/checkouts/emacsinitfile/init.el"))


;(defun myCommand ()
;  "One sentence summary of what this command do.

;More details here. Be sure to mention the return value if relevant.
;Lines here should not be longer than 70 chars,
;and don't indent them."
;  (interactive)
;  (let (localVar1 localVar2 …)
;    (setq localVar1 …)
;    (setq localVar2 …)
;    ;; do something …
;  )
;)







;;; UTILITY FUNCTION FOR MESSAGE
;Directive   Interpretation
;  ---------   --------------
;     ~%       new line
;     ~&       fresh line
;     ~|       page break
;     ~T       tab stop
;     ~<       justification
;     ~>       terminate ~<
;     ~C       character
;     ~(       case conversion
;     ~)       terminate ~(
;     ~D       decimal integer
;     ~B       binary integer
;     ~O       octal integer
;     ~X       hexadecimal integer
;     ~bR      base-b integer
;     ~R       spell an integer
;     ~P       plural
;     ~F       floating point
;     ~E       scientific notation
;     ~G       ~F or ~E, depending upon magnitude
;     ~$       monetary
;     ~A       legibly, without escapes
;     ~S       READably, with escapes
;     ~~       ~

;;; format t
;https://github.com/m2ym/auto-complete

;(defun fzl-message (msg)
;  (message 
;   (format t 	 
;	   "init.el -> %s" "msg")))
;(defun fzl-string-message (strMsg)  
 ;  (format t "~A" strMsg ))


;(message (fzl-string-message "CARREGADO COM SUCESSO"))


; (let ((groceries '(eggs bread butter carrots)))
;   (format t "~{~A~^, ~}.~%" groceries)         ; Prints in uppercase
;   (format t "~@(~{~A~^, ~}~).~%" groceries))   ; Capitalizes output
 ;; ⇒ EGGS, BREAD, BUTTER, CARROTS.
 ;; ⇒ Eggs, bread, butter, carrots.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C U S T O M I Z A N D O   A S    M E S S A G E S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;credits of (defun what-line ()
;http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/what_002dline.html
;(defun line-num ()
;       "Print the current line number (in the buffer) of point."
;       (save-restriction
;         (widen)
;         (save-excursion
;           (beginning-of-line)           
;                    (1+ (count-lines 1 (point))))))
;(message (line-num))
;(concatenate 'stringc "abcd" "efg")
;(message 'stringc)

;(defun fzl-string-message (strMsg) 
;  (setq buffer_name (buffer-name))
;  (setq line_num (line-num))
;  (setq msg_prefix (concat buffer_name line_num))
;  ;(message (concat msg_prefix strMsg))
;)

;;;;temp(fzl-string-message "mensagem..." )

;(defun fzl-string-message (strMsg)
;  (message (concat 
;	    (get-buffer-name)  strMsg)))
;
;(defun fzl-list-message (listMsg)
;  (message "init.el (list message) -> %S" listMsg))

;(fzl-string-message "printin string mensagem...")
;(fzl-list-message (1 2 3 4))




;;f u n c s para abrir arquivos de build/exportacao
;(defun fzl-dev-edit-file-exportar_fzlbpms()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/exportar_fzlbpms.sh"))
;)
;(defun fzl-dev-edit-file-fzlfn_exportadir_etc()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_etc.sh"))
;)
;(defun fzl-dev-edit-file-fzlfn_exportadir_bin()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_bin.sh"))
;)
;(defun fzl-dev-edit-file-fzlbpms_utils___shared_functions()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___shared_functions.sh"))
;)
;(defun fzl-dev-edit-file-fzlbpms_utils___handle_script_parameters()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___handle_script_parameters.sh"))
;)



;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
;(defun fzl-dev-edit-binproject-file-fzl_svn_status()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_status.sh"))
;)                                                               
;(defun fzl-dev-edit-binproject-file-fzl_svn_co_fzlbms_bin()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_co_fzlbms_bin.sh"))
;)
;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
;(defun fzl-dev-edit-binproject-files-envconfig-envsetup-and-fzl_startup()
;  (interactive)
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_startup.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_config.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_env.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_paths.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_variables.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup.sh"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup_runner.c"))
;  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_utils.sh"))
;)



;(defun fzl-task-manager-file ()
;  " abre arquivo de configuracao do emacs do fzlbpms
;    The function is poorly named, didn't really want to 'load' it, just open it."
;  (interactive)
;  (find-file  (concat *FZL_HOME* "/workspaces/administrador/tasks.org"))
;)

;(defun fzl-guia-de-instalacao ()
;  " abre guia de instalação do  fzlbpms"
;  (interactive)
;  (find-file  (concat *FZL_HOME* "/fzlbpms_guia_de_instalacao"))
;)


;(defun fzl-documentacao ()
;  " abre arquivo de documentacao do fzlbpms"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms_documentacao"))
;)

;(defun fzl-calendar-controller ()
;  " abre arquivo calendar controller"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/workspaces/ant_projects/fzlbpms_ant_projects_enviroment/libjs/fzlViews/calendar/calendarController.js"))
;)

;(defun fzl-configurar-orbeon()
;  " abre arquivo calendar controller"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-orbeon.org"))
;)

;(defun fzl-configurar-maven()
;  " abre arquivos de configuracao do maven"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-maven.org"))
;)


;(defun fzl-configurar-existdb()
;  " abre arquivos de configuracao do existdb"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-existdb.org"))
;)



;(defun fzl-configurar-tomcat7()
;  " abre arquivos de configuracao do tomcat7"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-tomcat7.org"))
;)

;(defun fzl-configurar-liferay()
;  " abre arquivos de configuracao do liferay"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/etc/fzl-configurar-liferay.org"))
;)


;(defun fzl-comandos()
;  " abre arquivo de comandos do fzlbpms"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms-comandos.org"))
;)

;(defun fzl-bookmark()uff
;  " abre arquivo de bookmark"
;  (interactive)
;  (find-file (concat *FZL_HOME* "/fzlbpms-bookmark.org"))
;)





















