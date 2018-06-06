
#!/bin/bash

#Run it or some parts to install programming languages in you linux
#I am using fedora 22, change the command accordingle with your linux box


sudo dnf install rclone

#docker
#https://developer.fedoraproject.org/tools/docker/docker-installation.html
sudo dnf install docker
sudo systemctl enable docker
sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
newgrp docker



#for daily taks
sudo dnf install mutt



#sqlite3
#f27
#https://developer.fedoraproject.org/tech/database/sqlite/about.html
sudo dnf install sqlite sqlite-devel sqlite-tcl sqlite-jdbc
sudo dnf install sqliteman #gui for sqlite

#php
dnf install php mod_suphp -y

#C/C++
dnf install kernel-devel kernel-headers gcc gcc-c++ -y
dnf groupinstall "C Development Tools and Libraries"

#phyton 
#https://matplotlib.org/users/index.html

#jedi is a an awesome autocompletion/static analysis library for Python #https://github.com/davidhalter/jedi
#Elpy, the Emacs Lisp Python Environment #https://github.com/jorgenschaefer/elpy
#rope, a python refactoring library #https://github.com/python-rope/rope
pip3 install elpy rope jedi 
pip3 install matplotlib -y

#ruby
gem install rubocop ruby-lint

#javascript
dnf install nodejs npm -y
npm install phantomjs -y #to render html in org-mode



#latex (install manually) (change the installation dir acordingly your needs)
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvzf install-tl-unx.tar.gz --directory /home/wagner/wagnerdocri@gmail.com2/PROGSATIVOS/
mv ./install-dev-packages-latex-config.sh /etc/profile.d/
yum install perl-Tk -y #texlive dep
echo "which pdflatex..."
which pdflatex

#R
dnf install R -y #R.x86_64 : A language for data analysis and graphics


#LINTERS FOR FLYCKEC USE
#lit for python
pip install pylint -y
pip3 install pylint -y

#lint  for javascript
npm install eslint -y

#lint for typescript
#https://palantir.github.io/tslint/
#Switch to the root of your TypeScript to create tslint.jsonconfig with tslint --init
npm install typescript -g -y
npm install tslint -g -y


#azure cli
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install azure-cli

#References
#http://www.flycheck.org/manual/latest/Quickstart.html


