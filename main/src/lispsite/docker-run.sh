#!/bin/bash

CONTAINER_NAME=gnome
CONTAINER_IP=192.168.33.166

SHARED_FOLDER="$(pwd)/$CONTAINER_NAME"

IMG_NAME=wagnermarques/gnome:0.0.1



docker run \
       --name "$CONTAINER_NAME" -h "$CONTAINER_NAME" \
       --net fzl_network_bridge --ip "$CONTAINER_IP" \
       -v "$SHARED_FOLDER":/shared-dir \
       -d "$IMG_NAME" 
       
usuario_do_host
