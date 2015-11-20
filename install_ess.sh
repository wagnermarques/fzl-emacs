#!/bin/bash
#git clone https://github.com/emacs-ess/ESS.git
cd ESS
#make
#make instal
DESTDIR=/usr
PREFIX=$(DESTDIR)

##__ GNU Emacs __
echo "DESTDIR=$(DESTDIR)"
EMACS=emacs
SITELISP=$(PREFIX)/share/emacs/site-lisp
LISPDIR=$(SITELISP)/ess
INFODIR=$(PREFIX)/share/info
ETCDIR=$(PREFIX)/share/emacs/etc/ess
echo 
echo "PREFIX=$PREFIX"
echo "EMACS=$EMACS"
echo "SITELISP=$SITELISP"
echo "LISPDIR=$LISPDIR"
echo "INFODIR=$INFODIR"
echo "ETCDIR=$ETCDIR"
