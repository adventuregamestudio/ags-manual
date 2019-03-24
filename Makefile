PANDOC ?= pandoc
CURL ?= curl
NORMALIZE = https://cdn.rawgit.com/necolas/normalize.css/master/normalize.css
MILLIGRAM = https://cdnjs.cloudflare.com/ajax/libs/milligram/1.3.0/milligram.min.css
IMAGEFILES = $(addprefix images/, $(notdir $(wildcard source/images/*.*)))
BASENAMES = $(basename $(notdir $(wildcard source/*.md)))
HTMLFILES = $(addsuffix .html, $(BASENAMES))
METAFILES = $(addsuffix .yaml, $(BASENAMES))

ifneq ($(strip $(MAKECMDGOALS)),)
ifeq ($(strip $(CHECKOUTDIR)),)
ifneq ($(filter-out source,$(MAKECMDGOALS)),$(MAKECMDGOALS))
$(error target 'source' requires CHECKOUTDIR to be set))
endif
endif
ifeq ($(strip $(BASENAMES)),)
ifneq ($(filter-out html htmlhelp,$(MAKECMDGOALS)),$(MAKECMDGOALS))
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
  SHOWHELP = for /f "tokens=1" %%t in ('findstr /r "^[a-z][a-z]*:" Makefile') do if "%%t" neq "help:" echo %%t
  UPDATESOURCE = robocopy "$(CHECKOUTDIR)" $@ /E /XD .git & if %ERRORLEVEL% LEQ 7 exit /b 0
  CLEANDIRS = for /r %%d in (*.gitignore) do for /f "tokens=*" %%c in (%%d) do 2>nul rd /s /q "%%c"
else
  CP = cp
  MV = mv
  SEP = /
  RM = rm -f
  RD = rm -rf
  MKDIR = mkdir -p
  SHOWHELP = awk -F ':' '/^[a-z]+:/ { if ($$1 != "help") print $$1 FS }' Makefile
  UPDATESOURCE = mkdir -p source && cp "$(CHECKOUTDIR)"/*.md $@ && cp -r "$(CHECKOUTDIR)/images" $@
  CLEANDIRS = while read -r line; do rm -rf "$$line"; done < .gitignore
endif

.PHONY: help html htmlhelp clean
.SECONDARY: $(addprefix html/work/, $(HTMLFILES)) $(addprefix htmlhelp/work/, $(HTMLFILES)) \
	$(addprefix html/work/, $(METAFILES)) $(addprefix htmlhelp/work/, $(METAFILES))

help:
	@$(SHOWHELP)

source:
	@$(MKDIR) $@ && \
		$(UPDATESOURCE)
	@$(MV) $@$(SEP)Home.md $@$(SEP)index.md && \
		$(RM) $@${SEP}_Sidebar.md

html: $(addprefix html/work/, $(HTMLFILES)) $(addprefix html/build/, $(HTMLFILES)) $(addprefix html/build/, $(IMAGEFILES)) \
	$(addprefix html/work/, $(METAFILES)) html/build/genindex.html html/build/js/search.js html/build/css/main.css \
	html/build/css/normalize.css html/build/css/milligram.min.css html/build/static/logo.png

htmlhelp: $(addprefix htmlhelp/work/, $(HTMLFILES)) $(addprefix htmlhelp/work/, $(METAFILES)) \
	htmlhelp/build/ags-help.stp htmlhelp/build/ags-help.hhk htmlhelp/build/ags-help.hhc htmlhelp/build/ags-help.hhp \
	$(addprefix htmlhelp/build/, $(HTMLFILES)) $(addprefix htmlhelp/build/, $(IMAGEFILES)) $(if $(HHC),htmlhelp/build/ags-help.chm)

html/work htmlhelp/work html/build html/build/images html/build/js html/build/css html/build/static htmlhelp/build \
	htmlhelp/build/images:
	@$(MKDIR) $(subst /,$(SEP),$@) || echo $@ exists

html/work/%.html: source/%.md | html/work
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html5 \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--template "html/template.html5" \
		--table-of-contents \
		--section-divs \
		--css "css/normalize.css" \
		--css "css/milligram.min.css" \
		--css "css/main.css" \
		--output $@ \
		$<

htmlhelp/work/%.html: source/%.md | htmlhelp/work
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html4 \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--template "htmlhelp/template.html4" \
		--output $@ \
		$<

htmlhelp/work/%.yaml: source/%.md | htmlhelp/work
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to "lua/write_metablock.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--metadata docname=$* \
		--output $@ \
		$<

html/work/%.yaml: source/%.md | html/work
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to "lua/write_metablock.lua" \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--metadata docname=$* \
		--output $@ \
		$<

htmlhelp/build/ags-help.hhk: $(addprefix htmlhelp/work/, $(filter-out index.yaml,$(METAFILES))) | htmlhelp/build
	@echo Building $@
	@"$(PANDOC)" --from markdown \
		--to "lua/write_hhk.lua" \
		--output=$@ \
		$(addprefix htmlhelp/work/, $(filter-out index.yaml,$(METAFILES)))

htmlhelp/build/ags-help.hhc: | htmlhelp/build
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to "lua/write_hhc.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--template "htmlhelp/template.hhc" \
		--output $@ \
		source/index.md

htmlhelp/build/ags-help.hhp: | htmlhelp/build
	@echo Building $@
	@echo "" | "$(PANDOC)" \
		--to "lua/write_hhp.lua" \
		--metadata incfiles="$(HTMLFILES) $(subst /,$(strip \),$(IMAGEFILES))" \
		--variable projectname=ags-help \
		--template "htmlhelp/template.hhp" \
		--output $@

html/build/genindex.html: $(addprefix html/work/, $(filter-out index.yaml,$(METAFILES))) | html/build 
	@echo Building $@
	@"$(PANDOC)" --from markdown \
		--to "lua/write_genindex.lua" \
		--template "html/template.html5" \
		--css "css/normalize.css" \
		--css "css/milligram.min.css" \
		--css "css/main.css" \
		--output=$@ \
		$(addprefix html/work/, $(filter-out index.yaml,$(METAFILES)))

html/build/js/search.js: $(addprefix html/work/, $(filter-out index.yaml,$(METAFILES))) | html/build/js
	@echo Building $@
	@"$(PANDOC)" --from markdown \
		--to "lua/write_metajs.lua" \
		--template "html/template.js" \
		--output=$@ \
		$(addprefix html/work/, $(filter-out index.yaml,$(METAFILES)))

html/build/css/main.css: | html/build/css
	$(CP) html$(SEP)css$(SEP)main.css $(subst /,$(SEP),$@)

html/build/css/normalize.css: | html/build/css
	$(CURL) -fLo $(subst /,$(SEP),$@) $(NORMALIZE)

html/build/css/milligram.min.css: | html/build/css
	$(CURL) -fLo $(subst /,$(SEP),$@) $(MILLIGRAM)

html/build/static/logo.png: | html/build/static
	$(CP) html$(SEP)static$(SEP)logo.png $(subst /,$(SEP),$@)

htmlhelp/build/ags-help.stp: | htmlhelp/build
	@echo Building $@
	@$(CP) htmlhelp$(SEP)stp $(subst /,$(SEP),$@)

html/build/%.html: html/work/%.html | html/build
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

html/build/images/%: source/images/% | html/build/images
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

htmlhelp/build/%.html: htmlhelp/work/%.html | htmlhelp/build
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

htmlhelp/build/images/%: source/images/% | htmlhelp/build/images
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

ifdef HHC
htmlhelp/build/ags-help.chm: htmlhelp/build/ags-help.hhk htmlhelp/build/ags-help.hhc \
	htmlhelp/build/ags-help.stp htmlhelp/build/ags-help.hhp | htmlhelp/build
	@"$(HHC)" htmlhelp/build/ags-help.hhp || exit /b 0 & exit /b 1
endif

clean:
	@$(CLEANDIRS)
