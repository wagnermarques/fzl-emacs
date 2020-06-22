#!/bin/bash
aws s3 sync /home/wagner/envs/env-dev/sources/somewritings/var/publishing-directory/planosdeaulas/  s3://www.planosdeaulas.com.br --acl public-read
