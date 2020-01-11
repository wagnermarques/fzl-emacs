#!/bin/bash

PARAMS=$1
docker run --rm --name nodejsRunning wagnermarques/fzl_nodejs:0.0.1 node $PARAMS
