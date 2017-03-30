

;;from https://www.reddit.com/r/emacs/comments/3inht4/emacs_25_on_windows_behind_a_proxy_cant_download/
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
	("all" . "http://wagner:nicolas1*@192.168.0.2:3128/")
	("http" . "http://wagner:nicolas1*@192.168.0.2:3128/")
	("https" . "http://wagner:nicolas1*@192.168.0.2:3128/")))

(setq url-http-proxy-basic-auth-storage
    (list (list "http://wagner:nicolas1*@192.168.0.2:3128/"
            (cons "Input your LDAP UID !"
                  (base64-encode-string "LOGIN:PASSWORD")))))

(provide 'config_proxy)
