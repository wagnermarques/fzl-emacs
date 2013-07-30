;;;; este arquivo customiza o emacs para utiliza-lo 
; para tarefas com fzlbpms
; para que o seu emacs seja configurado inicitalize ele da seguinte maneira
;
; emacs -q -l caminho_para_este_arquivo_que_vc_esta_lendo_agora
;

;;;; fzlbpms init file
; wagnerdocri@gmail.com

;some refs
;http://ergoemacs.org/emacs/elisp_basics.html
;http://www.mygooglest.com/fni/dot-emacs.html
;http://www.emacswiki.org/emacs/ajc-java-complete-my-config-example.el                     



(message "\n\n\n
-----------------------------------
F Z L B P M S \n
C U S T O M I Z A T I O N   E M A C S \n
I N I T    F I L E    E X E C U T I N G    N O W . . .")
(message "\n\n\n")

;; Set the debug option to enable a backtrace when a
;; problem occurs.
(setq debug-on-error t)

; guardando o momento em que o emacs subiu
(setq current-time-at-emacs-startup (current-time))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;Setting some global variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; S e t a n d o    a l g u m a s   v a r i Ã¡ v e i s    g l o b a i s  (visiveis para todos os buffers)
; obs.: 					
;       mesmo sendo global, um buffer pode fazer essa variavel virar local
;       pra isso e so fazer 
;       M-x make-local-variable RET var RET
;
;       http://www.delorie.com/gnu/docs/emacs/emacs_485.html
;       quando um buffer tornar uma variavel global em local, ao alterar o vlr dessa variavel localmente
;       isso nao afeta o valor da variavel global e o valor da global sendo alterada nao afeta o valor da local.
;       M-x make-variable-buffer-local RET var RET
;       Mark variable var so that setting it will make it local to the buffer that is current at that time. 
;

;http://superuser.com/questions/84164/how-do-i-stop-emacs-from-creating-backup-files
;http://stackoverflow.com/questions/4088681/get-path-to-current-emacs-script-file-when-loaded-with-l-parameter
;from http://www.emacswiki.org/EmacsNiftyTricks
;controlling default dir where C-x C-f visit files...(NAO FUNCIONOU...)
;http://stackoverflow.com/questions/60464/changing-the-default-folder-in-emacs
;(setq default-directory "~/fzlbpms/" )

;(message "internal vars inventary... 
;          %s"
;	 (default-directory))


;http://www.dgp.toronto.edu/~ghali/emacs.html
;(defvar system-type-as-string (prin1-to-string system-type))
;(defvar on_gnu_linux  (string-match "gnu/linux" system-type-as-string))

;variaveis de ambiente do fzlbpms
(defvar *FZL_HOME* (getenv "FZL_HOME"))
(defvar *FZL_APPS_HOME* (getenv "FZL_APPS_HOME"))
(defvar *fzl_emacs_config_dir* (concat *FZL_HOME* "/etc/emacs"))
(defvar *fzl-backup-dir* (concat *FZL_HOME* "~/fzlbpms/backups/emacs/autosaved_files/"))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;;;basic configuration...
;;;;;http://xenon.stanford.edu/~manku/dotemacs.html
;;;;;
;;;;;
;;;;;
;;;;;some lines are commeting because some errors arrived still need do be fixed
;;;;;
;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R e m o v i n g    A n n o y a n c e s 

;(setq inhibit-startup-message t) ;will inhibit startup messages.
(setq require-final-newline t) ;will make the last line end in a carriage return.
(fset 'yes-or-no-p 'y-or-n-p) ;will allow you to type just "y" instead of "yes" when you exit.
(setq next-line-add-newlines nil) ;will disallow creation of new lines when you press the "arrow-down key" at end of the buffer. 


;       o mode default, ao inves de text-mode, vamos utilizar o org-mode
(setq-default major-mode 'org-mode)

;conjunto de caracteres latin 1 he mais interessante que UTF-8
;(set-language-environment "Latin-1")
(set-language-environment "Latin-1")
 
;
(setq default-directory *FZL_HOME*)

;Desabilitando controlx control z
(global-unset-key "\C-x\C-z")


;; Permanent display of line and column numbers is handy.
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)


;; Set cursor and mouse colours:
(set-cursor-color "yellow")
(set-mouse-color "white")


;; Treat .rhtml files as HTML
(setq auto-mode-alist (cons '("\\.rhtml\\'" . html-mode) auto-mode-alist))
;(setq backup-directory-alist '((".*" . (concat *FZL_HOME* "/backups/emacs/autosaved_files/"))))
;(setq backup-directory-alist `(("." . *fzl-backup-dir*))) FIXME
(setq backup-directory-alist `(("." . "~/fzlbpms/backups/emacs/autosaved_files/")))



;G e n e r a l    E m b e l l i s h m e n t s 
(setq modifier-keys-are-sticky t) 
;will make ctrl, shift, alt "sticky" in xemacs. 
;(Does anybody know how to do this in emacs?) 
;With sticky-keys, you dont have to hold down the ctrl/shift/alt key and another key simultaneosly. 
;For example, to type ctrl-a, you'd have to tap on the 'ctrl'-key, followed by a tap on the 'a'-key. This feature is useful for folks with sore wrists/hands.
(setq message-log-max 512) ;will reduce the number of messages that appear in the "*Messages*" window to 512.
(setq display-time-day-and-date t) (display-time) ;will make the display of date and time persistent.
(require 'paren) (show-paren-mode t) ;will highlight matching parentheses next to cursor.
(setq-default indent-tabs-mode nil) ;will introduce spaces instead of tabs by default.
(setq-default truncate-lines t) ;will trucate lines if they are too long. (OBSERVAR PRA VER SE PERMANECE COM ESSA CONF)
(setq-default truncate-partial-width-windows nil) ;will trucate even when screen is split into multiple windows.
;(require 'auto-show) (auto-show-mode 1) (setq-default auto-show-mode t) ;load auto-show (shows lines when cursor moves to right of long line).
;(auto-show-make-point-visible) ;will position the cursor to end of output in shell mode.
;(auto-show-make-point-visible) ;will position cursor to end of output in shell mode automatically.
(transient-mark-mode t) ;will highlight region between point and mark.
(setq query-replace-highlight t) ;will highlight during query.
(setq search-highlight t) ;highlight incremental search
(setq default-major-mode 'text-mode) ;will make text-mode default.
;(global-font-lock-mode t t) ;means that we want fontification in all modes.
;(setq font-lock-maximum-decoration t) ;denotes our interest in maximum possible fontification.
(type-break-mode) ;get intermittent messages to stop typing

;(setq enable-recursive-minibuffers t) ;; allow recursive editing in minibuffer
;(resize-minibuffer-mode 1)            ;; minibuffer gets resized if it becomes too big
;(follow-mode t)                       ;; follow-mode allows easier editing of long files 

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)
(global-set-key [delete] 'delete-char)

(set-background-color "dark slate gray")
(set-foreground-color "blanched almond")

;ativa numero de linhas nos buffers
(global-linum-mode 1)

;ativa numero da coluna
(column-number-mode 1)

;desabilitando aquela pagina inicial do emacs, legal mas desecessária
(setq inhibit-startup-message t)

;tanbem nao vamos utilizar o buffer sratch
(kill-buffer "*scratch*")



;;________________________________________________________________
;;  Handle files with mixed UNIX and DOS line endings.
;;  http://marc.info/?l=tex-br&m=122278754619960
;;________________________________________________________________

;; Ativa a quebra automatica de linhas para todos os modos. Para desativá-la,
;; substitua "1" por "0", na linha abaixo.
(add-hook 'text-mode-hook
     '(lambda () (auto-fill-mode 1)))

;; Se a quebra automatica de linhas estiver ativada, as linhas são
;; quebradas se ultrapassarem a coluna 70.
(setq fill-column 70)

;Eu também consegui resolver o problema da auto-correção de palavras
;grafadas erradamente. Para que o flyspell seja carregado
;automaticamente, basta fazer:

;; Sugerir correcoes de textos grafados erradamente (COM CODIGO ISSO NAO FICOU BOM... PELO MENOS COM WSDLS)
;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;(add-hook 'message-mode-hook 'turn-on-flyspell)
;(add-hook 'text-mode-hook 'turn-on-flyspell)
;(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;(add-hook 'tcl-mode-hook 'flyspell-prog-mode)
;(defun turn-on-flyspell ()
;   "Force flyspell-mode on using a positive arg.  For use in hooks."
;   (interactive)
;   (flyspell-mode 1))
;   (flyspell-mode 0))















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;configuring load-path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path
      (append (list nil (concat *FZL_HOME* "/etc/emacs/"))
              load-path))

(add-to-list 'load-path
             (concat *FZL_HOME* "/etc/emacs/yasnippet"))
(add-to-list 'load-path
             (concat *FZL_HOME* "/etc/emacs/magit"))

(add-to-list 'load-path 
             (concat *FZL_HOME* "/etc/emacs/auto-complete-1.3.1/byte-compiled"))

(add-to-list 'load-path 
              (concat *FZL_HOME* "/etc/emacs/cedet/cedet-1.1/common"))

(add-to-list 'load-path 
             (concat  *FZL_HOME* "/etc/emacs/js2-mode"))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))



;; turn on Common Lisp support
(require 'cl)  ; provides useful things like `loop' and `setf'

;y a s n i p p e t
;https://github.com/capitaomorte/yasnippet
(require 'yasnippet)          
;;(yas/initialize) isso nao tava funcionando, sem isso os snippets para java funcionavam ok
(yas-global-mode 1)
;y a s n i p p e t - j a v a - m o d e
;http://capitaomorte.github.com/yasnippet/snippet-organization.html#loading-snippets
;; Develop and keep personal snippets under ~/emacs.d/mysnippets
(setq yas/root-directory (concat *FZL_HOME* "/etc/emacs/yasnippets_defined_for_fzlbpms"))
;; Load the snippets
(yas/load-directory yas/root-directory)


;m a g i t
;~compatable~ with 24.3 (required by magit)
(load-file (concat *FZL_HOME* "/etc/emacs/cl-lib-0.2.el"))
;(require 'cl-lib-0.2.el)
(require 'magit)


; i n s t a l a n d o    a u t o c o m p l e t e
(require 'auto-complete-config) ;https://github.com/auto-complete/auto-complete/issues/26
(add-to-list 'ac-dictionary-directories (concat *FZL_HOME* "/etc/emacs/auto-complete-1.3.1/byte-compiled/dict"))
(ac-config-default)


; i n s t a l a n d o   c e d e t
(load-file
 (concat *FZL_HOME* "/etc/emacs/cedet-1.1/common/cedet.el"))

(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;http://emacswiki.org/emacs/SpeedBar
;Speedbar Without A Separate Frame

 ;abre speedbar automaticamente M-x speedbar tambem funciona
;ref uteis
;http://www.mygooglest.com/fni/dot-emacs.html

;speed bar "show all files" por padrao
;ref: http://stackoverflow.com/questions/2220005/how-do-i-enable-speedbar-to-display-all-types-of-files
(custom-set-variables
 '(speedbar-show-unknown-files t)
)

; i n s t a l a n d o    a u t o - j a v a - c o m p l e t e
;https://raw.github.com/emacs-java/auto-java-complete/0.2.8/Install
;(add-to-list 'load-path 
;	     (concat *fzl_emacs_config_dir* "/site/auto-java-complete/"))
;(require 'ajc-java-complete-config)
;(add-hook 'java-mode-hook 'ajc-java-complete-mode)
;(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

; FIM i n s t a l a n d o    a u t o - j a v a - c o m p l e t e


;;; i n s t a l a n d o    o   j a v a d o c - h e l p . e l 
;;(add-to-list 'load-path (concat *fzl_emacs_config_dir* "/site/javadoc-help-site"))
;;  Next add the following to your .emacs startup file.
;;    (require 'javadoc-help)
;;
;;  or add the autoloads for the public command functions.
;;    (autoload 'javadoc-lookup       "javadoc-help" "Look up Java class in Javadoc."   t)
;;    (autoload 'javadoc-help         "javadoc-help" "Open up the Javadoc-help menu."   t)
;;    (autoload 'javadoc-set-predefined-urls  "javadoc-help" "Set pre-defined urls."    t)
;;; Configuration:
;;
;;  Assign the commands to some keys in your .emacs file.
;;
;;  Examples below assign a set of keys to the javadoc-help functions.
;;    (global-set-key [(f1)]          'javadoc-lookup)  ; F1 to lookup
;;    (global-set-key [(shift f1)]    'javadoc-help)    ; Shift-F1 to bring up menu
;;
;;  Javadoc-help uses browse-url to launch the system web browser.  Make sure
;;  it's working for your platform.  Try it out with, M-x browse-url.  Usually
;;  browse-url defaults to the OS default browser.  Some the OS default browser
;;  might not be set up.  Use 'M-x customize-option' browse-url-browser-function
;;  to pick a specific browser, (like setting Firefox as the browser to use).

;;;;;ending configuring load-path








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;this init file are splited 
;;;;;so, to it works, load the modules are needed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;plugins configurations (requires...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;magit
;needs (load-file (concat *FZL_HOME* "/etc/emacs/cl-lib-0.2.el"))
;nedds donwload uncompressed in *FZL_HOME* "/etc/emacs/magit
;(require 'magit)




;________________________________
;;    javascript-mode
;;________________________________

;(setq auto-mode-alist (cons '("\\.js\\'" . java-mode) auto-mode-alist))

;; no good:
;;(autoload 'javascript-mode "javascript-mode")
;;(setq auto-mode-alist
;;      (cons '("\\.js\\'" . javascript-mode) auto-mode-alist))




;; ________________________________
;;    xml-mode
;; ________________________________

(setq auto-mode-alist (cons '("\\.ipe\\'" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.qrc\\'" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.svg\\'" . xml-mode) auto-mode-alist))


;________________________________________________________________
;;    Calendar TODO configurar para pt-BR
;;________________________________________________________________

;(setq calendar-latitude [43 40 north])
;(setq calendar-longitude [79 24 west])
;(setq calendar-time-zone -300)
;(setq calendar-location-name "Toronto")


;;________________________________________________________________
;;    Handle files with mixed UNIX and DOS line endings.
;;________________________________________________________________

(defun remove-dos-eol ()
  "Do not use '^M' in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))










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











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;C O N F I G U R I N G 
;S O M E   S P E C I F I C    M O D E S
;AND SPECIFIC THINGS

;;CONFIGURING ORG-MODE
;;https://email.esm.psu.edu/pipermail/macosx-emacs/2011-October/003027.html
;; Conventional selection/deletion 
(setq org-support-shift-select t)

; thanks to PT (org-mode list)
(defun my-org-mode-stuff ()
  "define selection by keyboard similar to Mac and Windows"
  (require 'pc-select)
  (local-set-key (kbd "C-S-<right>") 'forward-word-mark)
  (local-set-key (kbd "C-S-<left>") 'backward-word-mark)
  (local-set-key (kbd "S-<right>") 'forward-char-mark)
  (local-set-key (kbd "S-<left>") 'backward-char-mark)
  (local-set-key (kbd "S-<up>") 'previous-line-mark)
  (local-set-key (kbd "S-<down>") 'next-line-mark))

(add-hook 'org-mode-hook 'my-org-mode-stuff)




;;SPEEDBAR
;https://sites.google.com/site/xiangyangsite/home/linux-unix/emacs/speedbar-in-one-frame
(require 'tramp)
(defconst my-junk-buffer-name "Junk")
(setq junk-buffer (get-buffer-create my-junk-buffer-name)
      )
(require 'speedbar)
(defconst my-speedbar-buffer-name "SPEEDBAR")
(setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
      speedbar-frame (selected-frame)
      dframe-attached-frame (selected-frame)
      speedbar-select-frame-method 'attached
      speedbar-verbosity-level 0
      speedbar-last-selected-file nil)
(setq right-window (split-window-horizontally 24))
(setq left-window (frame-first-window))
;(walk-windows (lambda (w) (setq left-window w)) "nominibuffer" t)
(set-buffer speedbar-buffer)
(speedbar-mode)
(speedbar-reconfigure-keymaps)
(speedbar-update-contents)
(speedbar-set-timer 1)
(set-window-buffer left-window "SPEEDBAR")
(set-window-dedicated-p left-window t)
(toggle-read-only) ; HACK, REQUIRED for Tramp to work ????
(select-window right-window)
(defun select-right-window () (select-window right-window))
;(defun reset-window-config () (interactive)
; (walk-windows (lambda (w) (when (not (or (eq w left-window) (eq w right-window))) (delete-window w))) "nominibuffer" t)
; )
(defun reset-window-config () (interactive)
  (delete-other-windows)
  (setq right-window (split-window-horizontally 24))
  (setq left-window (frame-first-window))
  (set-window-buffer left-window speedbar-buffer)
  (set-window-dedicated-p left-window t)
  (select-window right-window)
  (set-window-dedicated-p right-window nil)
  (when (eq speedbar-buffer (window-buffer right-window)) (set-window-buffer right-window (next-buffer)))
  (set-window-dedicated-p right-window nil)
  )
(global-set-key "\C-x1" 'reset-window-config)





;Controlling history of sql mode
;http://how-to.linuxcareer.com/customizing-emacs-for-development

;good SQL mode must know how to deal with various database sql implementations in order to be useful
; have a look at the more bleeding-edge Lisp:sql, but we will just look at SqlMode.

;Let's get to work. 
;To get to the SQL interpreter from a window already in SQL mode, do this: 
;M-x sql-set-sqli-buffer Return *SQL* Return. 

;What follows is a very practical code snippet for saving history separately for each SQL dialect (e.g. Sybase, MSSQL, and so on). 
;In order for this to work, just create a sql directory under ~/.emacs.d, then add this hook to ~/.emacs:
(defun my-sql-save-history-hook ()
    (let ((lval 'sql-input-ring-file-name)
          (rval 'sql-product))
      (if (symbol-value rval)
          (let ((filename 
                 (concat "~/.emacs.d/sql/"
                         (symbol-name (symbol-value rval))
                         "-history.sql")))
            (set (make-local-variable lval) filename))
        (error
         (format "SQL history will not be saved because %s is nil"
                 (symbol-name rval))))))
  (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)


;http://floatsolutions.com/blog/2010/10/displaying-inline-images-in-emacs-org-mode/
;; -- Display images in org mode
;; enable image mode first
(iimage-mode)
;; add the org file link format to the iimage mode regex
(add-to-list 'iimage-mode-image-regex-alist
(cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))
;; add a hook so we can display images on load
(add-hook 'org-mode-hook '(lambda () (org-turn-on-iimage-in-org)))
;; function to setup images for display on load
(defun org-turn-on-iimage-in-org ()
"display images in your org file"
(interactive)
(turn-on-iimage-mode)
(set-face-underline-p 'org-link nil))

;; function to toggle images in a org bugger
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))

  (call-interactively 'iimage-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












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



;aprendi isso em http://snipplr.com/view/18678/loadmyfavoritefile/
;pra usar he so fazer o seguinte depois que o emacs tiver carregado
;M-x load-emacs-initfile RET
;seguir o exemplo por demais arquivos

(defun fzl-dev-edit-emacs-initfile ()
  " abre arquivo de configuracao/customizacao do emacs do fzlbpms"
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-etc/etc/emacs/emacsinitfile/init.el"))
)

(defun fzl-dev-edit-fzl-message-org-file()
  (interactive)
  (find-file (concat *FZL_APPS_HOME* "/fzlbpms-etc/etc/emacs/fzl-messages.org"))
  (org-toggle-inline-images)
)

(defun fzl-dev-edit-scripts-de-builds-fzlbpms()
  (interactive)
  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/exportar_fzlbpms.sh")
  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlfn_exportadir_etc.sh")
  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlfn_exportadir_bin")
  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlbpms_utils___shared_functions.sh")
  (find-file  "/home/administrador/fzlbpms_related/fzlbpms-apps/fzlbpms_utils___handle_script_parameters.sh")
)



;;f u n c s para abrir arquivos de build/exportacao
(defun fzl-dev-edit-file-exportar_fzlbpms()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/exportar_fzlbpms.sh"))
)
(defun fzl-dev-edit-file-fzlfn_exportadir_etc()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_etc.sh"))
)
(defun fzl-dev-edit-file-fzlfn_exportadir_bin()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlfn_exportadir_bin.sh"))
)
(defun fzl-dev-edit-file-fzlbpms_utils___shared_functions()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___shared_functions.sh"))
)
(defun fzl-dev-edit-file-fzlbpms_utils___handle_script_parameters()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms_utils___handle_script_parameters.sh"))
)



;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
(defun fzl-dev-edit-binproject-file-fzl_svn_status()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_status.sh"))
)                                                               
(defun fzl-dev-edit-binproject-file-fzl_svn_co_fzlbms_bin()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/svn_scripts/fzl_svn_co_fzlbms_bin.sh"))
)
;funcs para abrir e editar arquivos do projeto binproject (svn_scritps)
(defun fzl-dev-edit-binproject-files-envconfig-envsetup-and-fzl_startup()
  (interactive)
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_startup.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_config.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_env.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_paths.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_config_variables.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup.sh"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_env_setup_runner.c"))
  (find-file  (concat *FZL_APPS_HOME* "/fzlbpms-bin/bin/fzl_utils.sh"))
)



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






; M O S T R A N D O   O    F Z L - M E S S A G E S . O R G
(find-file (concat *FZL_HOME*  "/etc/emacs/fzl-messages.org"))




;P R I N T I N G    F I N A L     C O N F I G U R A T I O N 

(defun get_tempo_de_carregamento_do_emacs (time-qdo-o-emacs-comecou-a-subir) 
  (time-to-seconds (time-since time-qdo-o-emacs-comecou-a-subir))
)

(message "PRINTING SOME FINAL CONFIGURATION PARAMETERS")
(message "M e n s a g e n s    f i n a i s    d o    f z l _ e m a c s _ i n i t f i l e . e l")
(message "get_tempo_de_carregamento_do_emacs = %d" (get_tempo_de_carregamento_do_emacs current-time-at-emacs-startup))
(message "FZL_HOME = %s " *FZL_HOME* )
(message "fzl_emacs_config_dir = %s" *fzl_emacs_config_dir*)








