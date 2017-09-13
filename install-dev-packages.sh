
#!/bin/bash

#Run it or some parts to install programming languages in you linux
#I am using fedora 22, change the command accordingle with your linux box


#php
dnf install php mod_suphp -y

#C/C++
dnf install kernel-devel kernel-headers gcc gcc-c++ -y
dnf groupinstall "C Development Tools and Libraries"

#phyton 
pip3 install pylint -y
#https://matplotlib.org/users/index.html
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


#References
#http://www.flycheck.org/manual/latest/Quickstart.html
