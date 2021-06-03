include(`actions.m4')dnl
# This file is templated. Do not edit!
name: Release and upload

on:
  push:
    tags:
      - v*

jobs:
defjob(`windows', `bash', `2.9.2')dnl
include(`job.m4')dnl
      - name: Create wiki source archive
        shell: cmd
        working-directory: ags-manual.wiki
        run: |
          "%SYSTEMROOT%\System32\tar.exe" -acvf ..\ags-manual-wiki-md-source.zip *.md images\*
      - name: Create release and upload assets
        id: create_release
        uses: ncipollo/release-action@v1
        with:
          artifacts: "ags-manual/htmlhelp/build/ags-help.chm,ags-manual-wiki-md-source.zip"
          allowUpdates: true
          omitBodyDuringUpdate: true
          token: ${{ secrets.GITHUB_TOKEN }}
      - name: Deploy on GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ags-manual/html/build
divert(-1)dnl
undivert(1)dnl
