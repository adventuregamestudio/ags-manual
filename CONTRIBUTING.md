# Contributing to AGS Documentation

## Page content

_Coming Soon_

## Build system

The current manual build process can produce two types of output (build targets):

 - A CHM file that can be used on Windows
 - Files that makeup a website

In both cases the wiki pages which are written in GitHub Flavored Markdown (GFM) need to be converted into HTML files. Pandoc is used for the page conversion, although the options used vary depending on the target output.

### Common tasks

#### Page metadata

Both build targets require that any missing metadata be generated; the same Pandoc filter can be used to generate a page title. The metadata value for **title** is also set directly, based on the filename of what is being converted:

    --metadata title=$* \
	--lua-filter "lua/set_title.lua" \

...this means that if whatever the Lua filter wants to use a page title is not present, the stem name coming from GNU Make is used instead.

#### Link targets

There is also the issue of fixing internal document links, as converting from GFM to HTML in Pandoc does not implicitly rewrite the link target to match the output format. i.e. the GFM link `[Other Features](OtherFeatures)` works within GitHub pages but would need to be converted to the equivalent of `[Other Features](OtherFeatures.html)` in the HTML version. Since both build targets require the same conversion, they also share the same Pandoc filter:

    --lua-filter "lua/rewrite_links.lua" \

#### Output templates

The page conversion itself also requires a template that matches the output format; the default templates have been exported from Pandoc and modified. The coresponding template needs to be specified for each output format.

For the CHM file the output format is html4:

    --to html4 \
    --template "htmlhelp/template.html4" \

For the website target the output format is html5:

    --to html5 \
    --template "html/template.html5" \

#### Write metadata file

For each converted page a matching Lua file is written using a custom Pandoc writer.

    --to "lua/write_metablock.lua" \
    --metadata docname=$* \

These files are designed to be evaluated using the Lua `dofile` function to return a Lua table which contains information about the page. The information stored is:

* The page title
* Headings found on the page and their anchor links
* Links found on the page
* A list of keywords and number of times each occurs

An important feature of the custom writer is to identify which parts of the page relate to script documentation so that later actions may treat them differently.

### CHM file only

#### Write an hhk file

The hhk file is used by the the CHM compiler to define the index. A custom Lua writer is used to write an HHK file from all Lua metadata files (excluding anything relating to index file).

    --from markdown \
    --to "lua/write_hhk.lua" \

The result should be a file of site map objects, like this one:

    <LI> <OBJECT type="text/sitemap">
    <param name="Keyword" value="AudioClip.FileType">
    <param name="Local" value="AudioClip.html#audioclipfiletype">
    </OBJECT>

#### Write an hhc file

The hhc file is used by the CHM compiler to define the contents. Currently we are only considering the index page (index.md) for the source of the contents, so this is converted using a custom Lua writer which writes the hhc file based on the headings and bulleted lists which are present. The output needs to produce hierarchical lists where the contents page should expand and collapse.

    --from gfm \
    --to "lua/write_hhc.lua" \
    --lua-filter "lua/rewrite_links.lua" \
    --template "htmlhelp/template.hhc" \

Note that link target are being rewritten too, because the input file will be the original GFM source for the index page.

#### Write an hhp file

The hhp file is the main project file that is passed to the CHM compiler. It is written using a custom Pandoc writer which just needs to know the list of source files to include and the name prefix that is used for the hhk, hhc, and stp project files.

    --to "lua/write_hhp.lua" \
    --metadata incfiles="$(HTMLFILES) $(subst /,$(strip \),$(IMAGEFILES))" \
    --variable projectname=ags-help \
    --template "htmlhelp/template.hhp" \

Note that the paths passed in need to have the slashes changes from / to \ in so that if this file is written on a non-Windows platform the content will still be valid.

#### Write an stp file

The stp file is just a list of words that the CHM compiler should ignore when creating its own search index. Rather than dynamically generate this file, it is just copied into position.

### Website files only

#### A-Z index page

Since the website build wouldn't have a built-in index, an index page is generated from all Lua metadata files (excluding anything relating to index file) using a custom Pandoc writer.

    --from markdown \
    --to "lua/write_genindex.lua" \
    --template "html/template.html5" \

Note that the same HTML5 template that was used for the actual page conversion is used here, so the page will keep the same styling as the other pages. If passing in any external styling (i.e. using `--css`) on other pages, it will need to be included here too.

#### Javascript search and JSON data

For the current search system, the number of occurrences of each word are recorded in all of the Lua metadata files, so these are written as a JSON object into a template file which also contains the Javascript search functions.

    --from markdown \
    --to "lua/write_metajs.lua" \
    --template "html/template.js" \

Again, the Lua file for the index page is not processed so that the contents page remains acting like a site map and doesn't count towards search results. The resulting javascript file is included at the bottom of the HTML5 template, so every page of the website will have loaded the search functions as well as the JSON object that they require.
