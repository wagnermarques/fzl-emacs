;;; restclient-config.el --- Configuration for restclient mode

;;; Commentary:
;;; Comprehensive configuration for restclient-mode with common settings

;;; Code:

(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode)
  :bind (:map restclient-mode-map
         ("C-c C-c" . restclient-http-send-current)
         ("C-c C-r" . restclient-http-send-current-raw)
         ("C-c C-v" . restclient-http-send-current-stay-in-window))
  
  :config
  ;; Custom variables for restclient
  (setq-default
   ;; Timeout for HTTP requests (in seconds)
   restclient-request-timeout 10
   
   ;; Default headers to include in all requests
   restclient-default-headers
   '(("Content-Type" . "application/json")
     ("Accept" . "application/json"))
   
   ;; Enable automatic pretty-printing of JSON responses
   restclient-inhibit-cookies nil
   
   ;; Highlight response codes
   restclient-highlight-response-codes t)

  ;; Optional: Integration with company-mode for auto-completion
  (use-package company-restclient
    :ensure t
    :after (restclient company)
    :config
    (add-to-list 'company-backends 'company-restclient)))

;;; Support for variables and environments
(defvar restclient-current-environment 'development
  "Current environment for restclient requests.")

(defvar restclient-environments
  '((development . ((base-url . "http://localhost:8080")
                    (api-key . "dev-secret-key")))
    (staging . ((base-url . "https://staging-api.example.com")
                (api-key . "staging-secret-key")))
    (production . ((base-url . "https://api.example.com")
                   (api-key . "prod-secret-key"))))

(defun restclient-set-environment (env)
  "Set the current restclient environment to ENV."
  (interactive 
   (list (intern (completing-read "Select environment: " 
                                  (mapcar #'car restclient-environments)))))
  (setq restclient-current-environment env)
  (message "Restclient environment set to %s" env))

;;; Example .http file template function
(defun restclient-create-template ()
  "Create a new restclient template file."
  (interactive)
  (let ((filename (read-file-name "Save restclient template as: "
                                  nil nil nil "request.http")))
    (with-temp-file filename
      (insert "# Restclient Request Template\n"
              "# Use variables like :env for dynamic configuration\n\n"
              "# GET Request Example\n"
              "GET {{base-url}}/users\n"
              "Authorization: Bearer {{api-key}}\n\n"
              "# POST Request Example\n"
              "POST {{base-url}}/users\n"
              "Content-Type: application/json\n"
              "Authorization: Bearer {{api-key}}\n\n"
              "{\n"
              "    \"name\": \"John Doe\",\n"
              "    \"email\": \"john@example.com\"\n"
              "}\n"))
    (find-file filename)))

(provide 'pkgconfig-restclient)
;;; restclient-config.el ends here
