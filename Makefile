PANDOC ?= pandoc
IMAGEFILES = $(addprefix images/, $(notdir $(wildcard source/images/*.*)))
BASENAMES = $(basename $(notdir $(wildcard source/*.md)))
HTMLFILES = $(addsuffix .html, $(BASENAMES))
MAPFILES = $(addsuffix .map, $(BASENAMES))
CONTENTSFILES = $(addsuffix .contents, $(BASENAMES))

ifeq ($(strip $(CHECKOUTDIR)),)
$(and $(filter source,$(MAKECMDGOALS)),$(error target 'source' requires CHECKOUTDIR to be set))
endif

ifeq ($(strip $(BASENAMES)),)
$(and $(filter-out source help clean,$(MAKECMDGOALS)),$(error no source files were found))
endif

ifdef ComSpec
  CP = copy
  MV = move
  SEP = $(strip \)
  RM = del /f
  RD = rd /s /q
  DEVNULL = NUL
  SHOWHELP = for /f "tokens=1" %%t in ('findstr /r "^[a-z][a-z]*:" Makefile') do if "%%t" neq "help:" echo %%t
  UPDATESOURCE = robocopy "$(CHECKOUTDIR)" $@ /E /XD .git & if %ERRORLEVEL% LEQ 7 exit /b 0
  CLEANDIRS = for /r %%d in (*.gitignore) do for /f "tokens=*" %%c in (%%d) do 2>nul rd /s /q "%%c"
else
  CP = cp
  MV = mv
  SEP = /
  RM = rm -f
  RD = rm -rf
  DEVNULL = /dev/null
  SHOWHELP = awk -F ':' '/^[a-z]+:/ { if ($$1 != "help") print $$1 FS }' Makefile
  UPDATESOURCE = mkdir -p source && cp "$(CHECKOUTDIR)"/*.md $@ && cp -r "$(CHECKOUTDIR)/images" $@
  CLEANDIRS = while read -r line; do rm -rf "$$line"; done < .gitignore
endif

.PHONY: help html htmlhelp clean
.SECONDARY: $(addprefix html/work/, $(HTMLFILES)) $(addprefix htmlhelp/work/, $(HTMLFILES))

help:
	@$(SHOWHELP)

source:
	@mkdir $@ && \
		$(UPDATESOURCE)
	@$(MV) $@$(SEP)Home.md $@$(SEP)index.md && \
		$(RM) $@${SEP}_Sidebar.md

html: html/work $(addprefix html/work/, $(HTMLFILES)) html/build $(addprefix html/build/, $(HTMLFILES)) html/build/images $(addprefix html/build/, $(IMAGEFILES))

htmlhelp: htmlhelp/work $(addprefix htmlhelp/work/, $(HTMLFILES)) \
	htmlhelp/build htmlhelp/build/ags-help.stp htmlhelp/build/ags-help.hhk \
	htmlhelp/build/ags-help.hhc htmlhelp/build/ags-help.hhp $(addprefix htmlhelp/build/, $(HTMLFILES)) \
	htmlhelp/build/images $(addprefix htmlhelp/build/, $(IMAGEFILES))

html/work htmlhelp/work html/build html/build/images htmlhelp/build htmlhelp/build/images:
	@mkdir $(subst /,$(SEP),$@)

html/work/%.html: source/%.md
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html5 \
		--standalone \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--output $@ \
		$<

htmlhelp/work/%.html: source/%.md
	@echo Building $@
	@"$(PANDOC)" --from gfm \
		--to html4 \
		--metadata title=$* \
		--lua-filter "lua/set_title.lua" \
		--lua-filter "lua/rewrite_links.lua" \
		--lua-filter "lua/get_indices.lua" \
		--lua-filter "lua/get_contents.lua" \
		--template "htmlhelp/template.html4" \
		--output $@ \
		$<

htmlhelp/build/ags-help.hhk: $(addprefix htmlhelp/work/, $(HTMLFILES))
	@echo Building $@
	@echo "" | "$(PANDOC)" \
		--to native \
		--lua-filter "lua/write_hhk.lua" \
		--metadata mapfiles="$(addprefix htmlhelp/work/, $(filter-out index.map,$(MAPFILES)))" \
		--metadata output=$@ \
		> $(DEVNULL)

htmlhelp/build/ags-help.hhc: $(addprefix htmlhelp/work/, $(HTMLFILES))
	@echo Building $@
	@echo "" | "$(PANDOC)" \
		--to native \
		--lua-filter "lua/write_hhc.lua" \
		--metadata contents="$(addprefix htmlhelp/work/, $(filter index.contents,$(CONTENTSFILES)))" \
		--metadata output=$@ \
		> $(DEVNULL)

htmlhelp/build/ags-help.hhp:
	@echo Building $@
	@echo "" | "$(PANDOC)" \
		--to native \
		--lua-filter "lua/write_hhp.lua" \
		--metadata incfiles="$(HTMLFILES) $(subst /,$(SEP),$(IMAGEFILES))" \
		--metadata projectname=ags-help \
		--metadata output=$@ \
		> $(DEVNULL)

htmlhelp/build/ags-help.stp:
	@echo Building $@
	@$(CP) htmlhelp$(SEP)stp $(subst /,$(SEP),$@)

html/build/%.html: html/work/%.html
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

html/build/images/%: source/images/%
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

htmlhelp/build/%.html: htmlhelp/work/%.html
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

htmlhelp/build/images/%: source/images/%
	$(CP) $(subst /,$(SEP),$<) $(subst /,$(SEP),$@)

clean:
	@$(CLEANDIRS)
