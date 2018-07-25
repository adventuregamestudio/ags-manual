# Adventure Game Studio Help Files

[![Build Status](https://travis-ci.org/adventuregamestudio/ags-manual.svg?branch=master)](https://travis-ci.org/ericoporto/agshelp)

[**Edit the Help in the Wiki**](https://github.com/adventuregamestudio/ags-manual/wiki) | [**Revision History**](https://github.com/adventuregamestudio/ags-manual/wiki/_history)

The help files can be edited on the wiki or cloned locally and pushed. Create issues if something is wrong.

Alternatively, you can clone and edit the Wiki Locally

    git clone https://github.com/ericoporto/agshelp.wiki.git

## Read the help files

[Build rendered on ericoporto.github.io/agshelp/](https://adventuregamestudio.github.io/ags-manual)

## How to generate the help files from the wiki!

The help file is generated using [Python 3 Sphinx](http://www.sphinx-doc.org/en/master/)!

This documentation assumes you have Sphinx already installed and configured and is using a UNIX compatible OS.

To build the help files, clone this repository first!

    git clone git@github.com:adventuregamestudio/ags-manual.git
    cd agshelp

Then you need to get the wiki files

    ./get-help-source.sh

Now just use make to create any help version you want! **Example for html files and a help file**:

    make htmlhelp

## deploying in a different server

If there is need to deploy in a different server, edit the url resolver at the end of `conf.py` to point to the correct url.

    # -- Extension configuration -------------------------------------------------
    def setup(app):
        app.add_config_value('recommonmark_config', {
                'url_resolver': lambda url: 'https://adventuregamestudio.github.io/ags-manual/' + url,
                'auto_toc_tree_section': 'Contents',
                'enable_inline_math': False,
                }, True)
        app.add_transform(AutoStructify)

## checking wiki links

If making a lot of changes, the included AWK script can validate links within a directory:

    ./checklinks path/to/wiki/source/*.md

A checklinks task is run on every Travis-CI build, and the build will fail for any missing link. [Read the logs here to find the missing link](https://travis-ci.org/adventuregamestudio/ags-manual).

