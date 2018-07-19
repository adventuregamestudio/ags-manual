#!/bin/bash

dir="source"
opts="--depth=1 --branch=master"
url="https://github.com/ericoporto/agshelp.wiki.git"

rm -rf source
uname -r | grep -q "Microsoft$" && opts="--config core.symlinks=true $opts"
git clone $opts $url $dir
