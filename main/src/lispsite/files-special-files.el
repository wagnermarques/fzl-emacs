
(defvar fzl-special-files
  '(
    "/media/wgn/EnvsBk/__devenv__"
    "/media/wgn/EnvsBk/__devenv__/fzl-emacs/"
    "/media/wgn/EnvsBk/__devenv__/fzl-emacs/main/src/lispsite/"
    "/media/wgn/EnvsBk/__devenv__/fzl-emacs/index.org"
    "/media/wgn/EnvsBk/__devenv__/Amb_Dev/projects/text_projects"
    "/media/wgn/EnvsBk/__devenv__/_devenv_cdep3/proj-integrador/integrador/"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Tasks.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Tasks_Projects.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Datas.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Tasks/Logbook.org"
    "/media/wgn/EnvsBk/_0_Tasks_&_Notes_&_Dates__/_0_Notes"
    "/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/"
    "/media/wgn/d4ae1cfc-8228-4bec-a0cc-c6b7345e29bd/PROGSATIVOS/setup-progsativos-scripts/"
    "/media/wgn/EnvsBk/Documentos_Pess_Wgn_Pgtos/"
))

(defun fzl-open-special-file ()
  "Prompt to select a file from `fzl-special-files` and open it."
  (interactive)
  (let ((file (completing-read "Select file: " fzl-special-files)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f o") 'fzl-open-special-file)

(provide 'files-special-files)
