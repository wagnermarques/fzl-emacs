#!/bin/bash

PARAMS=$1
docker run --name java8TempRunning --rm wagnermarques/fzl_java-oracle8-f27:0.0.1 java $PARAMS
