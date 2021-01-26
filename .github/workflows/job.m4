changequote(`<{', `}>')dnl
  __JOBNAME:
    outputs:
      html-sha256: ${{ steps.checksum.outputs.HTML_CHECKSUM }}
      htmlhelp-sha256: ${{ steps.checksum.outputs.HTMLHELP_CHECKSUM }}
    runs-on: __OS-latest
    defaults:
      run:
        shell: __SHELL
        working-directory: ags-manual
ifdef(<{__DATETIME}>,<{dnl
    env:
      DATETIME: __DATETIME
}>)dnl
    steps:
      - name: Checkout build system
        uses: actions/checkout@v2
        with:
          path: ags-manual
      - name: Checkout wiki
        uses: actions/checkout@v2
        with:
          repository: adventuregamestudio/ags-manual.wiki
          path: ags-manual.wiki
      - name: Download and install Pandoc
        shell: bash
        run : |
ifelse(__OS, <{ubuntu}>, <{dnl
          pandoc="pandoc-__PANDOC/bin/pandoc"
          suffix=linux-amd64.tar.gz
          tar=tar
}>)dnl
ifelse(__OS, <{macos}>, <{dnl
          pandoc="pandoc-__PANDOC/bin/pandoc"
          suffix=macOS.zip
          tar=bsdtar
}>)dnl
ifelse(__OS, <{windows}>, <{dnl
          pandoc=pandoc.exe
          suffix=windows-x86_64.zip
          tar=/c/Windows/System32/tar.exe
}>)dnl
          url="https://github.com/jgm/pandoc/releases/download/__PANDOC/pandoc-__PANDOC-$suffix"
          curl -fL "$url" | $tar -f - -vxzC "${{ runner.temp }}" "$pandoc"
          chmod +x "${{ runner.temp }}/$pandoc"
          echo PANDOC="${{ runner.temp }}/$pandoc" >> $GITHUB_ENV
ifelse(__OS, <{windows}>, <{dnl
      - name: Download and install HTML Help Workshop
        shell: cmd
        env:
          CHECKSUM: b2b3140d42a818870c1ab13c1c7b8d4536f22bd994fa90aade89729a6009a3ae
          HHC: C:\Program Files (x86)\HTML Help Workshop\hhc.exe
          URL: https://download.microsoft.com/download/0/A/9/0A939EF6-E31C-430F-A3DF-DFAE7960D564/htmlhelp.exe
        run: |
          %COMSPEC% /c "pushd "${{ runner.temp }}" && curl -fLOJ "%URL%"" || exit /b 1

          for /f %%a in ('certutil -hashfile "${{ runner.temp }}\htmlhelp.exe" SHA256 ^| find /v " "') do set SHA256=%%a
          if not "%SHA256%" == "%CHECKSUM%" exit /b 1

          "${{ runner.temp }}\htmlhelp.exe" /Q /T:"${{ runner.temp }}\htmlhelp" /C
          > "${{ runner.temp }}\htmlhelp\htmlhelp_noupdate.inf" findstr /v /b """hhupd.exe "${{ runner.temp }}\htmlhelp\htmlhelp.inf"
          %SYSTEMROOT%\SysWOW64\rundll32.exe advpack.dll,LaunchINFSection "${{ runner.temp }}\htmlhelp\htmlhelp_noupdate.inf",,3,N
          if not exist "%HHC%" exit /b 1

          echo HHC=%HHC%>> %GITHUB_ENV%
}>)dnl
      - name: Set path to Markdown files
        working-directory: ags-manual.wiki
ifelse(__SHELL, <{bash}>, <{dnl
        run: echo "CHECKOUTDIR=$(pwd)" >> $GITHUB_ENV
}>, <{dnl
        run: echo CHECKOUTDIR=%CD%>> %GITHUB_ENV%
      - name: Upgrade ezwinport make
        run: |
          mkdir "${{ runner.temp }}\make"
          %COMSPEC% /c "pushd "${{ runner.temp }}" && ^
            curl -fLOJ https://downloads.sourceforge.net/project/ezwinports/make-4.3-without-guile-w32-bin.zip"
          tar -f make-4.3-without-guile-w32-bin.zip -xvC "${{ runner.temp }}\make"
          echo ${{ runner.temp }}\make\bin>> %GITHUB_PATH%
}>)dnl
      - name: Get Markdown files
        run: make ifelse(__SHELL, <{cmd}>, <{SHELL=%COMSPEC% }>)source
      - name: Check Markdown files
ifelse(__SHELL, <{bash}>, <{dnl
        run: |
          set +e
          (! make -j $(getconf _NPROCESSORS_ONLN) metacheck 2>&1 >/dev/null | grep ^ERROR)
}>, <{dnl
        run: make SHELL=%COMSPEC% -j %NUMBER_OF_PROCESSORS% metacheck 2>&1 >nul | findstr /b ERROR && exit 1 & exit 0
}>)dnl
      - name: Build website
        run: make ifelse(__SHELL, <{cmd}>, <{SHELL=%COMSPEC% -j %NUMBER_OF_PROCESSORS%}>, <{-j $(getconf _NPROCESSORS_ONLN)}>) html
      - name: Upload website
        uses: actions/upload-artifact@v2
        with:
          name: html (__OS-__SHELL-__PANDOC)
          path: ags-manual/html/build
          if-no-files-found: error
      - name: Build HTML Help Project
        run: make ifelse(__SHELL, <{cmd}>, <{SHELL=%COMSPEC% -j %NUMBER_OF_PROCESSORS%}>, <{-j $(getconf _NPROCESSORS_ONLN)}>) htmlhelp
      - name: Upload HTML Help Project
        uses: actions/upload-artifact@v2
        with:
          name: htmlhelp (__OS-__SHELL-__PANDOC)
          path: ags-manual/htmlhelp/build
          if-no-files-found: error
      - name: Generate build checksums
        shell: bash
        run: |
          for d in html htmlhelp; do
              find $d/build -type f -print0 | LC_ALL=C sort -z | xargs -0 openssl sha256 | tee '${{ github.workspace }}'/checksums_$d
ifelse(__OS, <{windows}>, <{dnl
              dos2unix '${{ github.workspace }}'/checksums_$d
}>)dnl
          done;
      - name: Output checksum
        id: checksum
        shell: bash
        run: |
          echo "::set-output name=HTML_CHECKSUM::${{ hashFiles('checksums_html') }}"
          echo "::set-output name=HTMLHELP_CHECKSUM::${{ hashFiles('checksums_htmlhelp') }}"
      - name: Build CHM file
        if: env.HHC
        run: make ifelse(__SHELL, <{cmd}>, <{SHELL=%COMSPEC% -j %NUMBER_OF_PROCESSORS%}>, <{-j $(getconf _NPROCESSORS_ONLN)}>) chm
      - name: Upload CHM file
        if: env.HHC
        uses: actions/upload-artifact@v2
        with:
          name: ags-help.chm (__OS-__SHELL-__PANDOC)
          path: ags-manual/htmlhelp/build/ags-help.chm
          if-no-files-found: error
changequote(<{`}>, <{'}>)dnl
