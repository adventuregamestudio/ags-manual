#!/bin/sh

dir="source"
opts="--depth=1 --branch=master"
url="https://github.com/adventuregamestudio/ags-manual.wiki.git"

release=`uname -r`
os=`uname -o`
windows=0

if [ ! "${release%Microsoft}" = "${release}" ]; then
	# Windows Subsystem for Linux
	windows=1
elif [ "$os" = "Msys" ]; then
	# Msys (subsystem from Git installer)
	windows=1
fi

rm -rf "$dir"
[ "$windows" -eq "1" ] && opts="--config core.symlinks=true $opts"
git clone $opts $url $dir
