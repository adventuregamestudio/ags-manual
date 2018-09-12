## Upgrading to AGS 3.3.5

Since 3.3.5 AGS does not allow to **write** any files into other path
rather than "`$SAVEGAMEDIR$`" (personal user saves directory) or
"`$APPDATADIR$`" (all-users game data directory). If you attempt to open
file for **writing** using relative path without location tag, the
filepath will be automatically remapped to `$APPDATADIR$` location.

Because of that, for backwards compatibility reasons, when you try to
open file for reading using relative path without location tag, AGS will
first look for that file in `$APPDATADIR$`, and only if no matching file
is found there, then the game installation directory will be checked.

To force opening file in the game installation directory (for reading) a
new location tag was introduced: "`$INSTALLDIR$`". When using this tag
you will explicitly tell AGS to look in and only in the game's
installation directory. However, if you try opening file for writing at
such location, that will result in failure.

Players are now allowed to set up their own custom path in game setup,
where the game saves&data will be written. This is done in the game
setup program. This works as if `$SAVEGAMEDIR$` and `$APPDATADIR$` were
redirected to custom location. Redirection is done internally by the
engine, you do not need to add anything to your game scripts to make it
work.

Conceptually, AGS is gradually leaning towards using only "symbols of
file locations" rather than actual, explicit locations on the
filesystem.

Furthermore, game setup will now write config file into game saves
location, rather than game's installation directory. If config file is
present in the game installation folder, then it is used as "default"
read-only config file. The config in saves folder overrides default one.
This way it should be totally safe to install AGS games into C:/Program
Files, without having administrative rights.
