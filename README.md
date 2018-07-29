# Adventure Game Studio Help Files

[![Build Status](https://travis-ci.org/adventuregamestudio/ags-manual.svg?branch=master)](https://travis-ci.org/adventuregamestudio/ags-manual)

[**Edit the Help in the Wiki**](https://github.com/adventuregamestudio/ags-manual/wiki) | [**Revision History**](https://github.com/adventuregamestudio/ags-manual/wiki/_history)

The help files can be edited on the wiki or cloned locally and pushed. Create issues if something is wrong.

    git clone https://github.com/adventuregamestudio/ags-manual.wiki.git

## Read the help files

[Build rendered on adventuregamestudio.github.io/ags-manual/](https://adventuregamestudio.github.io/ags-manual)

## How to generate the help files from the wiki!

The help file is generated using [Python 3 Sphinx](http://www.sphinx-doc.org/en/master/)!

This documentation assumes you have Sphinx already installed and configured and is using a UNIX compatible OS.

To build the help files, clone this repository first!

    git clone git@github.com:adventuregamestudio/ags-manual.git
    cd agshelp

Then you need to get the wiki files

    ./get-help-source.sh

Now just use make to create any help version you want! **Example for html files**:

    make html

## checking wiki links

If making a lot of changes, the included AWK script can validate links within a directory:

    ./checklinks path/to/wiki/source/*.md

A checklinks task is run on every Travis-CI build, and the build will fail for any missing link. [Read the logs here to find the missing link](https://travis-ci.org/adventuregamestudio/ags-manual).

Additionally, you can also run sphinx linkchecker for verifying also broken external links.

    make linkcheck

