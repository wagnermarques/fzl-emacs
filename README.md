emacsinitfile
=============

The intent of emacsinitfile is support develop source code within the
presence of another tools that compose a enviroment that I called FZLBPMS.
I've been use this develope tools for diary task too.

But the BPMS is still a dream for me, for now. With several fantastic peace of software together like nexus, maven, eclipse and some framework the main intent is to provide a bpms plataform to develope softwares.
So, when its require to be define FZL_HOME envionment is for find the several tools and framework.
So the expected enviroment variables is


# USAGE


## Getting the Sources
git clone 

https://github.com/wagnermarques/emacsinitfile.git


## Export enviroment variables

I have ben use this enviroment variables, change it accordingle...

export FZL_HOME=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/

export JAVA_HOME=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/jdks/jdk1.8.0_65/

export FZL_HOME_SERVER=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlServer/ 


## start emacs with emacsinitfile configurations

cd to emacsinitfile source code
emacs -q -l &


## or all together
 export JAVA_HOME=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/jdks/jdk1.8.0_65/ && export FZL_HOME=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/ && export FZL_HOME_SERVER=/run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/fzlbpms/fzlServer/ && cd /run/media/wagner/Seagate\ Expansion\ Drive/wagnerdocri@gmail.com2/envs/env-dev/sources/emacsinitfile/ && emacs -q -l init.el

##TODO
### Desabilitar init.el pra usar so o init2.el
### corrigir a função interativa fzl-hsqldb 
A funcao start-process nao ta funcionando com o comando java -jar

     

wagner
wagnerdocri@gmail.com
