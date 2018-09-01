# Adventure Game Studio Help Files

[![Build Status](https://travis-ci.org/adventuregamestudio/ags-manual.svg?branch=master)](https://travis-ci.org/adventuregamestudio/ags-manual)

[**Edit the Help in the Wiki**](https://github.com/adventuregamestudio/ags-manual/wiki) | [**Revision History**](https://github.com/adventuregamestudio/ags-manual/wiki/_history)

The help files can be edited on the wiki or cloned locally and pushed. Create issues if something is wrong.

    git clone https://github.com/adventuregamestudio/ags-manual.wiki.git

## Read the help files

The manual is hosted online on [adventuregamestudio.github.io/ags-manual/](https://adventuregamestudio.github.io/ags-manual) .

You can also download it from [latest release](https://github.com/adventuregamestudio/ags-manual/releases/latest) .

![](ags-manual-readme.png)

## How to generate the help files from the wiki!

The help file is generated using [Python 3 Sphinx](http://www.sphinx-doc.org/en/master/)!

This documentation assumes you have Sphinx already installed and configured and you have access to a Unix-style *bash* compatible shell.

To build the help files, clone this repository first!

    git clone git@github.com:adventuregamestudio/ags-manual.git
    cd agshelp

Then you need to get the wiki files

    ./get-help-source.sh

Now just use make to create any help version you want! **Example for html files**:

    make html

## Indexing

Index directives are added automatically, based on heading styles.

Markdown | Indexed as
--- | ---
\#\# Heading | Single entry: 'Heading'
\#\#\# Sub-heading | Paired entry: 'Heading' <-> 'Sub-heading'

Using \#\#\# without a preceeding \#\# on the page will generate a warning and be ignored by Sphinx, so it won't appear in the index. To create an H2 style heading without an index entry, use the alternate H2 markup:

    Heading
    -------
    
H1 headings are not checked, effectively reserving their use for primary document titles.

## Checking wiki links

If making a lot of changes, the included AWK script can validate links within a directory:

    ./checklinks path/to/wiki/source/*.md

A checklinks task is run on every Travis-CI build, and the build will fail for any missing link. [Read the logs here to find the missing link](https://travis-ci.org/adventuregamestudio/ags-manual).

Additionally, *sphinx linkchecker* can check if external links are broken.

    make linkcheck
