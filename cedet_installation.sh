#!/bin/bash

#TODO if textinfo is not installed to install it automatically
#http://cedet.sourceforge.net/setup.shtml
#yum install texinfo

cd $FZL_HOME/etc/emacs/downloaded-packages
wget http://downloads.sourceforge.net/project/cedet/cedet/cedet-1.1.tar.gz
tar -xvf cedet-1.1.tar.gz
cd cedet-1.1
make clean-all
make EMACS=emacs

