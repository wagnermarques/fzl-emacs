#!/bin/bash
echo "starting eclimd"
ECLIPSE_HOME=/run/media/wagner/EE2437F12437BB81/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64
ECLIM_JAR_HOME=/run/media/wagner/EE2437F12437BB81/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/eclipse

java \
  -Dvim.files=$HOME/.vim \
  -Declipse.home=$ECLIPSE_HOME \
  -jar "ECLIM_JAR_HOME/eclim_2.6.0.jar" install
