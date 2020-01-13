#!/bin/bash

#docker
#https://developer.fedoraproject.org/tools/docker/docker-installation.html
dnf install -y git docker
systemctl enable docker
#groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
#newgrp docker

#for daily taks
dnf install -y mutt rclone ImageMagick


#general packages

     

#sqlite3 I am using a binary downloaded - see global_variables_setup.el

#php
dnf install php mod_suphp -y

#C/C++ (I just a begginer.. so lets the basics and more  tools)
dnf install kernel-devel kernel-headers -y
dnf install -y make automake autoconf gcc gcc-c++ libpng-devel zlib-devel poppler-glib-devel
dnf groupinstall -y "C Development Tools and Libraries"

#phyton 
#https://matplotlib.org/users/index.html

#jedi is a an awesome autocompletion/static analysis library for Python #https://github.com/davidhalter/jedi
#Elpy, the Emacs Lisp Python Environment #https://github.com/jorgenschaefer/elpy
#rope, a python refactoring library #https://github.com/python-rope/rope
pip3 install -y elpy rope jedi 
pip3 install -y matplotlib

#ruby
#https://developer.fedoraproject.org/tech/languages/ruby/ror-installation.html
dnf install -y ruby-devel zlib-devel
gem install rubocop ruby-lint
gem install rails

#javascript
dnf install nodejs npm -y
npm install phantomjs -y #to render html in org-mode
npm install eslint -y



#latex (install manually) (change the installation dir acordingly your needs)
#https://fedoramagazine.org/fedora-classroom-latex-101-beginners/
#https://ask.fedoraproject.org/en/question/128525/installing-texlive-in-fedora-29/
dnf install texlive-scheme-full texlive-latex texlive-bibtex --enablerepo=updates-testing

#R
dnf install R -y #R.x86_64 : A language for data analysis and graphics

#PYTHON
#https://fedoralovespython.org/
#https://developer.fedoraproject.org/tech/languages/python/scipy.html
#http://developer-portal.github.io/contributing/
#https://developer.fedoraproject.org/tech/languages/python/micropython.html
#https://fedoramagazine.org/python-3-7-now-available-in-fedora/
dnf install python3-numpy python3-scipy python3-matplotlib python3-ipython python3-pandas python3-sympy notebook
#LINTERS FOR FLYCKEC USE
#lit for python
pip install pylint -y
pip3 install pylint -y


#lint for typescript
#https://palantir.github.io/tslint/
#Switch to the root of your TypeScript to create tslint.jsonconfig with tslint --init
npm install typescript -g -y
npm install tslint -g -y

#TRAVIS
#https://docs.travis-ci.com/user/tutorial/


