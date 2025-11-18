#!/bin/bash

# A script to export an Org Mode file to Material Design HTML using the fzl-emacs configuration.

# --- Configuration ---
# Path to the init.el file for this Emacs configuration.
# This needs to be an absolute path.
EMACS_INIT_FILE="/run/media/wgn/ext4/Projects-Srcs-Desktop/fzl-emacs/main/src/lispsite/init.el"

# --- Script Logic ---

# Check if a file path was provided as an argument.
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/your/file.org"
  exit 1
fi

# The Org file to be exported.
ORG_FILE_PATH=$(realpath "$1")

# Check if the provided file exists.
if [ ! -f "$ORG_FILE_PATH" ]; then
  echo "Error: File not found at '$ORG_FILE_PATH'"
  exit 1
fi

echo "Exporting '$ORG_FILE_PATH' to Material HTML..."

# Run Emacs in batch mode to perform the export.
# --batch: Run in non-interactive mode.
# --load: Load the specified init file.
# --visit: Open the specified Org file.
# --eval: Execute the Lisp code to run our export function.
emacs --batch \
      --load "$EMACS_INIT_FILE" \
      --visit "$ORG_FILE_PATH" \
      --eval '(org-material-export-to-html-file)'

# Check the exit code of the Emacs command.
if [ $? -eq 0 ]; then
  echo "Export successful."
  echo "Output file should be located in the same directory as the source file."
else
  echo "Error: Emacs export failed."
  exit 1
fi
