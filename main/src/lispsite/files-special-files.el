
(setq disk  "/media/wgn/EnvsBk1")
(setq disk2 "/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd")


(defvar fzl-special-files
  (mapcar (lambda (path) (concat disk path))
          '("/__devenv__"
            "/__devenv__/fzl-emacs/"
            "/__devenv__/fzl-emacs/main/src/lispsite/"
            "/__devenv__/fzl-emacs/index.org"
            "/__devenv__/AmbDev/projects/textprojects"
            "/__devenv__/devenv_cdep3/proj-integrador/integrador/"
            "/_0_Tasks_&_Notes_&_Dates__/"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Tasks.org"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/TasksProjects.org"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Datas.org"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Logbook.org"
            "/_0_Tasks_&_Notes_&_Dates__/_0_Notes")))

(setq fzl-special-files
      (append fzl-special-files
              (mapcar (lambda (path) (concat disk2 path))
                      '("/PROGSATIVOS/"
                        "/PROGSATIVOS/setup-progsativos-scripts/"
                        "/DocumentosPessWgn_Pgtos/"))))

(defun fzl-open-special-file ()
  "Prompt to select a file from `fzl-special-files` and open it."
  (interactive)
  (let ((file (completing-read "Select file: " fzl-special-files)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f o") 'fzl-open-special-file)

(provide 'files-special-files)
