PANDOC ?= pandoc
CURL ?= curl
NORMALIZE = https://necolas.github.io/normalize.css/latest/normalize.css
IMAGEFILES = $(addprefix images/, $(notdir $(wildcard source/images/*.*)))
FONTSOURCEDIR = $(wildcard vendor/open-sans-v*-latin)
FONTFILES = $(notdir $(wildcard $(FONTSOURCEDIR)/open-sans-v*-latin*.*))
BASENAMES = $(basename $(notdir $(wildcard source/*.md)))
HTMLFILES = $(addsuffix .html, $(BASENAMES))
METAFILES = $(addsuffix .lua, $(BASENAMES))
MAKEFILE = $(lastword $(MAKEFILE_LIST))

ifneq ($(strip $(MAKECMDGOALS)),)
ifeq ($(strip $(CHECKOUTDIR)),)
ifneq ($(filter-out source,$(MAKECMDGOALS)),$(MAKECMDGOALS))
$(error target 'source' requires CHECKOUTDIR to be set)
endif
endif
ifeq ($(strip $(BASENAMES)),)
ifneq ($(filter-out chm html htmlhelp metacheck,$(MAKECMDGOALS)),$(MAKECMDGOALS))
$(error no source files were found)
endif
endif
endif

ifdef ComSpec
  CP = copy
  MV = move
  SEP = $(strip \)
  RM = del /f
  RD = rd /s /q
  MKDIR = md
  SHOWHELP = for /f "tokens=1" %%t in ('findstr /r "^[a-z][a-z]*:" $(MAKEFILE)') do if "%%t" neq "help:" echo %%t
  UPDATESOURCE ?= robocopy "$(CHECKOUTDIR)" $@ /MIR /XD .git & if %ERRORLEVEL% LEQ 7 exit /b 0
  CLEANDIRS = for /f "tokens=*" %%l in (.gitignore) do if exist "%%l" rd /s /q "%%l"
  DATETIME ?= $(shell echo %DATE% %TIME:~,-3%)
  FLIPCODE = || exit /b 0 & exit /b 1
else
  CP = cp
  MV = mv
  SEP = /
  RM = rm -f
  RD = rm -rf
  MKDIR = mkdir -p
  SHOWHELP = awk -F ':' '/^[a-z]+:/ { if ($$1 != "help") print $$1 FS }' $(MAKEFILE)
  UPDATESOURCE ?= rm -rf $@ && mkdir $@ && cp "$(CHECKOUTDIR)"/*.md $@ && cp -r "$(CHECKOUTDIR)/images" $@
  CLEANDIRS = while read -r line; do rm -rf "$$line"; done < .gitignore
  DATETIME ?= $(shell date "+%x %X")
  FLIPCODE = || exit 0; exit 1
endif

.PHONY: chm help html htmlhelp metacheck clean source
.SECONDARY: $(addprefix meta/build/, $(METAFILES))

help:
	@$(SHOWHELP)

source:
	@$(UPDATESOURCE)
	@$(MV) $@$(SEP)Home.md $@$(SEP)index.md && \
		$(RM) $@${SEP}_Sidebar.md

metacheck: $(addprefix meta/build/, $(METAFILES))
	@echo Checking $(words $+) files for $@
	@echo | "$(PANDOC)" \
		--to "lua/write_metacheck.lua" \
		--metadata=_approved_links:meta/approved_links.txt \
		--metadata=_metafiles="$+"

html: $(addprefix html/build/, $(HTMLFILES)) $(addprefix html/build/, $(IMAGEFILES)) $(addprefix meta/build/, $(METAFILES)) \
	$(addprefix html/build/fonts/, $(FONTFILES)) html/build/genindex.html html/build/js/search.js html/build/css/main.css \
	html/build/css/normalize.css html/build/static/favicon.ico

htmlhelp: $(addprefix htmlhelp/build/, $(HTMLFILES)) $(addprefix htmlhelp/build/, $(IMAGEFILES)) $(addprefix meta/build/, $(METAFILES)) \
	htmlhelp/build/ags-help.stp htmlhelp/build/ags-help.hhk htmlhelp/build/ags-help.hhc htmlhelp/build/ags-help.hhp

chm: htmlhelp/build/ags-help.chm

html/build html/build/images html/build/js html/build/css html/build/fonts html/build/static htmlhelp/build htmlhelp/build/images meta/build:
	@$(MKDIR) "$@" || echo $@ exists

html/build/%.html: source/%.md | html/build
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html5 \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--lua-filter "lua/insert_anchors.lua" \
		--template "html/template.html5" \
		--variable=datetime:"$(DATETIME)" \
		--table-of-contents \
		--section-divs \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--eol=lf \
		--output $@ \
		$<

htmlhelp/build/%.html: source/%.md | htmlhelp/build
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html4 \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		$(if $(filter-out index, $*),--lua-filter "lua/insert_toc.lua") \
		--template "htmlhelp/template.html4" \
		--eol=crlf \
		--output $@ \
		$<

meta/build/%.lua: source/%.md | meta/build
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to "lua/write_metablock.lua" \
		--lua-filter "lua/set_title.lua" \
		--metadata docname=$* \
		--output $@ \
		$<

htmlhelp/build/ags-help.hhk: $(addprefix meta/build/, $(filter-out index.lua,$(METAFILES))) | htmlhelp/build
	@echo Building $@
	@echo | "$(PANDOC)" \
		--to "lua/write_hhk.lua" \
		--metadata=_metafiles="$(addprefix meta/build/, $(filter-out index.lua,$(METAFILES)))" \
		--eol=crlf \
		--output $@

htmlhelp/build/ags-help.hhc: | htmlhelp/build
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to "lua/write_hhc.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--template "htmlhelp/template.hhc" \
		--eol=crlf \
		--output $@ \
		source/index.md

htmlhelp/build/ags-help.hhp: | htmlhelp/build
	@echo Building $@
	@echo | "$(PANDOC)" \
		--to "lua/write_hhp.lua" \
		--metadata incfiles="$(sort $(HTMLFILES) $(subst /,$(strip \),$(IMAGEFILES)))" \
		--variable projectname=ags-help \
		--template "htmlhelp/template.hhp" \
		--eol=crlf \
		--output $@

html/build/genindex.html: $(addprefix meta/build/, $(filter-out index.lua,$(METAFILES))) | html/build 
	@echo Building $@
	@echo | "$(PANDOC)" \
		--to "lua/write_genindex.lua" \
		--template "html/template.html5" \
		--variable=datetime:"$(DATETIME)" \
		--css "css/normalize.css" \
		--css "css/main.css" \
		--metadata=_metafiles="$(addprefix meta/build/, $(filter-out index.lua,$(METAFILES)))" \
		--eol=lf \
		--output $@

html/build/js/search.js: $(addprefix meta/build/, $(filter-out index.lua,$(METAFILES))) | html/build/js
	@echo Building $@
	@echo | "$(PANDOC)" \
		--to "lua/write_metajs.lua" \
		--template "html/template.js" \
		--metadata=_metafiles="$(addprefix meta/build/, $(filter-out index.lua,$(METAFILES)))" \
		--eol=lf \
		--output=$@ \

# copy source to destination
define CP_template
$2: $1 | $(patsubst %/,%,$(dir $2))
	$(CP) $$(subst /,$(SEP),$$<) $$(subst /,$(SEP),$$@)
endef

$(eval $(call CP_template,html/css/%.css,html/build/css/%.css))
$(eval $(call CP_template,$(FONTSOURCEDIR)/%,html/build/fonts/%))
$(eval $(call CP_template,html/static/%,html/build/static/%))
$(eval $(call CP_template,source/images/%,html/build/images/%))
$(eval $(call CP_template,source/images/%,htmlhelp/build/images/%))
$(eval $(call CP_template,htmlhelp/stp,htmlhelp/build/ags-help.stp))

# download from URL to destination
define CURL_template
$2: | $(patsubst %/,%,$(dir $2))
	$(CURL) -fLso "$$@" $1
endef

$(eval $(call CURL_template,$(NORMALIZE),html/build/css/normalize.css))

htmlhelp/build/ags-help.chm: | htmlhelp
	@"$(HHC)" htmlhelp/build/ags-help.hhp $(FLIPCODE)

clean:
	@$(CLEANDIRS)
