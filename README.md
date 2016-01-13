emacsinitfile
=============


yet another emacs init file 
---------------------------
I've been using this configuration of emacs working with my fzlbpms
project enviroment (fzlbpms is just a project with a lot of text to edit)

If you want to use this init.el without fzlbpms that is ok too
To do it, in a non intrusive way in relation to your own emacs,
this customization should be started with your emacs with a command like this:

without fzlbpms
git clone https://github.com/wagnermarques/emacsinitfile.git
>emacs -q -l path/to/emacsinitfile/init.el

with fzlbpms
its necessary to download fzlbpms, buth there are no link yet
you will need to define $FZL_HOME enviroment variable to any location you want.
>emacs -q -l $FZL_HOME/etc/emacs/lisp/init.el


### Some another notes:
The niciest change I've made is to use emacs package repositories, and
to be non intrusive with yours alredy installed package in you emacs,
I happened to redefine the "package-user-dir" variable to isolate
packages installed automatically by this emacs customization.

### path configurations
So please change this init.el accordingle :)
(setq **M2_HOME**     "/path/to/your/apache-maven-3.3.3/")
(setq **NEXUS_HOME**  "/path/to/your/nexus-2.11.4-01-bundle/nexus-2.11.4-01")
(setq **JAVA_HOME**   "/path/to/your/jdk1.8.0_65")
(setq **EMACSINITFILE_HOME** "/path/to/your/emacsinitfile/cloned/git/repository")

    

wagner
wagnerdocri@gmail.com
