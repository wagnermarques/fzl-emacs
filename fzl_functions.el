;;; evt_functions.el --- functions facilitate use of emacs in evtbpms enviroment

;; Emacs Lisp Archive Entry
;; Filename: evt_functions.el
;; Version: 0.0   (or RCS/CVS *Revision*)
;; Keywords: svtbpms emacs .emacs
;; Author: wagner franca marques
;; Maintainer: wagner franca marques
;; Created: 2013-12-12
;; Description: init.el for svtbpms customization
;; URL: not yet
;; Compatibility: emacs 24




;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;; for more details. http://www.gnu.org/copyleft/gpl.html  




;;; Install:

;; 
;; put this file in you site-lisp and require it
;; (require 'svt_functions)
;; 
;;
;;



;;  TODO:
;;  versionate this emacs customization... I still do not know how to do it
;;
;;      (defvar XXX-version (substring "$Revision: 1.2 $" 11 15)
;;       "Version number")

      ;;  ...Or include this
      ;;
;;      (defvar XXX-version-id
;;       "$Id: index-body.html,v 1.2 2008/09/15 12:59:38 jaalto Exp $"
;;       "Latest modification time and version number.")    


;;TODO apply Elint.el  and  lm-verify and modifications requested by this tools

(provide 'fzl_functions)

;(defun svt-cd-etc() 
;  'change dir to SVT_HOME/etc' 
;  (interactive)
;  (setq default-directory *SVT_ETC_DIR*)
;  (speedbar-refresh));;

;(defun svt-open-initel-file()
;  "svt-open-initel-file"
;  (find-file (concat *FZL_HOME*  "/etc/emacs/fzl-messages.org")))



;(defun svt-find-grep (sDiretorio, sGrepPattern)
;  "find dir -type f -exec grepIt -l {} ';'"
;  (interactive "sDiretorio a ser pesquisado" "sGrepPattern")
;  (split-string
;   (shell-command-to-string
;    (format "find %s -type f -exec grep %s {} ';' -printf '%%h\\n' | sort -u"

;(defun svt(p)
;  (split-string 
;;   (shell-command-to-string 
;    (format "echo %s" p)));

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


