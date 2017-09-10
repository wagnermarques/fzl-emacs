#!/bin/bash

#Run it or some parts to install programming languages in you linux
#I am using fedora 22, change the command accordingle with your linux box


#php
dnf install php mod_suphp -y

#C/C++
dnf install kernel-devel kernel-headers gcc gcc-c++ -y
dnf groupinstall "C Development Tools and Libraries"

#phyton 
pip install pylint

#ruby
gem install rubocop ruby-lint

#javascript
dnf install nodejs npm -y
npm install phantomjs #to render html in org-mode



#latex
dnf install texlive -y



#References
#http://www.flycheck.org/manual/latest/Quickstart.html
