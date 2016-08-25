#!/bin/bash

for dir in `ls -d */` ; do
  pushd $dir
  git pull
  popd
done
