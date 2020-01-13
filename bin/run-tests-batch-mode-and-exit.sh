#!/bin/bash
BASEDIR=$(dirname "$0")
TESTSSITE_DIR=$BASEDIR/../main/src/testssite


emacs -batch \
      -l ert \
      -l $TESTSSITE_DIR/test-all.el \
      -f ert-run-tests-batch-and-exit
#      -f ert-summarize-tests-batch-and-exit \

