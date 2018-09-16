@echo off
setlocal enabledelayedexpansion

if not defined SOURCEDIR set SOURCEDIR=source
if not defined BUILDDIR set BUILDDIR=build
if not defined SPHINXPROJ set SPHINXPROJ=AGSHelp
if not defined SPHINXOPTS set SPHINXOPTS=-c .

if not defined GITURL set GITURL=https://github.com/adventuregamestudio/ags-manual.wiki.git
if not defined GITOPTS set GITOPTS=--depth=1 --branch=master

if not defined PROGRAMFILES(X86) (
    set HHC="%PROGRAMFILES%\HTML Help Workshop\hhc.exe"
) else (
    set HHC="%PROGRAMFILES(X86)%\HTML Help Workshop\hhc.exe"
)

if "%*" == "" (
    for /f "tokens=*" %%t in ('findstr /r "^:" "%~nx0"') do (
        set TARGET=%%t
        set TARGET=!TARGET:~1!
        if not "!TARGET!" == "end" echo !TARGET!
    )
) else (
    for %%t in (%*) do call :%%~t %%~t
)

goto end

:clone
if exist "%SOURCEDIR%" rd /s /q "%SOURCEDIR%"
git clone %GITOPTS% %GITURL% %SOURCEDIR%
copy /b NUL "%SOURCEDIR%\index.rst"
exit /b

:html
:htmlhelp
python -m sphinx -b %1 %SOURCEDIR% %BUILDDIR%\%1 %SPHINXOPTS%
exit /b

:chm
move "%BUILDDIR%\htmlhelp\AGSHelpdoc.hhp" "%TEMP%" &&^
findstr /v /c:"Binary TOC=No" /c:"Binary Index=No" "%TEMP%\AGSHelpdoc.hhp" > "%BUILDDIR%\htmlhelp\AGSHelpdoc.hhp"
%HHC% "%BUILDDIR%\htmlhelp\AGSHelpdoc.hhp"
move "%BUILDDIR%\htmlhelp\AGSHelpdoc.chm" ags-help.chm
exit /b

:clean
for /r %%d in (*.gitignore) do (
    for /f "tokens=*" %%c in (%%d) do (
        echo Cleaning %%~pd%%c
        2>nul rd /s /q "%%~pd%%c" || del "%%~pd%%c" /q /f
    )
)
exit /b

:end
endlocal
