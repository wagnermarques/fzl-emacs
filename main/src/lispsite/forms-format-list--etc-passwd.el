"-*- forms -*-"
;; This demo visits /etc/passwd.
(setq forms-file "/etc/passwd")
(setq forms-number-of-fields 7)
(setq forms-read-only t)                 ; to make sure
(setq forms-field-sep ":")
;; Don’t allow multi-line fields.
(setq forms-multi-line nil)

(setq forms-format-list
      (list
      "===== arquivo etc/passwd===="
       "User : "    1 
       "   Uid: "   3 
       "   Gid: "   4 
       "\n\n"
       "Name : "    5
       "\n\n"
       "Home : "    6
       "\n\n"
       "Shell: "    7
       "\n"))
