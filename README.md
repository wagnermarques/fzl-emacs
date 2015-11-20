emacsinitfile
=============


yet another emacs init file 
---------------------------
I've been using this configuration of emacs working with my fzlbpms
project enviroment (fzlbpms is just a project with a lot of text to edit)

If you want to use this init.el without fzlbpms that is ok too
To do it, in a non intrusive way, in related to your own
customization, just start your emacs with a command like this:

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



wagner
wagnerdocri@gmail.com
