# Contributing to AGS Documentation

## Introduction

Thank you for considering contributing to AGS Manual. The AGS Manual is made better by people like you.

Since the manual is made by multiple contributions, reading the guidelines ensures we can provide a cohesive document for the game developers using AGS. 
We also assume you are also a game developer using AGS which means in the future you will also be thanking yourself later.

*If instead, you have questions about building the manual and website help template, create an issue on GitHub so we can discuss that!*

## Getting started

- Create an account on GitHub
- If you are unsure about your contribution, Create an issue
- If you are REALLY confident about your contribution, and you have created at least one issue, send a pull request through the [ags-manual-source](https://github.com/adventuregamestudio/ags-manual-source) repository

## Opening issues

- Be respectful when writing issues
- If you want to discuss a topic already on the manual, link it in the manual.
- If you want to discuss a new entry, not in the manual, suggest it's name and where it would reside
- Issues are where we can sketch ideas and discuss pages, so don't be afraid of writing too much, just be aware that it will take more time to think about the more that is written.

## Writing in the manual

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

Clone the manual source locally 

    git clone https://github.com/adventuregamestudio/ags-manual-source.git

And add necessary screenshots inside `images/`, then add, commit and push the images.

### Code snippets in contributions

Always ensure your code snippets in the manual follow below

- Is as small as possible to achieve what's desired;
- Either can run on empty game template or can run on Sierra template;
- If it requires additional resources (like a gMyGUI, cEgo2, ...) it can be grasped from the context it's presented.

### Indexing

Index directives are added automatically, based on heading styles.

Markdown | Indexed as
--- | ---
\#\# Heading | Single entry: 'Heading'
\#\#\# Sub-heading | Paired entry: 'Heading' <-> 'Sub-heading'

To create an H2 style heading without an index entry, use the alternate H2 markup:

    Heading
    -------
    
H1 headings are not checked, effectively reserving their use for the primary title on the contents page.

## The build system

### Introduction

The current build system is based on converting `.md` files which are
written in GitHub Flavored Markdown (GFM). Conversion is done using
Pandoc using templates derived from Pandoc's default templates for
HTML4 and HTML5 output. Lua filters are used to modify content,
generate metadata, and implement custom output types.

There are currently two types of output which are produced:

- A directory of files which can be browsed as a static website
- A CHM file that can be used on Windows

Builds are configured through the use of the `configure` script which
will generate a Makefile suitable for the majority of `make`
implementations. The website pages are always generated since only
Pandoc is required. Creation of the CHM file is optional since it
depends on the presence of a CHM compiler.

Building on Windows is supported through using
[MSYS2](https://www.msys2.org/).

### The CHM problem

Creating a CHM file is a two-step process. Pandoc with custom Lua
scripting is able to recreate the equivalent of an 'htmlhelp' project
structure but the second stage requires running a CHM compiler which
takes this project as its input. Unfortunately the CHM format is
proprietary and only partially reverse engineered. There are two
feasible options:

1. Use Microsoft's own `hhc` compiler which is available within an
   installation of "HTML Help Workshop"
2. Use the `chmcmd` compiler which is supplied as part of
   the default installation of Free Pascal

Currently the build system will default to using `hhc` since this
maintains the same search index generation method which has been used
previously and because it is a known quantity. Unfortunately it only
works on Windows and Microsoft have removed the HTML Help Workshop
download from their website. It is unclear if anyone else has the
legal right to host a copy of it and/or distribute it.

Free Pascal's `chmcmd` compiler is functional and being actively
developed. The search index which it generates is smaller than the one
generated by `hhc` although potentially this is because `hhc` is
splitting words to allow partial searches to work. Given that `chmcmd`
is available and cross-platform it is the intention that, if CHM
builds are still required in the long term, the compiler preference
should be switched to `chmcmd`.

### Dependencies

When `configure` is run any dependencies will be searched for and
potentially tested. Setting the build variables which define the path
to a program implies that it is known working version so any tests
will be skipped.

#### Installing Pandoc

Pandoc can be downloaded from its GitHub release assets. The minimum
version required by the build process is 3.0. The following commands
will download a Pandoc binary into the current directory:

```sh pandoc Linux
# Download the Linux binary for Pandoc $PANDOC_VERSION into the current directory
url="https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-linux-amd64.tar.gz"
curl -fL "$url" | tar -f - -vxz --strip-components 2 pandoc-$PANDOC_VERSION/bin/pandoc
```

```sh pandoc macOS
# Download the macOS binary for Pandoc $PANDOC_VERSION into the current directory
url="https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-macOS.zip"
(cd /tmp && curl -fLOJ "$url")
bsdtar -vxf /tmp/pandoc-$PANDOC_VERSION-macOS.zip --strip-components 2 pandoc-$PANDOC_VERSION/bin/pandoc
```

```sh pandoc Windows
# Download the Windows binary for Pandoc $PANDOC_VERSION into the current directory
url="https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-windows-x86_64.zip"
(cd /tmp && curl -fLOJ "$url")
bsdtar -vxf /tmp/pandoc-$PANDOC_VERSION-windows-x86_64.zip --strip-components 1 pandoc-$PANDOC_VERSION/pandoc.exe
```

#### Installing HTML Help Workshop

HTML Help Workshop (which includes a copy of `hhc`) is no longer
available for download from Microsoft's website but it has been
archived at <https://archive.org/>. The following commands will
download the installer and run it without requiring any user
interaction:

```sh html-help-workshop
# Download HTML Help Workshop
url=https://web.archive.org/web/20200918004813/https://download.microsoft.com/download/0/A/9/0A939EF6-E31C-430F-A3DF-DFAE7960D564/htmlhelp.exe
(cd /tmp && curl -fLOJ "$url")

# Verify this was the expected download
checksum=b2b3140d42a818870c1ab13c1c7b8d4536f22bd994fa90aade89729a6009a3ae
echo "$checksum  /tmp/htmlhelp.exe" | sha256sum --check

# Extract the installer from the outer wrapper
/tmp/htmlhelp.exe //Q //T:"$(cygpath --windows /tmp/htmlhelp_ex)" //C

# Remove the update check and install
> /tmp/htmlhelp_ex/htmlhelp_noupdate.inf grep -v '^"hhupd.exe' /tmp/htmlhelp_ex/htmlhelp.inf
"$(cygpath --windir)/SysWOW64/rundll32.exe" advpack.dll,LaunchINFSection ""$(cygpath --windows /tmp/htmlhelp_ex/htmlhelp_noupdate.inf)"",,3,N

# Verify that the CHM compiler is now present
test -f '/c/Program Files (x86)/HTML Help Workshop/hhc.exe'
```

#### Installing chmcmd

Free Pascal installations should provide `chmcmd` by default. Binary
release archives should contain a copy, on Linux the following
commands will download the archive and just extract `chmcmd` to the
current directory:

```sh chmcmd Linux
# Download the Linux chmcmd binary to the current directory
url=https://sourceforge.net/projects/freepascal/files/Linux/3.2.2/fpc-3.2.2.x86_64-linux.tar/download
curl -fLSs "$url" | \
    tar -Oxf - fpc-3.2.2.x86_64-linux/binary.x86_64-linux.tar | \
    tar -Oxf - units-chm.x86_64-linux.tar.gz | \
    tar -xvzf - --strip-components 1 bin/chmcmd
```

An easy way to install on macOS is by using the
[Homebrew](https://brew.sh/) package manager. The follow commands will
update the package database and then install latest version of Free
Pascal:

```sh chmcmd macOS
# Install Free Pascal with the Homebrew package manager
brew update
brew install fpc
```

For Windows, the following commands will download the Free Pascal
installer and run it without requiring any user interaction:

```sh chmcmd Windows
# Download and install the Windows build of Free Pascal
url=https://sourceforge.net/projects/freepascal/files/Win32/3.2.2/fpc-3.2.2.i386-win32.exe/download
(cd /tmp && curl -fLo fpc-3.2.2.i386-win32.exe "$url")
/tmp/fpc-3.2.2.i386-win32.exe //sp- //verysilent //norestart
```

### Comparing builds

A reasonable way to check for variations in builds between different
platforms or different Pandoc versions is to perform a recursive diff
between builds on a common directory. Currently the CI system performs
a check on all builds of the website directory by using a script which
compares a single build to all other builds (where each argument to
the script is a directory containing the final website):

```sh diff-dirs
#!/bin/sh

if [ "$#" -lt 2 ]; then
    echo "Nothing to compare"
    exit 0
fi

first="$1"
rc=0
shift

for other; do
    echo "Comparing '$first' to '$other'"
    diff -r "$first" "$other" || rc=1
done

exit $rc
```

This is particularly useful when combined with a `make` implementation
which supports VPATH builds, which facilitate configuring and building
within a sub-directory:

```sh
mkdir build_3.0
cd build_3.0
../configure PANDOC=~/pandocs/3.0/pandoc
```

### Spelling check

Currently no spelling checks are made as part of the build process,
although it would appear to be feasible if an AGS specific dictionary
could be loaded and Markdown source has all script API references and
examples identified as code. Omitting the custom dictionary for the
moment it is possible to check the website pages with any tool which
can parse HTML and be told to ignore code elements and the page
footer:

```sh spellcheck
#!/bin/sh

for html in source/*.html; do
    echo "$html"
    cat "$html" | \
        aspell -d en \
               -H \
               --add-html-skip=code \
               --add-html-skip=footer \
               list | \
        sort | uniq -c
done
```

**Note that the dictionary should be configured as US English**

### Lua scripts

#### Common functions

- lua/agsman.lua

  A collection of functions which can be imported by any filters or
  writers. The `serialize` function which creates a textual
  presentation of a Lua table is found here.

#### Filters

- lua/insert_anchors.lua

  Replaces header content for level 2 or level 3 headings with an
  anchor link to itself.

- lua/insert_toc.lua

  Inserts a local table of contents above or below the first heading
  of a page, depending on the heading level structure of the page.

- lua/rewrite_links.lua

  Appends an additional file extension to link targets. The extension
  is taken from the output file's extension where possible.

- lua/set_title.lua

  Set the metadata value for the page title based on the text of the
  first level 2 heading which appears in the document.

#### Scripts

- lua/metacheck.lua

  Reads the page metadata table and cross-references information to
  look for broken links or index problems. If any issues are found
  they are written to stderr and the script will fail through a
  negative assertion.

#### Writers

- lua/write_feature_check.lua

  A writer which just performs any actions necessary to verify that
  the Pandoc version being used is suitable to build with. If any
  filter or writer depends on a specific Pandoc version it should be
  tested for here.

- lua/write_genindex.lua

  Writes an A-Z index page for the website build.

- lua/write_hhc.lua

  Writes a contents page for the htmlhelp project, to be read by the
  CHM compiler.

- lua/write_hhk.lua

  Writes an index file for the htmlhelp project, to be read by the CHM
  compiler.

- lua/write_hhp.lua

  Writes the main project file for the htmlhelp project, to be read by
  the CHM compiler.

- lua/write_metablock.lua

  Writes page metadata as a serialized Lua table.

- lua/write_metajs.lua

  Writes a JavaScript file for website search functionality. This
  includes the search functions as well as the search data.

## Creating releases

Below are the steps necessary to create a release, beginning from a
newly cloned working tree. Note that in order to bootstrap the build
system you will need a local installation of Autoconf, Automake, and
Git.

### Update the manual content

1. Clone the ags-manual-source sub-module

   Source content is referenced as a sub-module for the 'source'
   directory and so this directory will be initially be empty. Update
   all sub-modules to get the version of the source content which is
   currently referenced.

   ```
   git submodule update --init
   ```

2. Update the sub-module

   The source directory should no longer be empty. Pull the latest
   copy of source content and merge it.

   ```sh
   git submodule update --remote --merge
   ```

   If there were any changes they will be reported. Whoever is
   committing the changes is effectively responsible for promoting the
   content from the source into the official release; reading the
   changes in the page content is a good idea.

   ```sh
   git diff --submodule=diff
   ```

3. Bootstrap the build system

   At the time that the build system is bootstrapped the content of
   the sub-module (as reported by `git ls-files`) is the authoritative
   source of which source files will be incorporated into the build
   process.

   ```sh
   ./bootstrap
   ```

4. Configure and distcheck

   Run configure and then verify that everything builds and that there
   are no packaging problems. Ideally do this with the CHM build
   enabled to also cover optional files in the checks. Note that
   configuration for the 'distcheck' target is specified separately to
   the initial configuration.

   ```sh
   ./configure
   make DISTCHECK_CONFIGURE_FLAGS=--with-chmcmd distcheck
   ```

   When the process has completed you should see a confirmation that
   the release is available to use:

   ```
   ==================================================
   ags-manual-1.2.3 archives ready for distribution:
   ags-manual-1.2.3.tar.gz
   ==================================================
   ```

   The most likely cause of failure is that new external links have
   been added to the pages and they haven't yet been added to the
   approved links list. Approved links are listed alphabetically in
   [`meta/approved_links.txt`](https://github.com/adventuregamestudio/ags-manual/blob/master/meta/approved_links.txt).
   Once new links have been added to this file the 'distcheck' target
   should report success.

5. Commit the changes

   If the updates look OK and there are no issues highlighted by the
   checks commit the sub-module change:

   ```sh
   git add source
   git commit -m "Sync with source content"
   ```

   Now the changes can be pushed back.

### Generating a GitHub release

1. Check the current package version

   Firstly verify the package version currently defined by the build
   system:

   ```sh
   grep ^AC_INIT configure.ac
   ```

   ...which will give output similar to:

   ```
   AC_INIT([ags-manual], [1.2.3])
   ```

   This defines the package name and version. If the version needs to
   be increased edit the number and push the changes back before doing
   anything else.

2. Create a GitHub release

   This can be done in two ways but whichever method is used **you
   must ensure that the new tag name begins with a "v"**. For example,
   if the package version is "1.2.3" use the tag name "v1.2.3".
   
   The first method is via the GitHub web interface. Create a release
   based on a new tag which matches the format described above. The CI
   system will build and upload the release assets to the release you
   have just created.

   Alternatively, use git to create an annotated tag which matches the
   format described above:
   
   ```sh
   git tag -a v1.2.3 -m "Release version 1.2.3"
   ```

   When this tag is pushed back the CI system will build the release
   assets, create a GitHub release referencing this new tag, and
   upload the release assets to the release.
