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
(message " ### config_proxy.el loaded sucessfully!!!")

;;https://stackoverflow.com/questions/10787087/use-elpa-emacs-behind-a-proxy-requiring-authentication/11692769#11692769
(with-eval-after-load 'url-http
  (defun url-https-proxy-connect (connection)
    (setq url-http-after-change-function 'url-https-proxy-after-change-function)
    (process-send-string connection (format (concat "CONNECT %s:%d HTTP/1.1\r\n"
                                                    "Host: %s\r\n"
                                                    (let ((proxy-auth (let ((url-basic-auth-storage
                                                                             'url-http-proxy-basic-auth-storage))
                                                                        (url-get-authentication url-http-proxy nil 'any nil))))
                                                      (if proxy-auth (concat "Proxy-Authorization: " proxy-auth "\r\n")))
                                                    "\r\n")
                                            (url-host url-current-object)
                                            (or (url-port url-current-object)
                                                url-https-default-port)
                                            (url-host url-current-object)))))

(setq url-proxy-services
   '(("http"  . "wagner:nicolas1*@192.168.0.2:3128")
     ("https" . "wagner:nicolas1*@192.168.0.2:3128")))

(setq url-http-proxy-basic-auth-storage
      (list (list "wagner:nicolas1*@192.168.0.2:3128"
                  (cons "Input your LDAP UID !"
                        (base64-encode-string "osinstall:admin123")))))

;;(skip-chars-forward "HTTP/")        ; Skip HTTP Version
;;(skip-chars-forward "http/")        ; Skip HTTP Version

(provide 'config_proxy)
