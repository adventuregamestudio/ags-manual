#!/bin/sh

dir="source"
opts="--depth=1 --branch=master"
url="https://github.com/adventuregamestudio/ags-manual.wiki.git"

rm -rf "$dir"
git clone $opts $url $dir

## temporarily modify the source for testing purposes

# not using the symlink any more
rm source/index.md

# remove all manually defined anchor links
sed -E -i "s/^[ \*-]*\[[^]]*\]\(#[^)]+\)(<br>)?$//g" source/*.md

# remodel the Home page
sed -i "s/## Contents//" source/Home.md
sed -i "s/^\*\*/## /" source/Home.md
sed -i "s/\*\*//" source/Home.md
sed -E -zi "s/\n\n+/\n\n/g" source/Home.md

## end of temp changes

# write a new index file
awk -v maxdepth=1 -v outfile="source/index.rst" '
{
	if ($1 == "#") {
		sub("^# *", "")

		underline = ""
		for (i = 0; i < length($0); i ++)
			underline = "=" underline

		printf("%s\n%s\n", $0, underline) > outfile
	}

	else if ($1 == "##") {
		sub("^## *", "")

		underline = ""
		for (i = 0; i < length($0); i ++)
			underline = "-" underline

		printf("\n%s\n%s\n\n.. toctree::\n   :maxdepth: %d\n\n", $0, underline, maxdepth) >> outfile
	}

	else if ($1 == "*" || $1 == "-" || $1 == "+") {
		match($0, "\[[^\]]*\]")
		label = substr($0, RSTART + 1, RLENGTH - 2)

		match($0, "\([^\)]+\)")
		link = substr($0, RSTART + 1, RLENGTH - 2)

		printf("   %s <%s>\n", label, link) >> outfile
	}
}

END {
	printf("\n.. toctree::\n   :glob:\n   :hidden:\n\n   *\n") >> outfile
}
' < source/Home.md
