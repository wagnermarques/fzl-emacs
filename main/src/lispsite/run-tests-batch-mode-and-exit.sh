#!/bin/bash

emacs -batch -l ert -l test-all.el -f ert-run-tests-batch-and-exit
