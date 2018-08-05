#!/bin/sh

dir="source"
opts="--depth=1 --branch=master"
url="https://github.com/adventuregamestudio/ags-manual.wiki.git"

echo "--> Getting wiki source"
rm -rf "$dir"
git clone $opts $url $dir

# remove all manually defined anchor links
sed -E -i "s/^[ \*-]*\[[^]]*\]\(#[^)]+\)(<br>)?$//g" source/*.md

# write a new index file
echo "--> Generating index.rst"
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
		match($0, "\\[[^\]]*\\]")
		label = substr($0, RSTART + 1, RLENGTH - 2)

		match($0, "\\([^\)]+\\)")
		link = substr($0, RSTART + 1, RLENGTH - 2)

		printf("   %s <%s>\n", label, link) >> outfile
	}
}

END {
	printf("\n.. toctree::\n   :glob:\n   :hidden:\n\n   *\n") >> outfile
}
' < source/Home.md && rm -f source/Home.md

# insert index directives
echo "--> Inserting index directives for H2 and H3"
sed -E -i '
	/^### / {
		i\
.. index::
		H;x
		s/(.*)\n### (.*)/   pair: \1; \2\n/
		p
		s/   pair: (.*);.*/\1/
		x
	}
	/^## / {
		s/^## *//
		h
		i\
.. index::
		s/^/   single: /
		p
		s/   single: (.*)/\n## \1/
	}
' source/*.md
