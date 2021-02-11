#!/bin/bash
aws s3 sync "$FZLBPMS_HOME/emacs/org-publishing-directory/aws-s3-planosdeaulas"  s3://www.planosdeaulas.com.br --acl public-read
