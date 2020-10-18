
;;from https://www.reddit.com/r/emacs/comments/3inht4/emacs_25_on_windows_behind_a_proxy_cant_download/
;(setq url-proxy-services
;      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;	("all" . "192.168.0.2:3128")
;	("http" . "192.168.0.2:3128")
;        ("ftp" . "192.168.0.2:3128")
;	("https" . "192.168.0.2:3128'")))

;(setq url-proxy-services
;      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;	("all" . "wagner:nicolas1*@192.168.0.2:3128/")
;	("http" . "wagner:nicolas1*@192.168.0.2:3128/")
;	("https" . "wagner:nicolas1*@192.168.0.2:3128/")))

;(setq url-http-proxy-basic-auth-storage
;    (list (list "wagner:nicolas1*@192.168.0.2:3128/"
;            (cons "Input your LDAP UID !"
;                  (base64-encode-string "wagner:nicolas1*")))))

(setq url-proxy-services
   '(("http"  . "192.168.0.2:3128")
     ("https" . "192.168.0.2:3128")))

(setq url-http-proxy-basic-auth-storage
      (list (list "192.168.0.2:3128"
                  (cons "Input your LDAP UID !"
                        (base64-encode-string "wagner:nicolas1*")))))

;;(skip-chars-forward "HTTP/")        ; Skip HTTP Version
;;(skip-chars-forward "http/")        ; Skip HTTP Version

(provide 'config_proxy)
