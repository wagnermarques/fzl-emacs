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
  :translate-alist '((template . org-material-template)
                     (src-block . org-material-src-block)
                     (example-block . org-material-example-block)
                     (special-block . org-material-special-block))
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
  <link rel=\"stylesheet\" type=\"text/css\" href=\"%s/highlight/atom-one-dark.min.css\"/>
  <style>
    body { 
      background-color: #fafafa;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    }
    .container { 
      margin-top: 2rem;
      max-width: 1000px;
    }
    
    /* Headers */
    h1, h2, h3, h4, h5, h6 {
      color: #1976d2;
      margin-top: 2rem;
      margin-bottom: 1rem;
    }
    
    /* Table of Contents */
    #table-of-contents {
      background-color: white;
      padding: 1.5rem;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      margin-bottom: 2rem;
    }
    #table-of-contents h2 {
      margin-top: 0;
      color: #1976d2;
      font-size: 1.5rem;
    }
    #table-of-contents ul {
      margin-left: 1rem;
    }
    #table-of-contents a {
      color: #1976d2;
      text-decoration: none;
    }
    #table-of-contents a:hover {
      text-decoration: underline;
    }
    
    /* Code blocks */
    .code-block-wrapper {
      margin: 1.5rem 0;
    }
    .code-block-header {
      background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 8px 8px 0 0;
      font-weight: 500;
      font-size: 0.875rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    .code-block-header::before {
      content: '{ }';
      font-weight: bold;
    }
    .code-block-content {
      background-color: #282c34;
      border-radius: 0 0 8px 8px;
      overflow: hidden;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .code-block-content pre {
      margin: 0;
      padding: 1rem;
      overflow-x: auto;
    }
    .code-block-content code {
      font-family: 'Fira Code', 'Courier New', monospace;
      font-size: 0.875rem;
      line-height: 1.6;
    }
    
    /* Example/Output blocks */
    .example-block-wrapper {
      margin: 1.5rem 0;
    }
    .example-block-header {
      background: linear-gradient(135deg, #11998e 0%%, #38ef7d 100%%);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 8px 8px 0 0;
      font-weight: 500;
      font-size: 0.875rem;
    }
    .example-block-header::before {
      content: '▶ ';
      font-weight: bold;
    }
    .example-block-content {
      background-color: #f5f5f5;
      border: 1px solid #e0e0e0;
      border-top: none;
      border-radius: 0 0 8px 8px;
      padding: 1rem;
      overflow-x: auto;
    }
    .example-block-content pre {
      margin: 0;
      color: #333;
      font-family: 'Courier New', monospace;
      font-size: 0.875rem;
      line-height: 1.6;
    }
    
    /* Links */
    a {
      color: #1976d2;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    
    /* Paragraphs */
    p {
      line-height: 1.6;
      margin: 1rem 0;
    }
  </style>
</head>
<body>
  <div class=\"container\">
    %s
  </div>
  <script src=\"%s/materialize/js/materialize.min.js\"></script>
  <script src=\"%s/highlight/highlight.min.js\"></script>
  <script>
    document.addEventListener('DOMContentLoaded', (event) => {
      document.querySelectorAll('pre code').forEach((block) => {
        hljs.highlightElement(block);
      });
      var tabs = document.querySelectorAll('.tabs');
      if (tabs.length > 0) {
        M.Tabs.init(tabs, {});
      }
    });
  </script>
</body>
</html>"
     (org-export-data (plist-get info :language) info)
     (or (plist-get info :html-charset) "UTF-8")
     title
     css-path
     css-path
     css-path
     contents
     css-path
     css-path)))

;;; Source Block Handling
(defun org-material-src-block (src-block _contents info)
  "Transcode a SRC-BLOCK element for Material Design.
CONTENTS is nil.  INFO is a plist holding contextual information."
  (let* ((lang (org-element-property :language src-block))
         (code (org-element-property :value src-block))
         (label (let ((lbl (org-element-property :name src-block)))
                  (if lbl (format " id=\"%s\"" (org-html-encode-plain-text lbl)) "")))
         ;; Map Org language names to Highlight.js language names
         (hljs-lang (cond
                     ((string= lang "elisp") "lisp")
                     ((string= lang "emacs-lisp") "lisp")
                     ((string= lang "sh") "bash")
                     ((string= lang "shell") "bash")
                     (t (or lang "plaintext")))))
    (format "<div class=\"code-block-wrapper\"%s>
  <div class=\"code-block-header\">%s</div>
  <div class=\"code-block-content\">
    <pre><code class=\"language-%s\">%s</code></pre>
  </div>
</div>"
            label
            (capitalize (or lang "Code"))
            hljs-lang
            (org-html-encode-plain-text code))))

;;; Example Block Handling
(defun org-material-example-block (example-block _contents info)
  "Transcode an EXAMPLE-BLOCK element for Material Design.
CONTENTS is nil.  INFO is a plist holding contextual information."
  (let ((code (org-element-property :value example-block)))
    (format "<div class=\"example-block-wrapper\">
  <div class=\"example-block-header\">Output</div>
  <div class=\"example-block-content\">
    <pre>%s</pre>
  </div>
</div>"
            (org-html-encode-plain-text code))))

(defun org-material-tabs-block (tabs-block info)
  "Transcode a TABS block into a Materialize tab layout."
  (let* ((children (org-element-contents tabs-block))
         (src-blocks (seq-filter (lambda (el) (eq (org-element-type el) 'src-block)) children))
         (tab-id-prefix (format "tabs-%d" (random 100000)))
         (tabs-list "")
         (tabs-content ""))
    (dotimes (i (length src-blocks))
      (let* ((src-block (nth i src-blocks))
             (name (org-element-property :name src-block))
             (tab-id (format "%s-%d" tab-id-prefix i))
             (tab-title (if name (car (split-string name ":")) "Code"))
             (transcoded-src (org-export-data src-block info)))
        (setq tabs-list
              (concat tabs-list
                      (format "<li class=\"tab\"><a href=\"#%s\">%s</a></li>"
                              tab-id tab-title)))
        (setq tabs-content
              (concat tabs-content
                      (format "<div id=\"%s\" class=\"col s12\">%s</div>"
                              tab-id transcoded-src)))))
    (format "<div class=\"row\">
               <div class=\"col s12\">
                 <ul class=\"tabs\">%s</ul>
               </div>
               %s
             </div>"
            tabs-list
            tabs-content)))

(defun org-material-special-block (special-block contents info)
  "Transcode a SPECIAL-BLOCK element for Material Design.
CONTENTS is the transcoded contents of the block.
INFO is a plist holding contextual information."
  (let ((type (org-element-property :type special-block)))
    (if (string= type "TABS")
        (org-material-tabs-block special-block info)
      ;; Default behavior for other special blocks
      (format "<div class=\"special-block\">%s</div>" contents))))

;;; Asset Management
(defun org-material-copy-assets (output-dir)
  "Copy Materialize assets to OUTPUT-DIR."
  (let ((asset-dest (expand-file-name "material-assets" output-dir)))
    (when (not (file-exists-p asset-dest))
      (make-directory asset-dest t))
    (copy-directory org-material-assets-dir asset-dest nil t t)))

;;; Export Functions
;;;###autoload
(defun org-material-export-to-html-file (&optional async subtreep visible-only pub-dir)
  "Export current buffer to a Material HTML file.
This will also copy the asset directory to the target location.
If ASYNC is non-nil, perform the export asynchronously.
If SUBTREEP is non-nil, export the current subtree.
If VISIBLE-ONLY is non-nil, export only the visible part of the buffer."
  (interactive)
  (let* ((outfile (org-export-output-file-name ".html" subtreep pub-dir))
         (outdir (file-name-directory outfile)))
    (org-material-copy-assets outdir)
    (org-export-to-file 'material outfile
      async subtreep visible-only)))

;;;###autoload
(defun org-material-export-to-html-buffer (&optional async subtreep visible-only pub-dir)
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
