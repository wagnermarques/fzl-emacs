#!/bin/bash

bkpIFS="$IFS"
path_dirs=$(echo $PATH | tr ":" "\n")

for d in $path_dirs
do
    echo $d;
    if [ -d "$d" ];
    then
        chmod +x $d/*.sh
    else        
        echo "$d was not dir"
    fi
done
    
