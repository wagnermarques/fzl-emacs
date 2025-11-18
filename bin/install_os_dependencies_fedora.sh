#!/bin/bash

sudo dnf update -y

echo .
echo ==> install_os_dependencies_fedora.sh running

echo .
echo imagemagick installation
sudo dnf install imagemagick -y

echo .
echo graphviz installation... ->plantuml needs it too
sudo dnf install graphviz -y

echo .
echo plantuml installation...
sudo dnf install plantuml -y

echo .
echo Installing debugpy to enable debuging python
pip install debugpy

