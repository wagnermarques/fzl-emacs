;;; ox-material.el --- A Google Material Design export backend for Org Mode -*- lexical-binding: t; -*-

;;; Commentary:
;; This file defines a new Org Mode export backend for HTML with
;; Google Material Design styling, using the Materialize CSS framework.

;;; Code:
(require 'ox-html)

;;;### autoload
(defvar org-material-assets-dir
  (expand-file-name "material-assets/" (file-name-directory load-file-name))
  "The directory containing the Materialize assets.")

;;; Backend Definition
(org-export-define-derived-backend 'material 'html
  :translate-alist '((template . org-material-template))
  :menu-entry
  '(?m "Export to Material HTML"
       ((?H "To HTML buffer (no assets)" org-material-export-to-html-buffer)
        (?h "To HTML file (with assets)" org-material-export-to-html-file)))
  :options-alist
  '((:material-assets-path "MATERIAL_ASSETS_PATH" nil "material-assets")))

;;; Template function
(defun org-material-template (contents info)
  "Return the complete Material Design HTML page.
CONTENTS is the transcoded contents of the Org file.
INFO is a plist holding export options."
  (let* ((title (org-export-data (plist-get info :title) info))
         (css-path (or (plist-get info :material-assets-path) "material-assets")))
    (format
     "<!DOCTYPE html>
<html lang=\"%s\">
<head>
  <meta charset=\"%s\"/>
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>
  <title>%s</title>
  <link rel=\"stylesheet\" type=\"text/css\" href=\"%s/material-icons.css\"/>
  <link rel=\"stylesheet\" type=\"text/css\" href=\"%s/materialize/css/materialize.min.css\"/>
</head>
<body>
  <div class=\"container\">
    %s
  </div>
  <script src=\"%s/materialize/js/materialize.min.js\"></script>
</body>
</html>"
     (org-export-data (plist-get info :language) info)
     (or (plist-get info :html-charset) "UTF-8")
     title
     css-path
     css-path
     contents
     css-path)))

;;; Asset Management
(defun org-material-copy-assets (output-dir)
  "Copy Materialize assets to OUTPUT-DIR."
  (let ((asset-dest (expand-file-name "material-assets" output-dir)))
    (when (not (file-exists-p asset-dest))
      (make-directory asset-dest t))
    (copy-directory org-material-assets-dir asset-dest nil t t)))

;;; Export Functions
;;;###autoload
(defun org-material-export-to-html-file (&optional async subtreep visible-only)
  "Export current buffer to a Material HTML file.
This will also copy the asset directory to the target location.
If ASYNC is non-nil, perform the export asynchronously.
If SUBTREEP is non-nil, export the current subtree.
If VISIBLE-ONLY is non-nil, export only the visible part of the buffer."
  (interactive)
  (let* ((outfile (org-export-output-file-name ".html" subtreep))
         (outdir (file-name-directory outfile)))
    (org-material-copy-assets outdir)
    (org-export-to-file 'material outfile
      async subtreep visible-only)))

;;;###autoload
(defun org-material-export-to-html-buffer (&optional async subtreep visible-only)
  "Export current buffer to a Material HTML buffer.
Note: This does not copy assets and links may be broken.
If ASYNC is non-nil, perform the export asynchronously.
If SUBTREEP is non-nil, export the current subtree.
If VISIBLE-ONLY is non-nil, export only the visible part of the buffer."
  (interactive)
  (org-export-to-buffer 'material "*Org Material Export*"
    async subtreep visible-only))

(provide 'ox-material)
;;; ox-material.el ends here
