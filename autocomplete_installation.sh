#!/bin/bash
#http://cx4a.org/software/auto-complete/manual.html

cd $FZL_HOME/etc/emacs/sitelisp/packages
wget http://cx4a.org/pub/auto-complete/auto-complete-1.3.1.tar.bz2
tar -xvf auto-complete-1.3.1.tar.bz2
cd auto-complete-1.3.1
echo "make byte-compile..."
make byte-compile

#autocomplete for xml
cd $FZL_HOME/etc/emacs/sitelisp/packages-checkouts/          
git clone https://github.com/aki2o/auto-complete-nxml.git
# put auto-complete-nxml.el in lisp load-path

echo "$LINE"
