# Adventure Game Studio Help Files

How to generate the help files from the wiki!

[Edit the Help in the Wiki](https://github.com/ericoporto/agshelp/wiki)

Alternatively, you can clone and edit the Wiki Locally

    git clone https://github.com/ericoporto/agshelp.wiki.git

The help file is generated using [Python 3 Sphinx](http://www.sphinx-doc.org/en/master/)!

This documentation assumes you have Sphinx already installed and configured and is using a UNIX compatible OS.

To build the help files, clone this repository first!

    git clone git@github.com:ericoporto/agshelp.git
    cd agshelp

Then you need to get the wiki files

    cd sphinx-files
    ./get-help-source.sh

Now just use make to create any help version you want! Example for html files and a help file:

    make htmlhelp

