[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags12.md#topic20)
[![Previous](back.gif)](ags14.md#topic21)
[![Next](forward.gif)](ags16.md#topic29)

------------------------------------------------------------------------

Distributing your game
----------------------

When you choose the "Build EXE" option in the Editor, a "Compiled"
sub-directory is created in your game's folder, where more
subdirectories are created in turn. "Compiled/Data" subfolder is made
always. It will contain the "raw" game files that cannot be used on
their own, but may be run by the AGS engine executable. From this folder
these files will be then copied into other subfolders, each for one
build target (platform) you selected in the project's General Settings.
For example, "Compiled/Windows" subfolder will be created if you have
Windows build enabled, and "Compiled/Linux" subfolder if you have Linux
build enabled. The contents of those subfolders may be now distributed
to corresponding operating systems. So, for example, if you want to
distribute Windows version of your game, you need to take the contents
of "Compiled/Windows" subfolder. At its simplest this will just be your
game executable and the setup program, but you may also have audio and
speech libraries (AUDIO.VOX and SPEECH.VOX); and if you have selected to
split resources files, you will also have several files named
"game.001", "game.002", and so forth.

*NOTE: It is not possible to load the exe file back into the AGS Editor.
This means two things when only the EXE file is available: (1) other
people can't edit your game's data, and (2) you can't either. Always
keep a backup of the other files produced (\*.CRM, GAME.AGF, etc) as
they are what the Editor needs to be able to load your game for
editing.*

*TIP:* You can make a "Loading..." style splash screen to be displayed
while your game starts up. To do so, simply save the image as
PRELOAD.PCX (must be the same resolution and colour depth as the game)
in the game folder, and build the game. It should then display while the
game is loading.

*NOTE: Due to the licenses of code used by AGS, your documentation
should acknowledge the following:*

TrueType font display uses ALFont by Javier Gonzalez and the Freetype
project. Distributed under the terms of the FreeType project license.

OGG player is alogg by Javier Gonzalez, using the Ogg Vorbis decoder,
which is available from http://www.xiph.org/ Copyright (c) 2002-2008,
Xiph.org Foundation

MP3 player is almp3, by Javier Gonzalez and the FreeAmp team. It uses
the mpg123 MP3 decoder, and is distributed under the terms of the GNU
Lesser General Public License version 2.1.

You should also include all the license\_\* files from the DOCS
directory with your game.

**IMPORTANT:** If you intend to make money for your game, be it
shareware or commercial, it is imperative that you read the Legal
Information page on the AGS website, currently at
http://www.adventuregamestudio.co.uk/site/ags/legal

**NOTE:** The AUDIO.VOX file contains audio clips that you have marked
as "InSeperateVOX" in the editor. This allows you to have an optional
audio download, if your game uses lots of sound files but you don't want
the player to have to download them.

[Custom icon](#topic28)\
[Splitting resource files](#SplitRes)\

------------------------------------------------------------------------

[]()

### Custom icon

If you wish, you can use your own custom icon when you build a Windows
EXE file. To do this, simply place your icon in your game's folder, and
name it USER.ICO. Then, load the editor and save the game.

AGS is only able to build your custom icon if you are running the editor
on Windows 2000 and later. If you're using Windows 98 then your game
will be built with the standard AGS icon.

*NOTE: The icon **must** be a proper Windows .ICO file, **not** just a
renamed BMP file. Icon editors, such as AX-Icons from
http://www.axialis.com, will convert it for you.*

You can also have a custom icon for the Setup program generated. To do
so, create your icon as above but name it **setup.ico** in the game
folder.

------------------------------------------------------------------------

[]()

### Splitting resource files

Some people found that once their game became large, the single EXE file
was slow to load due to anti-virus checkers scanning the whole file. AGS
includes an option to split up the resource files into smaller chunks to
avoid this happening. On the General Settings pane you'll notice a
setting "Split resource files into X Mb sized chunks".

If you tick this, then type in a number such as 1 or 2, then save the
game, the game data will be split up into chunks that size, named
GAME.001, GAME.002 and so on.

Some resources are still combined into the EXE file but all the rooms
will be placed into the other files. If you use this option, you need to
distribute your game's EXE file plus all the GAME.00? files.
