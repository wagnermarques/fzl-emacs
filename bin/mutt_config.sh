#!/bin/bash
#yout ~/.muttrc needs to be write
chmod 777 ~/.muttrc
mkdir -p ~/mutt
mkdir -p ~/.mutt/cache/headers
mkdir -p ~/.mutt/cache/bodies
mkdir -p ~/.mutt/certificates
> ~/.mutt/muttrc

cp ./mutt_account* ~/.mutt

set editor=emacsclient
set pager=emacsclient



