websitedir = $(pkgdatadir)/website
websitecssdir = $(pkgdatadir)/website/css
websitefontsdir = $(pkgdatadir)/website/fonts
websiteimagesdir = $(pkgdatadir)/website/images
websitejsdir = $(pkgdatadir)/website/js
websitestaticdir = $(pkgdatadir)/website/static

website_DATA = $(HTML_FILES) genindex.html
websitecss_DATA = $(srcdir)/html/css/main.css $(srcdir)/vendor/normalize.css
websitefonts_DATA = \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.eot \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.svg \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.ttf \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.woff \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.woff2
websiteimages_DATA = $(IMAGE_FILES)
websitejs_DATA = $(srcdir)/html/js/darkmode.js $(srcdir)/html/js/mark.min.js search.js
websitestatic_DATA = $(srcdir)/html/static/favicon.ico

if BUILD_CHM
pkgdata_DATA = source/ags-help.chm
endif

CLEANFILES = \
	$(HTM_FILES) \
	$(METADATA_FILES) \
	$(pkgdata_DATA) \
	$(website_DATA) \
	search.js \
	source/ags-help.hhc \
	source/ags-help.hhk \
	source/ags-help.hhp

EXTRA_DIST = \
	$(IMAGE_FILES) \
	$(TOP_FILES) \
	$(srcdir)/html/js/darkmode.js \
	$(srcdir)/html/js/mark.min.js \
	$(srcdir)/html/template.html5 \
	$(srcdir)/html/template.js \
	$(srcdir)/htmlhelp/template.hhc \
	$(srcdir)/htmlhelp/template.hhp \
	$(srcdir)/htmlhelp/template.html4 \
	$(srcdir)/lua/agsman.lua \
	$(srcdir)/lua/insert_anchors.lua \
	$(srcdir)/lua/insert_toc.lua \
	$(srcdir)/lua/rewrite_links.lua \
	$(srcdir)/lua/set_title.lua \
	$(srcdir)/lua/write_feature_check.lua \
	$(srcdir)/lua/write_genindex.lua \
	$(srcdir)/lua/write_hhc.lua \
	$(srcdir)/lua/write_hhk.lua \
	$(srcdir)/lua/write_hhp.lua \
	$(srcdir)/lua/write_metablock.lua \
	$(srcdir)/lua/write_metacheck.lua \
	$(srcdir)/lua/write_metajs.lua \
	$(srcdir)/meta/approved_links.txt \
	$(websitecss_DATA) \
	$(websitefonts_DATA) \
	$(websitestatic_DATA)

SUFFIXES: .htm .html .lua .md

.md.lua:
	$(AM_V_GEN)"$(PANDOC)" --from gfm \
		--to "$(srcdir)/lua/write_metablock.lua" \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--metadata docname=$(*F) \
		--output $@ \
		$<

.md.html:
	$(AM_V_GEN)"$(PANDOC)" --from gfm \
		--to html5 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--lua-filter "$(srcdir)/lua/insert_anchors.lua" \
		--template "$(srcdir)/html/template.html5" \
		--variable footer="$(FOOTER)" \
		--table-of-contents \
		--section-divs \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--eol lf \
		--output $@ \
		$<

genindex.html: $(METADATA_FILES)
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_genindex.lua" \
		--template "$(srcdir)/html/template.html5" \
		--variable footer="$(FOOTER)" \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--metadata _metafiles="$(METADATA_FILES)" \
		--eol lf \
		--output $@

search.js: $(METADATA_FILES)
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_metajs.lua" \
		--template "$(srcdir)/html/template.js" \
		--metadata _metafiles="$(METADATA_FILES)" \
		--eol lf \
		--output $@

.md.htm:
	$(AM_V_GEN)"$(PANDOC)" --from gfm \
		--to html4 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--lua-filter "$(srcdir)/lua/insert_toc.lua" \
		--template "$(srcdir)/htmlhelp/template.html4" \
		--eol crlf \
		--output $@ \
		$<

source/index.htm: source/index.md
	$(AM_V_GEN)"$(PANDOC)" --from gfm \
		--to html4 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--template "$(srcdir)/htmlhelp/template.html4" \
		--eol crlf \
		--output $@ \
		$<

source/ags-help.hhk: $(METADATA_FILES)
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_hhk.lua" \
		--metadata _metafiles="$(METADATA_FILES)" \
		--eol crlf \
		--output $@

source/ags-help.hhc:
	$(AM_V_GEN)"$(PANDOC)" --from gfm \
		--to "$(srcdir)/lua/write_hhc.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--template "$(srcdir)/htmlhelp/template.hhc" \
		--eol crlf \
		--output $@ \
		source/index.md

source/ags-help.hhp:
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_hhp.lua" \
		--metadata incfiles="$(HHP_FILES)" \
		--variable projectname=ags-help \
		--variable index=index.htm \
		--template "$(srcdir)/htmlhelp/template.hhp" \
		--eol crlf \
		--output $@

source/ags-help.chm: $(HTM_FILES) source/ags-help.hhk source/ags-help.hhc source/ags-help.hhp
if BUILD_CHM_WITH_HHC
	$(AM_V_GEN)"$(HHC)" source/ags-help.hhp || exit 0; exit 1
endif
if BUILD_CHM_WITH_CHMCMD
	$(AM_V_GEN)cd source && "$(CHMCMD)" ags-help.hhp
endif

check: $(METADATA_FILES)
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_metacheck.lua" \
		--metadata _approved_links="$(srcdir)/meta/approved_links.txt" \
		--metadata _metafiles="$(METADATA_FILES)"
