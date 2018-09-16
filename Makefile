SOURCEDIR ?= source
BUILDDIR ?= build
SPHINXPROJ ?= AGSHelp
SPHINXOPTS ?= -c .

GITURL ?= https://github.com/adventuregamestudio/ags-manual.wiki.git
GITOPTS ?= --depth=1 --branch=master

.PHONY: help clone html htmlhelp chm clean

help:
	@awk -F '[: ]' \
	'/^[^ ][a-z ]+:/ { for (i = 1; i < NF; i ++ ) { if ($$i != "help") print $$i } }' Makefile

clone:
	@rm -rf "$(SOURCEDIR)"
	@git clone $(GITOPTS) $(GITURL) $(SOURCEDIR)
	touch "$(SOURCEDIR)/index.rst"

html htmlhelp:
	@python -m sphinx -b $@ "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS)

chm:
	@sed -E -i.bak -n "/^Binary (TOC|Index)=No$$/!p" "$(BUILDDIR)/htmlhelp/AGSHelpdoc.hhp" && \
	rm "$(BUILDDIR)/htmlhelp/AGSHelpdoc.hhp.bak"

	@chmcmd=`which chmcmd` ;\
	if [ $$? != 0 ]; then \
			if [ "`uname`" = "Linux" ]; then \
				rm -f chmcmd && wget –quiet https://github.com/ericoporto/freepascal/releases/download/3.0.4/chmcmd ;\
				echo "af4eea94c843adb20f8ae10884badbc5 chmcmd" > chmcmd.md5 ;\
				md5sum -c chmcmd.md5 || exit 1 ;\
				chmod +x chmcmd ;\
				chmcmd=`pwd`"/chmcmd" ;\
			else \
				echo "chmcmd is not present" ;\
				exit 1;\
			fi ;\
	fi ;\
	echo "Using '$$chmcmd' \
	$$( \
		cd "$(BUILDDIR)/htmlhelp" && \
		rm -f "AGSHelpdoc.chm" && \
		"$$chmcmd" "AGSHelpdoc.hhp" && \
		chmod a+r-w-x "AGSHelpdoc.chm" && \
		mv -fv "AGSHelpdoc.chm" ../../ags-help.chm \
	)"

clean:
	@while read -r line; do \
		rm -rf "$$line"; \
	done < .gitignore
