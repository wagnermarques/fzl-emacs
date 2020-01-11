;;; package --- Summary

;;; Commentary:
;;https://www.emacswiki.org/emacs/MuttInEmacs

;;; Code:

(require 'cl-lib)
;; -*- coding: utf-8; lexical-binding: t; -*-

;;all files whose name contains “/mutt” to be in mail-mode
(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(unless (file-directory-p "~/.mutt/account.com.gmail.wagnerdocri")
  (make-directory "~/.mutt/account.com.gmail.wagnerdocri"))

(unless (file-directory-p "~/.mutt/account.com.yahoo.wagnerejucara")
  (make-directory "~/.mutt/account.com.yahoo.wagnerejucara"))

(unless (file-directory-p "~/.mutt/account.br.gov.sp.etec.wagnermarques3")
  (make-directory "~/.mutt/account.br.gov.sp.etec.wagnermarques3"))

(unless (file-directory-p "~/.mutt/account.com.hotmail.wagnerfrancamarques")
  (make-directory "~/.mutt/account.com.hotmail.wagnerfrancamarques"))

(unless (file-directory-p "~/.mutt/account.br.usp.wagnermarques")
  (make-directory "~/.mutt/account.br.usp.wagnermarques"))

(fzl-mutt)

(provide 'mutt_config)
;;; this_file_name.el ends here
