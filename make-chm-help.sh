#!/bin/bash

wget https://github.com/ericoporto/freepascal/releases/download/3.0.4/chmcmd
wget https://github.com/ericoporto/freepascal/releases/download/3.0.4/chmcmd.md5
md5sum -c chmcmd.md5
chmod +x chmcmd
pushd build/htmlhelp/
../../chmcmd AGSHelpdoc.hhp 
chmod +x AGSHelpdoc.chm
mv AGSHelpdoc.chm ../../
popd
