#!/bin/bash
echo "starting eclimd"

ECLIPSE_HOME=/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/eclipse/eclipse-jee-neon-1a-linux-gtk-x86_64
#ECLIPSE_HOME=/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/eclipse/eclipse-jee-oxygen-1a-linux-gtk-x86_64/plugins

ECLIM_JAR_HOME=/run/media/wagner/51d54d26-34c8-4671-8da1-c12adc7a5a2c/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/eclipse



java \
  -Dvim.files=$HOME/.vim \
  -Declipse.home=$ECLIPSE_HOME \
  -jar "$ECLIM_JAR_HOME/eclim_2.7.0.jar" install
