websitedir = $(pkgdatadir)/website
websitecssdir = $(pkgdatadir)/website/css
websitefontsdir = $(pkgdatadir)/website/fonts
websiteimagesdir = $(pkgdatadir)/website/images
websitejsdir = $(pkgdatadir)/website/js
websitestaticdir = $(pkgdatadir)/website/static

website_DATA = $(HTML_FILES) $(srcdir)/html/jslicensing.html genindex.html
websitecss_DATA = $(srcdir)/html/css/main.css $(srcdir)/vendor/normalize.css
websitefonts_DATA = \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.eot \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.svg \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.ttf \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.woff \
	$(srcdir)/vendor/open-sans-v17-latin/open-sans-v17-latin-regular.woff2
websiteimages_DATA = $(IMAGE_FILES)
websitejs_DATA = \
	$(srcdir)/html/js/darkmode.js \
	$(srcdir)/vendor/mark.js \
	$(srcdir)/vendor/mark.min.js \
	search.js \
	navigation.js
websitestatic_DATA = \
	$(srcdir)/html/static/favicon.ico \
	$(srcdir)/html/static/logo.svg

if BUILD_CHM
pkgdata_DATA = source/ags-help.chm
endif

CLEANFILES = \
	$(HTML_FILES) \
	$(HTM_FILES) \
	$(METADATA_FILES) \
	$(pkgdata_DATA) \
	genindex.html \
	metadata.lua \
	search.js \
	navigation.js \
	source/ags-help.hhc \
	source/ags-help.hhk \
	source/ags-help.hhp

EXTRA_DIST = \
	$(IMAGE_FILES) \
	$(TOP_FILES) \
	$(srcdir)/html/js/darkmode.js \
	$(srcdir)/html/jslicensing.html \
	$(srcdir)/html/template.html5 \
	$(srcdir)/html/template.js \
	$(srcdir)/html/template_navigation.js \
	$(srcdir)/htmlhelp/template.hhc \
	$(srcdir)/htmlhelp/template.hhp \
	$(srcdir)/htmlhelp/template.html4 \
	$(srcdir)/lua/agsman.lua \
	$(srcdir)/lua/insert_anchors.lua \
	$(srcdir)/lua/insert_toc.lua \
	$(srcdir)/lua/metacheck.lua \
	$(srcdir)/lua/rewrite_links.lua \
	$(srcdir)/lua/set_title.lua \
	$(srcdir)/lua/write_feature_check.lua \
	$(srcdir)/lua/write_genindex.lua \
	$(srcdir)/lua/write_hhc.lua \
	$(srcdir)/lua/write_hhk.lua \
	$(srcdir)/lua/write_hhp.lua \
	$(srcdir)/lua/write_metablock.lua \
	$(srcdir)/lua/write_metajs.lua \
	$(srcdir)/lua/write_navigationjs.lua \
	$(srcdir)/meta/approved_links.txt \
	$(srcdir)/syntax/ags.xml \
	$(srcdir)/syntax/agsdialog.xml \
	$(srcdir)/vendor/mark.js \
	$(srcdir)/vendor/mark.min.js \
	$(websitecss_DATA) \
	$(websitefonts_DATA) \
	$(websitestatic_DATA)

SUFFIXES: .htm .html .lua .md

.md.lua:
	$(AM_V_GEN)"$(PANDOC)" --from gfm-tex_math_dollars \
		--to "$(srcdir)/lua/write_metablock.lua" \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--metadata docname=$(*F) \
		--eol lf \
		--output $@ \
		$<

metadata.lua: $(METADATA_FILES)
	$(AM_V_GEN)(printf 'return { pages = {\n'; \
		cat $(METADATA_FILES); \
		printf '}}\n') > $@.tmp && mv $@.tmp $@

.md.html:
	$(AM_V_GEN)"$(PANDOC)" --from gfm-tex_math_dollars \
		--to html5 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--lua-filter "$(srcdir)/lua/insert_anchors.lua" \
		--template "$(srcdir)/html/template.html5" \
		--variable footer="$(FOOTER)" \
		--variable editlink="https://github.com/adventuregamestudio/ags-manual-source/blob/$(BRANCH_NAME)/${*F}.md" \
		--table-of-contents \
		--section-divs \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--syntax-definition="$(srcdir)/syntax/ags.xml" \
		--syntax-definition="$(srcdir)/syntax/agsdialog.xml" \
		--eol lf \
		--wrap=none \
		--output $@ \
		$<

genindex.html: metadata.lua
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_genindex.lua" \
		--template "$(srcdir)/html/template.html5" \
		--variable footer="$(FOOTER)" \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--eol lf \
		--wrap=none \
		--output $@

search.js: metadata.lua
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_metajs.lua" \
		--template "$(srcdir)/html/template.js" \
		--eol lf \
		--output $@

navigation.js: source/_Sidebar.md
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_navigationjs.lua" \
		--template "$(srcdir)/html/template_navigation.js" \
		--eol lf \
		--output $@ \
		$<

.md.htm:
	$(AM_V_GEN)"$(PANDOC)" --from gfm-tex_math_dollars \
		--to html4 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--lua-filter "$(srcdir)/lua/insert_toc.lua" \
		--template "$(srcdir)/htmlhelp/template.html4" \
		--eol crlf \
		--wrap=none \
		--output $@ \
		$<

source/index.htm: source/index.md
	$(AM_V_GEN)"$(PANDOC)" --from gfm-tex_math_dollars \
		--to html4 \
		--metadata title=$(*F) \
		--lua-filter "$(srcdir)/lua/set_title.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--template "$(srcdir)/htmlhelp/template.html4" \
		--eol crlf \
		--wrap=none \
		--output $@ \
		$<

source/ags-help.hhk: metadata.lua
	$(AM_V_GEN)echo | "$(PANDOC)" \
		--to "$(srcdir)/lua/write_hhk.lua" \
		--eol crlf \
		--output $@

source/ags-help.hhc: source/_Sidebar.md
	$(AM_V_GEN)"$(PANDOC)" --from gfm-tex_math_dollars \
		--to "$(srcdir)/lua/write_hhc.lua" \
		--lua-filter "$(srcdir)/lua/rewrite_links.lua" \
		--template "$(srcdir)/htmlhelp/template.hhc" \
		--eol crlf \
		--wrap=none \
		--output $@ \
		$<
		-$(AM_V_GEN) sed -z -i -E "s/(<\/OBJECT>[^<]*?<UL>)/<param name=\"ImageNumber\" value=\"1\">\n\1/g" source/ags-help.hhc

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

check: metadata.lua
	$(AM_V_at)"$(PANDOC)" lua \
		"$(srcdir)/lua/metacheck.lua" \
		"$(srcdir)/meta/approved_links.txt"
