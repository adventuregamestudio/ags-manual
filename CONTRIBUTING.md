# Contributing to AGS Documentation

## Introduction

Thank you for considering contributing to AGS Manual wiki. The AGS Manual is made better by people like you.

Since the manual is made by multiple contributions, reading the guidelines ensures we can provide a cohesive document for the game developers using AGS. 
We also assume you are also a game developer using AGS which means in the future you will also be thanking yourself later.

*If instead, you have questions about building the manual and website help template, create an issue on GitHub so we can discuss that!*

## Getting started

- Create an account on GitHub
- If you are unsure about your contribution, Create an issue
- If you are REALLY confident about your contribution, and you have created at least one issue, write in the wiki

## About opening issues

- Be respectful when writing issues
- If you want to discuss a topic already on the manual, link it in the wiki.
- If you want to discuss a new entry, not in the manual, suggest it's name and where it would reside
- Issues are where we can sketch ideas and discuss pages, so don't be afraid of writing too much, just be aware that it will take more time to think about the more that is written.

## About writing in the wiki

- Ensure all pages have at least one other page that leads to it. Do not cause or add orphaned pages.

### How to add screenshots to the documentation

Screenshots should be avoided, but they make sense in tutorials or when describing how AGS Editor user interface works.

- Do not overuse screenshots.
- Screenshots should be saved as PNG or JPG, with a width of at least 400 px.
- Try to keep the file size less than 220KB.
- Do not rely on images to provide information or context.
- Do not include any personally identifying information.
- Capture just the part of the screen or window that users must focus on.
- Do not include window headers in the final screenshots unless completely necessary.
- Limit empty GUI space, manipulate your screenshots to condense important information.
- Do not include any watermark or any reference to other tools in a screenshot.
- Prefer the interface and portrayed game objects to be in English when possible.

Finally, the actual inclusion of screenshots in the manual can only be done by people with commit access to the repository wiki, likely the [docs-contributors](https://github.com/orgs/adventuregamestudio/teams/docs-contributors) team.

Clone the wiki locally 

    git clone https://github.com/adventuregamestudio/ags-manual.wiki.git

And add necessary screenshots inside `images/`, then add, commit and push the images.

### About code snippets in contributions

Always ensure your code snippets in the manual follow below

- Is as small as possible to achieve what's desired;
- Either can run on empty game template or can run on Sierra template;
- If it requires additional resources (like a gMyGUI, cEgo2, ...) it can be grasped from the context it's presented.

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

## Creating releases

Below are the steps necessary to creating a release using the automation currently in place (GitHub Actions).

### Approving links

If a link to a URL that is not a manual page is added in the GitHub wiki, this means any website links but also special URLs like `mailto:`, it needs to be approved or the build process will fail.

Approved links are alphabetically ordered in [`meta/approved_links.txt`](https://github.com/adventuregamestudio/ags-manual/blob/master/meta/approved_links.txt). Update it as needed.

### Generating a release

Just create a new tag in GitHub release interface with a name that begins with `v` (e.g. `v1.2.3`) and the GitHub Actions should trigger and generate the appropriate packages and push as assets in the Release page.

The CI from ags will then pick up the most recent version of the `ags-help.chm` uploaded to a release.
