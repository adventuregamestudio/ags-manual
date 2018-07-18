#!/bin/bash

rm -rf source

git clone --depth=1 --branch=master https://github.com/ericoporto/agshelp.wiki.git source

cp conf.py source/conf.py
mv source/Home.md source/index.md
