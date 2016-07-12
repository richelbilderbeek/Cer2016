#!/bin/bash
# From http://askubuntu.com/a/439968 :
sudo apt-get install cabal-install
cabal update
cabal update
cabal install alex happy
cabal install pandoc pandoc-citeproc
pandoc --version
