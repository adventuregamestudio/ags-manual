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

## temporarily modify the source for testing purposes

# remove all manually defined anchor links
sed -E -i "s/^[ \*-]*\[[^]]*\]\(#[^)]+\)(<br>)?$//g" source/*.md

# remodel the Home page
sed -i "s/## Contents//" source/Home.md
sed -i "s/^\*\*/## /" source/Home.md
sed -i "s/\*\*//" source/Home.md

rm source/index.md
mv source/Home.md source/index.md

# write a new index file
cat << EOF > source/contents.rst
Contents
========

.. toctree::
   :glob:
   :maxdepth: 2

   Welcome <index>
   *
   
EOF
