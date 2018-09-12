## Upgrading to AGS 3.4.1

There were no breaking changes in this update, but several notes should
be made.

**Compiled folder structure**

Since previous big update, AGS 3.4.0, you can compile your game for more
than one platform at a time, and resulting files will be placed in the
corresponding subfolders of the "Compiled" folder, such as
"Compiled/Windows" and "Compiled/Linux". The raw compiled game files
(without executable) were still placed just in "Compiled".

In AGS 3.4.1 the raw compiled game files will be placed in
"Compiled/Data" instead. This change was made to improve the compiled
folder structure and make its contents cleaner.

For that reason, if you upgrade your game from one of the previous AGS
3.\* versions, it is recommended to either delete "Compiled" folder and
fully rebuild the game, or at least remove any files located in the
"Compiled" folder itself to clean things up.

**"Lazy" voice file compilation**

Speech voice-over file **speech.vox** is now compiled only when you
explicitly order game rebuild. When just launching the game from the
editor it won't be recompiled, and the game will load voice clips from
the Speech folder instead. This way it works similar to how sound and
music clips are loaded from AudioCache folder when game is tested, and
saves some time on game compilation, especially when working with large
projects.

**Default Setup pane**

A new node was added to the project tree, called "Default Setup".
Clicking on it will open a page with table of options, similar to
"General Settings". This is where you can choose the default
configuration of your game, that will be written to config file created
when your game is compiled (acsetup.cfg). One of the reasons for
introducing this pane is that since AGS 3.3.5 game setup program no
longer writes config to the file in game's folder, but to the file in
the user documents instead; therefore it is no longer possible to
directly create default config for your game using winsetup.exe.

"Graphics driver" option has migrated from "General Settings" to
"Default Setup".

For detailed information about Default Setup page refer to:
[Default setup](Settingupthegame#default-setup).

**Script API selector**

The "Script API version" and "Script Compatibility Level" switches in
General Settings (they were added in 3.4.0) now have "Highest"
selection. Choosing that will ensure that whenever you upgrade your game
to future versions of AGS, your game will automatically enable newest
script commands. Otherwise you would have to update these two switches
by hand every time.

Naturally, if you prefer to lock script API at particular level even
when moving to next versions of the editor, you would need to set API
levels to corresponding values.

**System limits update**

The maximal number of Dialogs is no longer limited.

