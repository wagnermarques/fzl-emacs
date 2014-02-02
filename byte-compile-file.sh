#!/bin/bash
#http://www.cs.utah.edu/dept/old/texinfo/emacs18/emacs_26.html
#TODO:
#makes this script honor files... no just one
emacs -batch -f batch-byte-compile $1
