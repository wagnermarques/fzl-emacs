(defvar fzl-scorm-version "1.2"
  "SCORM version for the package.")

(defvar fzl-scorm-schema "ADL SCORM"
  "SCORM schema identifier.")

(defvar fzl-scorm-schemaversion "1.2"
  "SCORM schema version.")

(defvar fzl-scorm-title "SCORM Package"
  "Title of the SCORM package.")

(defvar fzl-scorm-manifest-version "1.0"
  "Version of the SCORM manifest.")

(defvar fzl-scorm-manifest-identifier "MANIFEST1"
  "Identifier for the SCORM manifest.")




(defvar fzl-scorm-organizations-default "ORG1"
  "Default organization identifier.")

(defvar fzl-scorm-organization-identifier "ORG1"
  "Organization identifier.")

(defvar fzl-scorm-organization-title "Organization"
  "Title of the organization.")

(defvar fzl-scorm-zip-filename "fzl-scorm.zip"
"Zip file name of generated zip filename")



;;; lesson parameters
(defvar fzl-scorm-content-files-pattern "content-.*\\.html$"
  "Regex pattern for content page files.")

(defvar fzl-scorm-question-files-pattern "question-.*\\.html$"
  "Regex pattern for question page files.")

(defvar fzl-scorm-content-title-prefix "Lesson: "
  "Prefix for content page titles.")

(defvar fzl-scorm-question-title-prefix "Quiz: "
  "Prefix for question page titles.")



(defun fzl-read-scorm-properties (dir)
  "Read SCORM settings from scorm_package_settings.properties in DIR."
  (let ((props-file (expand-file-name "scorm_package_settings.properties" dir))
        (settings '()))
    (when (file-exists-p props-file)
      (with-temp-buffer
        (insert-file-contents props-file)
        (goto-char (point-min))
        (while (re-search-forward "^\\([^=]+\\)=\\(.*\\)$" nil t)
          (push (cons (match-string 1) (match-string 2)) settings))))
    settings))



(defun fzl-set-scorm-variables-from-props (props)
  "Set SCORM variables from PROPS alist."
  (dolist (prop props)
    (let ((key (car prop))
          (value (cdr prop)))
      (cond
       ((string= key "fzl-scorm-title") (setq fzl-scorm-title value))
       ((string= key "fzl-scorm-organization-title") (setq fzl-scorm-organization-title value))
       ((string= key "fzl-scorm-zip-filename") (setq fzl-scorm-zip-filename value))
       ((string= key "fzl-scorm-content-title-prefix") (setq fzl-scorm-content-title-prefix value))
       ((string= key "fzl-scorm-question-title-prefix") (setq fzl-scorm-question-title-prefix value))
       ))))



(defun fzl-check-required-files (dir type)
  "Check if required files for TYPE are present in DIR."
  (let ((required
         (cond
          ((string= type "lesson") '("content-.*\\.html" "question-.*\\.html" "API.js"))
          ((string= type "assignment") '("assignment\\.html" "API.js"))
          ((string= type "page") '("page\\.html" "API.js"))
          ((string= type "quiz") '("question-.*\\.html" "API.js"))
          (t (error "Unknown type: %s" type)))))
    (dolist (pattern required)
      (unless (directory-files dir nil pattern)
        (error "Required file pattern '%s' not found for type '%s'" pattern type)))))



(defun fzl-edu-tools-scorm-generation (dir type)
  "Generate SCORM package from DIR for TYPE (lesson, assignment, page, quiz)."
  (interactive (list (read-directory-name "Directory: ")
                     (completing-read "SCORM Type: " '("lesson" "assignment" "page" "quiz") nil t)))
  (let ((dir (expand-file-name dir)))
    (fzl-check-required-files dir type)
    (let ((props (fzl-read-scorm-properties dir)))
      (fzl-set-scorm-variables-from-props props))
    ;; Now call the creation function
    (fzl-edu-tool-create-scorm-package-internal dir type)))



(defun fzl-edu-tool-create-scorm-package-internal (dir &optional type)
  "Create sample HTML files for a SCORM lesson in DIR.
Creates content pages and a question page with basic SCORM API integration."
  (interactive "DDirectory: ")
  (let ((dir (expand-file-name dir)))
    ;; Create content page 1
    (with-temp-file (expand-file-name "content-lesson1.html" dir)
      (insert "<!DOCTYPE html>
<html>
<head>
<title>Lesson 1</title>
<script src='API.js'></script>
</head>
<body>
<h1>Lesson 1: Introduction</h1>
<p>This is the first lesson content.</p>
<button onclick='doLMSCommit();'>Mark as Complete</button>
</body>
</html>"))
    ;; Create content page 2
    (with-temp-file (expand-file-name "content-lesson2.html" dir)
      (insert "<!DOCTYPE html>
<html>
<head>
<title>Lesson 2</title>
<script src='API.js'></script>
</head>
<body>
<h1>Lesson 2: Advanced Topics</h1>
<p>This is the second lesson content.</p>
<button onclick='doLMSCommit();'>Mark as Complete</button>
</body>
</html>"))
    ;; Create question page
    (with-temp-file (expand-file-name "question-quiz1.html" dir)
      (insert "<!DOCTYPE html>
<html>
<head>
<title>Quiz</title>
<script src='API.js'></script>
</head>
<body>
<h1>Quiz</h1>
<p>What is 2+2?</p>
<input type='radio' name='answer' value='4'>4<br>
<input type='radio' name='answer' value='5'>5<br>
<button onclick='submitQuiz();'>Submit</button>
<script>
function submitQuiz() {
  var answer = document.querySelector('input[name=answer]:checked').value;
  if (answer === '4') {
    doLMSSetValue('cmi.core.score.raw', '100');
    doLMSSetValue('cmi.core.lesson_status', 'passed');
  } else {
    doLMSSetValue('cmi.core.score.raw', '0');
    doLMSSetValue('cmi.core.lesson_status', 'failed');
  }
  doLMSCommit();
  alert('Quiz submitted!');
}
</script>
</body>
</html>"))
    ;; Create basic API.js (simplified SCORM API)
    (with-temp-file (expand-file-name "API.js" dir)
      (insert "var API = {
  LMSInitialize: function() { return 'true'; },
  LMSFinish: function() { return 'true'; },
  LMSGetValue: function(key) { return ''; },
  LMSSetValue: function(key, value) { return 'true'; },
  LMSCommit: function() { return 'true'; },
  LMSGetLastError: function() { return '0'; },
  LMSGetErrorString: function() { return ''; },
  LMSGetDiagnostic: function() { return ''; }
};
function doLMSCommit() { API.LMSCommit(); }
function doLMSSetValue(key, value) { API.LMSSetValue(key, value); }"))
    (message "Sample SCORM content created in %s" dir)))



(defun fzl-edu-tool-create-scorm-package-internal (dir &optional type)
  "Create a SCORM package from HTML files in DIR.
This function generates imsmanifest.xml and zips the directory."
  (let* ((content-pattern (cond ((string= type "lesson") fzl-scorm-content-files-pattern)
                               ((string= type "assignment") "assignment\\.html")
                               ((string= type "page") "page\\.html")
                               ((string= type "quiz") "")
                               (t fzl-scorm-content-files-pattern)))
         (question-pattern (cond ((string= type "lesson") fzl-scorm-question-files-pattern)
                                 ((string= type "assignment") "")
                                 ((string= type "page") "")
                                 ((string= type "quiz") "question-.*\\.html")
                                 (t fzl-scorm-question-files-pattern)))
         (content-title-prefix (cond ((string= type "lesson") fzl-scorm-content-title-prefix)
                                     ((string= type "assignment") "Assignment: ")
                                     ((string= type "page") "Page: ")
                                     ((string= type "quiz") "")
                                     (t fzl-scorm-content-title-prefix)))
         (question-title-prefix (cond ((string= type "lesson") fzl-scorm-question-title-prefix)
                                      ((string= type "assignment") "")
                                      ((string= type "page") "")
                                      ((string= type "quiz") "Quiz: ")
                                      (t fzl-scorm-question-title-prefix)))
         (dir (expand-file-name dir))
         (html-files (directory-files dir t "\\.html$"))
         (content-files (if (string= content-pattern "") nil (seq-filter (lambda (f) (string-match-p content-pattern (file-name-nondirectory f))) html-files)))
         (question-files (if (string= question-pattern "") nil (seq-filter (lambda (f) (string-match-p question-pattern (file-name-nondirectory f))) html-files)))
         (all-files (append content-files question-files))
         (manifest-path (expand-file-name "imsmanifest.xml" dir))
         (zip-name fzl-scorm-zip-filename)
         (zip-path (expand-file-name zip-name dir)))

    (with-temp-file manifest-path
      (insert (format "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<manifest identifier=\"%s\" version=\"%s\"
 xmlns=\"http://www.imsproject.org/xsd/imscp_rootv1p1p2\"
 xmlns:adlcp=\"http://www.adlnet.org/xsd/adlcp_rootv1p2\"
 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
 xsi:schemaLocation=\"http://www.imsproject.org/xsd/imscp_rootv1p1p2 imscp_rootv1p1p2.xsd
 http://www.adlnet.org/xsd/adlcp_rootv1p2 adlcp_rootv1p2.xsd\">
 <metadata>
  <schema>%s</schema>
  <schemaversion>%s</schemaversion>
  <title>%s</title>
 </metadata>
 <organizations default=\"%s\">
  <organization identifier=\"%s\">
   <title>%s</title>" fzl-scorm-manifest-identifier fzl-scorm-manifest-version fzl-scorm-schema fzl-scorm-schemaversion fzl-scorm-title fzl-scorm-organizations-default fzl-scorm-organization-identifier fzl-scorm-organization-title))
      (dolist (html all-files)
        (let* ((basename (file-name-base html))
               (is-content (seq-contains-p content-files html))
               (title-prefix (if is-content content-title-prefix question-title-prefix))
               (title (concat title-prefix basename)))
          (insert (format "
   <item identifier=\"ITEM%s\" identifierref=\"RES%s\">
    <title>%s</title>
   </item>" basename basename title))))
      (insert "
  </organization>
 </organizations>
 <resources>")
      (dolist (html all-files)
        (let ((basename (file-name-base html))
              (rel-path (file-relative-name html dir)))
          (insert (format "
  <resource identifier=\"RES%s\" type=\"webcontent\" adlcp:scormtype=\"sco\" href=\"%s\">
   <file href=\"%s\" />
  </resource>" basename rel-path rel-path))))
      (insert "
 </resources>
</manifest>"))
    ;; Zip the directory
    (shell-command (format "cd %s && zip -r %s ." (shell-quote-argument (file-name-directory manifest-path)) zip-name))
    (message "SCORM package created: %s" zip-path)))

(provide 'edu-tool-scorm-generator)
