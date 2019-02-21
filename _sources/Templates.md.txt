## New Game templates

When you choose "Start a new game" in the initial "Welcome to AGS"
dialog box, a window appears with various templates that you can base
your game off.

AGS comes with a few standard templates:

- 9-Verb Monkey Island Style
- [Empty Game] (...which is what it says and actually no template per se)
- [Sierra-style](TemplateSierraStyle)
- [LW_BASS_v2.0 (two click handler)](TemplateBASS) (like **B**eneath **a** **S**teel **S**ky)
- [Verbcoin](TemplateVerbcoin)

...but you can create your own too.

**NOTE:** the previously available "Default" template is now known as
"Sierra-style", which also contains updated graphics.

### If the list of templates is empty

The templates are normally located in "Templates" folder withing AGS Editor
directory. If the folder is empty, that could happen if AGS Editor installation
went wrong, or you have run from an incomplete package. What you may try:

- Reinstall AGS (preferrebly downloading an official release),
- Download templates (see below).
- Copy "Templates" folder from any other versions of AGS if you have them on
  your computer, but make sure these versions are not newer than the one you're
  going to use. Also in this case you have to be ready to possibly update the
  game scripts as templates may be using deprecated script commands.

### Using downloaded templates

If you've downloaded a game template from the internet, you should find
a file with a `.AGT` extension. This is the AGS Template File, and you
just need to copy it into the "Templates" folder within the AGS Editor
directory.

### Creating your own template

A game template is basically just an archive containing all of the game
source files, which are then extracted into the new folder when the user
creates a new game. It is similar to you just zipping up your game
folder and sending it to a friend - except that this way looks far more
professional.

To create a template, first of all you create a game as normal in the
editor. Once you have everything set up how you want it, select "_Make_
_template from this game_" on the File menu. This will prompt you for a
name for the template (this is what will appear under its icon in the
"_Start New Game_" dialog box), and then it will go away and compile the
template for you.

The template game takes the following files from your game folder: Core
game files (`GAME.AGF`, `ACSPRSET.SPR`), all script and room files, all
sound and music files, all fonts, game icons, and all `.TXT` files (to
allow you to include a `README.TXT` or whatever).

If you include a **template.ico** file in your game folder when you make
the template, then it will be used as the icon in the Start New Game
dialog box. Otherwise, the icon will be taken from `user.ico` (if
present), or if not it will get the default AGS icon.

You can also include a `template.txt` file in your game folder. If you
do, then its contents will be displayed to the user in a messagebox
after they create a new game based on the template. You could use this
to explain briefly about any key aspects of the template, or it could
tell them to read your README file. This file should be quite small,
its entire contents need to fit into a standard message box, so keep 
it below 255 characters.

NOTE: Do not simply make a template out of a half-finished game. If
you want to make a template, you should start a game from scratch and
make your changes - the user probably doesn't want to already have a
semi-completed game when they use your template. Gametemplates are rather about
different types of game controls, gameplay mechanics you want to share.
