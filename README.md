# Adventure Game Studio Help Files

Travis (web): [![Build Status](https://travis-ci.com/adventuregamestudio/ags-manual.svg?branch=master)](https://travis-ci.com/adventuregamestudio/ags-manual) | Appveyor (chm): [![Build status](https://ci.appveyor.com/api/projects/status/ufw6n10yg1q38yvc?svg=true)](https://ci.appveyor.com/project/ags-manual-ci/ags-manual-4hkmp)

[**Edit the Help in the Wiki**](https://github.com/adventuregamestudio/ags-manual/wiki) | [**Revision History**](https://github.com/adventuregamestudio/ags-manual/wiki/_history)

The help files can be edited on the wiki or cloned locally and pushed. Please open an [issue](https://github.com/adventuregamestudio/ags-manual/issues) if something is wrong.

    git clone https://github.com/adventuregamestudio/ags-manual.wiki.git

## Reading the help files

The manual is hosted online on [adventuregamestudio.github.io/ags-manual/](https://adventuregamestudio.github.io/ags-manual).

You can also download the [latest release](https://github.com/adventuregamestudio/ags-manual/releases/latest).

![](ags-manual-readme.png)

## Building the help files

The help files are generated using [Python 3 Sphinx](http://www.sphinx-doc.org/en/master/)!

**Note that the use of a virtualenv is recommended if your Python installation is system-wide**

Install the requisite pip packages

    pip install -r requirements.txt

Install an HTML help compiler

For Windows, install [HTML Help Workshop](http://go.microsoft.com/fwlink/?LinkId=14188). For macOS, Unix, Linux, etc. install chmcmd from your regular package repository or install [Free Pascal](https://www.freepascal.org/download.var).

### Make targets

name | function
--- | ---
clone | git clone the wiki source
html | run sphinx-build with the html builder
htmlhelp | run sphinx-build with the htmlhelp builder
chm | run the HTML compiler
clean | delete everything listed in .gitignore

build just the html site

    make clone html
    
build just the CHM (Windows help) file

    make clone htmlhelp chm

build everything

    make clone html htmlhelp chm
    
rebuild everything

    make clean clone html htmlhelp chm

## Indexing

Index directives are added automatically, based on heading styles.

Markdown | Indexed as
--- | ---
\#\# Heading | Single entry: 'Heading'
\#\#\# Sub-heading | Paired entry: 'Heading' <-> 'Sub-heading'

To create an H2 style heading without an index entry, use the alternate H2 markup:

    Heading
    -------
    
H1 headings are not checked, effectively reserving their use for the primary title on the contents page.

## Checking wiki links

If making a lot of changes, the included AWK script can validate links within a directory:

    ./checklinks path/to/wiki/source/*.md

A checklinks task is run on every Travis-CI build, and the build will fail for any missing link. Read the logs [here](https://travis-ci.org/adventuregamestudio/ags-manual) to find the missing link.
