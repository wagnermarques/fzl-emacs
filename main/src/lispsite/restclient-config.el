;;; package --- Summary

;;; Commentary:
;;company-restclient             20190426.1312  available    melpa    company-mode completion back-end for restclient-mode
;;ob-restclient                  20230301.1951  available    melpa    org-babel functions for restclient-mode
;;restclient                     20221203.1808  available    melpa    An interactive HTTP client for Emacs
;;restclient-helm                20170314.1554  available    melpa    helm interface for restclient.el
;;restclient-jq                  20220426.1734  available    melpa    Support for setting restclient vars from jq expressions
;;restclient-test                20210422.1815  available    melpa    Run tests with restclient.el


;;;;; Code:
(use-package restclient
  :ensure t
  :mode (("\\.rest\\'" . restclient-mode)))

(use-package company-restclient
  :ensure t)

(require 'company-restclient)
(add-to-list 'company-backends 'company-restclient)


(provide 'restclient-config)


