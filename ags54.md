[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags53.md#topic52)
[![Next](forward.gif)](ags55.md#GUIFuncsAndProps)

------------------------------------------------------------------------

Game / Global functions
-----------------------

[AbortGame](#AbortGame)\
[CallRoomScript](#CallRoomScript)\
[ChangeTranslation](#Game.ChangeTranslation)\
[ClaimEvent](#ClaimEvent)\
[Debug](#Debug)\
[DeleteSaveSlot](#DeleteSaveSlot)\
[DisableInterface](#DisableInterface)\
[DoOnceOnly](#Game.DoOnceOnly)\
[EnableInterface](#EnableInterface)\
[EndCutscene](#EndCutscene)\
[GetColorFromRGB](#Game.GetColorFromRGB)\
[GetFrameCountForLoop](#Game.GetFrameCountForLoop)\
[GetGameOption](#GetGameOption)\
[GetGameParameter](#GetGameParameter)\
[GetGameSpeed](#GetGameSpeed)\
[GetGlobalInt](#GetGlobalInt)\
[GetGraphicalVariable](#GetGraphicalVariable)\
[GetLocationName](#Game.GetLocationName)\
[GetLocationType](#GetLocationType)\
[GetLoopCountForView](#Game.GetLoopCountForView)\
[GetRunNextSettingForLoop](#Game.GetRunNextSettingForLoop)\
[GetSaveSlotDescription](#Game.GetSaveSlotDescription)\
[GetTextHeight](#GetTextHeight)\
[GetTextWidth](#GetTextWidth)\
[GetTranslation](#GetTranslation)\
[GetViewFrame](#Game.GetViewFrame)\
[GiveScore](#GiveScore)\
[GetFontHeight](#GetFontHeight)\
[GetFontLineSpacing](#GetFontLineSpacing)\
[InputBox](#Game.InputBox)\
[InventoryScreen](#InventoryScreen)\
[IsGamePaused](#IsGamePaused)\
[IsInterfaceEnabled](#IsInterfaceEnabled)\
[IsInteractionAvailable](#IsInteractionAvailable)\
[IsKeyPressed](#IsKeyPressed)\
[IsPluginLoaded](#IsPluginLoaded)\
[IsTimerExpired](#IsTimerExpired)\
[IsTranslationAvailable](#IsTranslationAvailable)\
[MoveCharacterToHotspot](#MoveCharacterToHotspot)\
[MoveCharacterToObject](#MoveCharacterToObject)\
[PauseGame](#PauseGame)\
[QuitGame](#QuitGame)\
[Random](#Random)\
[RestartGame](#RestartGame)\
[RestoreGameDialog](#RestoreGameDialog)\
[RestoreGameSlot](#RestoreGameSlot)\
[RunAGSGame](#RunAGSGame)\
[SaveGameDialog](#SaveGameDialog)\
[SaveGameSlot](#SaveGameSlot)\
[SaveScreenShot](#SaveScreenShot)\
[SetAmbientLightLevel](#SetAmbientLightLevel)\
[SetAmbientTint](#SetAmbientTint)\
[SetGameOption](#SetGameOption)\
[SetGameSpeed](#SetGameSpeed)\
[SetGlobalInt](#SetGlobalInt)\
[SetGraphicalVariable](#SetGraphicalVariable)\
[SetMultitaskingMode](#SetMultitaskingMode)\
[SetRestartPoint](#SetRestartPoint)\
[SetSaveGameDirectory](#Game.SetSaveGameDirectory)\
[SetTextWindowGUI](#SetTextWindowGUI)\
[SetTimer](#SetTimer)\
[SkipUntilCharacterStops](#SkipUntilCharacterStops)\
[StartCutscene](#StartCutscene)\
[UpdateInventory](#UpdateInventory)\
[UnPauseGame](#UnPauseGame)\
[Wait](#Wait)\
[WaitKey](#WaitKey)\
[WaitMouseKey](#WaitMouseKey)\
[AudioClipCount property](#Game.AudioClipCount)\
[AudioClips property](#Game.AudioClips)\
[CharacterCount property](#Game.CharacterCount)\
[DialogCount property](#Game.DialogCount)\
[FileName property](#Game.FileName)\
[FontCount property](#Game.FontCount)\
[GlobalMessages property](#Game.GlobalMessages)\
[GlobalStrings property](#Game.GlobalStrings)\
[GUICount property](#Game.GUICount)\
[IgnoreUserInputAfterTextTimeoutMs
property](#Game.IgnoreUserInputAfterTextTimeoutMs)\
[InSkippableCutscene property](#Game.InSkippableCutscene)\
[InventoryItemCount property](#Game.InventoryItemCount)\
[MinimumTextDisplayTimeMs property](#Game.MinimumTextDisplayTimeMs)\
[MouseCursorCount property](#Game.MouseCursorCount)\
[Name property (game)](#Game.Name)\
[NormalFont property](#Game.NormalFont)\
[SkippingCutscene property](#Game.SkippingCutscene)\
[SpeechFont property](#Game.SpeechFont)\
[SpriteHeight property](#Game.SpriteHeight)\
[SpriteWidth property](#Game.SpriteWidth)\
[TextReadingSpeed property](#Game.TextReadingSpeed)\
[TranslationFilename property](#Game.TranslationFilename)\
[UseNativeCoordinates property](#Game.UseNativeCoordinates)\
[ViewCount property](#Game.ViewCount)\

------------------------------------------------------------------------

[]()

### AbortGame

    AbortGame(string message, ...)

Aborts the game and returns to the operating system.

The standard AGS error dialog is displayed, with the script line numbers
and call stack, along with *message* (which can include `%d` and `%s`
Display-style tokens).

You can use this function rather than QuitGame if you are writing some
debugging checks into your script, to make sure that the user calls your
functions in the correct way.

This command should ideally never be called in the final release of a
game.

Example:

    function MakeWider(int newWidth) {
      if (newWidth < 10)
        AbortGame("newWidth expects a width of at least 10!");
    }

will abort the game if MakeWider is called with a parameter less than
10.

SeeAlso: [QuitGame](ags54.md#QuitGame)

------------------------------------------------------------------------

[]()

### CallRoomScript

    CallRoomScript (int value)

Calls the `on_call` function in the current room script. This is useful
for things like the text parser, where you want to check for general
game sentences, and then ask the current room if the sentence was
relevant to it.

The on\_call function will be called in the current room script, with
its `value` parameter having the value you pass here. This allows it to
distinguish between different tasks, and saves you having to use a
GlobalInt to tell it what to do.

If the current room has no on\_call function, nothing will happen. No
error will occur.

You write the on\_call function into the room script ("Edit script"
button on Room Settings pane), similar to the way you do dialog\_request
in the global script:

    function on_call (int value) {
      if (value == 1) {
        // Check text input
        if (Parser.Said("get apple"))
          Display("No, leave the tree alone.");
      }
    }

The function doesn't get called immediately; instead, the engine will
run it in due course, probably during the next game loop, so you can't
use any values set by it immediately.

Once the on\_call function has executed (or not if there isn't one), the
game.roomscript\_finished variable will be set to 1, so you can check
for that in your repeatedly\_execute script if you need to do something
afterwards.

SeeAlso: [The text parser documentation](ags17.md#TextParser)

------------------------------------------------------------------------

[]()

### ChangeTranslation

    static bool Game.ChangeTranslation(string newTranslationName)

Changes the active translation to *newTranslationName*. This must be the
file name without the extension, for example "French" or "Spanish". It
can also be a blank string, in which case the current translation will
be switched off and the game will revert to the default language.

Returns *true* if the translation was changed successfully, or *false*
if there was a problem (for example, you specified an invalid
translation).

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example below.

Example:

    if (Game.ChangeTranslation("Spanish") == true)
    {
      Display("Changed the translation to Spanish!");
    }
    else
    {
      Display("Unable to change the translation");
    }

will attempt to change the translation to Spanish

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[Game.TranslationFilename](ags54.md#Game.TranslationFilename),
[IsTranslationAvailable](ags54.md#IsTranslationAvailable)

------------------------------------------------------------------------

[]()

### ClaimEvent

    ClaimEvent()

This command is used in a room script or script module's
*on\_key\_press* or *on\_mouse\_click* function, and it tells AGS not to
run the global script afterwards.

For example, if your room script responds to the player pressing the
space bar, and you don't want the global script's on\_key\_press to
handle it as well, then use this command.

This is useful if you have for example a mini-game in the room, and you
want to use some keys for a different purpose to what they normally do.

The normal order in which scripts are called for *on\_key\_press* and
*on\_mouse\_click* is as follows:

-   room script
-   script modules, in order
-   global script

If any of these scripts calls ClaimEvent, then the chain is aborted at
that point.

Example:

    if (keycode == ' ') {
      Display("You pressed space in this room!");
      ClaimEvent();
    }

prevents the global script on\_key\_press from running if the player
pressed the space bar.

SeeAlso: [Script events](ags40.md#TextScriptEvents)

------------------------------------------------------------------------

[]()

### Debug

    Debug (int command, int data)

This function provides all the debug services in the system. It performs
various different tasks, depending on the value of the COMMAND
parameter. If debug mode is off, then this function does nothing. This
allows you to leave your script unaltered when you distribute your game,
so you just have to turn off debug mode in the AGS Editor.

The DATA parameter depends on the command - pass 0 if it is not used.
All the valid values for the COMMAND parameter are listed below along
with what they do:

    0   All inventory - gives the current player character one of every
        inventory item. This is useful for testing so that you don't have to
        go and pick up items every time you test part of the game where they
        are required.
    1   Display interpreter version - the engine will display its version
        number and build date.
    2   Walkable from here - fills in the parts of the screen where the player
        can walk from their current location. This is useful if you think the
        path-finder is not working properly. All walkable areas are drawn in
        their respective colours, but with blocking areas at characters feet
        removed.
    3   Teleport - displays a dialog box asking for what room you want to go
        to, and then calls ChangeRoom to teleport you there. Useful for skipping
        parts of the game or going to a specific point to test something.
    4   Show FPS - toggles whether the current frames per second is displayed
        on the screen. Pass DATA as 1 to turn this on, 0 to turn it off.

*See Also:* [Debugging features](ags24.md#Debuggingfeatures),
[System.RuntimeInfo](ags77.md#System.RuntimeInfo)

------------------------------------------------------------------------

[]()

### DeleteSaveSlot

    DeleteSaveSlot (int slot)

Deletes the save game in save slot number SLOT.

NOTE: if you specify one of the standard slots (1-50), then AGS will
rearrange the other save games to make sure there is a sequence of slots
from 1 upwards. Therefore, you will need to refresh any save game lists
you have after calling this function.

Example:

    DeleteSaveSlot (130);

deletes save game slot 130 (which we should have saved earlier).

*See Also:* [RestoreGameSlot](ags54.md#RestoreGameSlot),
[SaveGameSlot](ags54.md#SaveGameSlot)

------------------------------------------------------------------------

[]()

### DisableInterface

    DisableInterface ()

Disables the player interface. This works the same way as it is disabled
while an animation is running: the mouse cursor is changed to the Wait
cursor, and mouse clicks will not be sent through to the
"on\_mouse\_click" function. Also, all interface buttons will be
disabled.

**NOTE:** AGS keeps a count of the number of times DisableInterface is
called. Every call to DisableInterface must be matched by a later call
to EnableInterface, otherwise the interface will get permanently
disabled.

Example:

    DisableInterface();

will disable the user's interface.

*See Also:* [EnableInterface](ags54.md#EnableInterface),
[IsInterfaceEnabled](ags54.md#IsInterfaceEnabled)

------------------------------------------------------------------------

[]()

### DoOnceOnly

    static bool Game.DoOnceOnly(const string token)

This function gives you an easy way of making some code run only the
first time that the player encounters it. It is commonly used for
awarding points.

The *token* parameter is an arbitrary string. You can pass whatever you
like in for this, but **IT MUST BE UNIQUE**. It is this string that
allows AGS to determine whether this section of code has been run
before, therefore you should make sure that **you do not use the same
token string in two different places in your game**.

Returns *true* the first time that it is called with this token, and
*false* thereafter.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example below.

Example:

    if (Game.DoOnceOnly("open cupboard")) {
      GiveScore(5);
    }

will give the player 5 points the first time this script is run.

*See Also:* [GiveScore](ags54.md#GiveScore)

------------------------------------------------------------------------

[]()

### EnableInterface

    EnableInterface ()

Re-enables the player interface, which was previously disabled with the
DisableInterface function. Everything which was disabled is returned to
normal.

Example:

    EnableInterface();

will enable the user's interface.

*See Also:* [DisableInterface](ags54.md#DisableInterface),
[IsInterfaceEnabled](ags54.md#IsInterfaceEnabled)

------------------------------------------------------------------------

[]()

### EndCutscene

    EndCutscene()

Marks the end of a cutscene. If the player skips the cutscene, the game
will fast-forward to this point. This function returns 0 if the player
watched the cutscene, or 1 if they skipped it.

*See Also:* [StartCutscene](ags54.md#StartCutscene),
[Game.InSkippableCutscene](ags54.md#Game.InSkippableCutscene),
[Game.SkippingCutscene](ags54.md#Game.SkippingCutscene)

------------------------------------------------------------------------

[]()

### GetColorFromRGB

*(Formerly known as RawSetColorRGB, which is now obsolete)*

    static int Game.GetColorFromRGB(int red, int green, int blue)

Gets the AGS Colour Number for the specified RGB colour. The red, green
and blue components are values from 0 to 255. This function gives you a
run-time equivalent to the Colour Finder in the editor.

This command is slow in 256-colour games, since the palette has to be
scanned to find the nearest matching colour.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example below.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = Game.GetColorFromRGB(0, 255, 0);
    surface.DrawLine(0, 0, 50, 50);
    surface.Release();

will draw a bright green line onto the room background

*See Also:*
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor)

------------------------------------------------------------------------

[]()

### GetFrameCountForLoop

*(Formerly part of GetGameParameter, which is now obsolete)*

    static int Game.GetFrameCountForLoop(int view, int loop)

Returns the number of frames in the specified loop of the specified
view.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example for more.

Example:

    int frameCount = Game.GetFrameCountForLoop(SWIMMING, 2);
    Display("Loop 2 in SWIMMING view has %d frames.", frameCount);

*See Also:*
[Game.GetLoopCountForView](ags54.md#Game.GetLoopCountForView),
[Game.GetRunNextSettingForLoop](ags54.md#Game.GetRunNextSettingForLoop),
[Game.GetViewFrame](ags54.md#Game.GetViewFrame)

------------------------------------------------------------------------

[]()

### GetGameOption

    GetGameOption (option)

Gets the current setting of one of the game options, originally set in
the AGS Editor Game Settings pane.

OPTION specifies which option to get, and its current value is returned.

The valid values for OPTION are listed in
[SetGameOption](ags54.md#SetGameOption).

Example:

    if (GetGameOption(OPT_PIXELPERFECT) == 1) {
      Display("pixel-perfect click deteciton is on!");
    }

*See Also:* [SetGameOption](ags54.md#SetGameOption)

------------------------------------------------------------------------

[]()

### GetGameParameter

The *GetGameParameter* function is now obsolete.

It has been replaced with the following functions and properties:

[Game.SpriteWidth](ags54.md#Game.SpriteWidth) (was GP\_SPRITEWIDTH)\
[Game.SpriteHeight](ags54.md#Game.SpriteHeight) (was GP\_SPRITEHEIGHT)\
[Game.GetLoopCountForView](ags54.md#Game.GetLoopCountForView) (was
GP\_NUMLOOPS)\
[Game.GetFrameCountForLoop](ags54.md#Game.GetFrameCountForLoop) (was
GP\_NUMFRAMES)\
[Game.GetRunNextSettingForLoop](ags54.md#Game.GetRunNextSettingForLoop)
(was GP\_ISRUNNEXTLOOP)\
[Game.GetViewFrame](ags54.md#Game.GetViewFrame) (was GP\_FRAMExxx,
GP\_ISFRAMEFLIPPED)\
[Game.GUICount](ags54.md#Game.GUICount) (was GP\_NUMGUIS)\
[Room.ObjectCount](ags73.md#Room.ObjectCount) (was GP\_NUMOBJECTS)\
[Game.CharacterCount](ags54.md#Game.CharacterCount) (was
GP\_NUMCHARACTERS)\
[Game.InventoryItemCount](ags54.md#Game.InventoryItemCount)(was
GP\_NUMINVITEMS)

------------------------------------------------------------------------

[]()

### GetGameSpeed

    GetGameSpeed ()

Returns the current game speed (number of cycles per second).

Example:

    if (GetGameSpeed() > 40) {
      SetGameSpeed(40);
    }

will always keep the game speed at 40 cycles per second (in case the
user has raised it )

*See Also:* [SetGameSpeed](ags54.md#SetGameSpeed)

------------------------------------------------------------------------

[]()

### GetGlobalInt

    GetGlobalInt (int index)

Returns the value of global int INDEX.

**NOTE:** GlobalInts are now considered obsolete. Consider using [global
variables](ags19.md#GlobalVariables) instead, which allow you to name
the variables.

Example:

    if (GetGlobalInt(20) == 1) {
      // code here
    }

will execute the code only if Global Integer 20 is 1.

*See Also:* [SetGlobalInt](ags54.md#SetGlobalInt),
[Game.GlobalStrings](ags54.md#Game.GlobalStrings)

------------------------------------------------------------------------

[]()

### GetGraphicalVariable

    GetGraphicalVariable (string variable_name);

Returns the value of the interaction editor VARIABLE\_NAME variable.
This allows your script to access the values of variables set in the
interaction editor.

**NOTE:** This command is obsolete, and is only provided for backwards
compatibility with AGS 2.x. When writing new code, use [global
variables](ags19.md#GlobalVariables) instead.

Example:

    if (GetGraphicalVariable("climbed rock")==1)
       { code here }

will execute the code only if interaction variable "climbed rock" is 1.

*See Also:* [GetGlobalInt](ags54.md#GetGlobalInt),
[SetGraphicalVariable](ags54.md#SetGraphicalVariable)

------------------------------------------------------------------------

[]()

### GetLocationName

*(Formerly known as global function GetLocationName, which is now
obsolete)*

    static String Game.GetLocationName(int x, int y)

Returns the name of whatever is on the screen at (X,Y). This allows you
to create the Lucasarts-style status lines reading "Look at xxx" as the
player moves the cursor over them.

**NOTE:** Unlike Room.ProcessClick, this function actually works on what
the player can see on the screen - therefore, if the co-ordinates are on
a GUI, a blank string is returned.

**NOTE:** The co-ordinates are SCREEN co-ordinates, NOT ROOM
co-ordinates. This means that with a scrolling room, the co-ordinates
you pass are relative to the screen's current position, and NOT absolute
room co-ordinates. This means that this function is suitable for use
with the mouse cursor position variables.

Example:

    String location = Game.GetLocationName(mouse.x, mouse.y);

will get the name of whatever the mouse is over into the string
variable.

*See Also:* [Hotspot.Name](ags63.md#Hotspot.Name),
[InventoryItem.Name](ags64.md#InventoryItem.Name),
[GetLocationType](ags54.md#GetLocationType),
[Object.Name](ags68.md#Object.Name)

------------------------------------------------------------------------

[]()

### GetLocationType

    GetLocationType(int x, int y)

Returns what type of thing is at location (X,Y); whether it is a
character, object, hotspot or nothing at all. This may be useful if you
want to process a mouse click differently depending on what the player
clicks on.

**NOTE:** The co-ordinates are screen co-ordinates, NOT room
co-ordinates. See description of GetLocationName for more info.

The value returned is one of the following:

    eLocationNothing    nothing, GUI or inventory
    eLocationHotspot    a hotspot
    eLocationCharacter  a character
    eLocationObject     an object

Example:

    if (GetLocationType(mouse.x,mouse.y) == eLocationCharacter)
        mouse.Mode = eModeTalk;

will set the cursor mode to talk if the cursor is over a character.

*See Also:* [Hotspot.GetAtScreenXY](ags63.md#Hotspot.GetAtScreenXY),
[Game.GetLocationName](ags54.md#Game.GetLocationName),
[Object.GetAtScreenXY](ags68.md#Object.GetAtScreenXY)

------------------------------------------------------------------------

[]()

### GetLoopCountForView

*(Formerly part of GetGameParameter, which is now obsolete)*

    static int Game.GetLoopCountForView(int view)

Returns the number of loops in the specified view.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example for more.

Example:

    int loops = Game.GetLoopCountForView(SWIMMING);
    Display("The SWIMMING view (view %d) has %d loops.", SWIMMING, loops);

*See Also:*
[Game.GetRunNextSettingForLoop](ags54.md#Game.GetRunNextSettingForLoop),
[Game.GetFrameCountForLoop](ags54.md#Game.GetFrameCountForLoop),
[Game.GetViewFrame](ags54.md#Game.GetViewFrame)

------------------------------------------------------------------------

[]()

### GetRunNextSettingForLoop

*(Formerly part of GetGameParameter, which is now obsolete)*

    static bool Game.GetRunNextSettingForLoop(int view, int loop)

Returns whether the specified loop in the specified view has the "Run
the next loop after this one" option checked.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example for more.

Example:

    if (Game.GetRunNextSettingForLoop(SWIMMING, 5) == true) {
      Display("Loop 5 in view SWIMMING does have Run Next Loop set.");
    }
    else {
      Display("Loop 5 in view SWIMMING does not have Run Next Loop set.");
    }

*See Also:*
[Game.GetLoopCountForView](ags54.md#Game.GetLoopCountForView),
[Game.GetFrameCountForLoop](ags54.md#Game.GetFrameCountForLoop),
[Game.GetViewFrame](ags54.md#Game.GetViewFrame)

------------------------------------------------------------------------

[]()

### GetSaveSlotDescription

*(Formerly known as global function GetSaveSlotDescription, which is now
obsolete)*

    static String Game.GetSaveSlotDescription(int slot)

Gets the text description of save game slot SLOT.

If the slot number provided does not exist, returns *null*.

Example:

    String description = Game.GetSaveSlotDescription(10);

will get the description of save slot 10 into the variable.

*See Also:*
[DynamicSprite.CreateFromSaveGame](ags52.md#DynamicSprite.CreateFromSaveGame),
[RestoreGameSlot](ags54.md#RestoreGameSlot),
[SaveGameSlot](ags54.md#SaveGameSlot)

------------------------------------------------------------------------

[]()

### GetTextHeight

    GetTextHeight(string text, FontType font, int width)

Calculates the height on the screen that drawing TEXT in FONT within an
area of WIDTH would take up.

This allows you to work out how tall a message displayed with a command
like [DrawMessageWrapped](ags51.md#DrawingSurface.DrawMessageWrapped)
will be. WIDTH is the width of the area in which the text will be
displayed.

The height is returned in normal 320-resolution pixels, so it can be
used with the screen display commands.

Example:

    int height = GetTextHeight("The message on the GUI!", Game.NormalFont, 100);
    gBottomLine.SetPosition(0, 200 - height);

will move the BOTTOMLINE GUI so that it can display the text within the
screen.

*See Also:* [GetTextWidth](ags54.md#GetTextWidth),
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString)

------------------------------------------------------------------------

[]()

### GetTextWidth

    GetTextWidth(string text, FontType font)

Returns the width on the screen that drawing TEXT in FONT on one line
would take up.

This could be useful if you manually need to centre or right-align some
text, for example with the raw drawing routines.

The width is returned in normal 320-resolution pixels, so it can be used
with the screen display commands.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    int width = GetTextWidth("Hello!", Game.NormalFont);
    surface.DrawString(160 - (width / 2), 100, Game.NormalFont, "Hello!");
    surface.Release();

will print "Hello!" onto the middle of the background scene.

*See Also:* [GetTextHeight](ags54.md#GetTextHeight),
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString)

------------------------------------------------------------------------

[]()

### GetTranslation

    String GetTranslation(string original)

Gets the translated equivalent of the supplied string. You do not
normally need to use this since the game translates most things for you.
However, if you have used an InputBox or other form of user input, and
want to compare the user's input to a particular string, it cannot be
translated automatically. So, you can do this instead.

Example:

    String buffer = Game.InputBox("Enter the password:");
    if (buffer.CompareTo(GetTranslation("secret")) == 0) {
      // it matched the current translation of "secret"
    }

If there is no translation for the supplied string, it will be returned
unchanged, so it is always safe to use this function.

*See Also:* [IsTranslationAvailable](ags54.md#IsTranslationAvailable)

------------------------------------------------------------------------

[]()

### GetViewFrame

*(Formerly part of GetGameParameter, which is now obsolete)*

    static ViewFrame* Game.GetViewFrame(int view, int loop, int frame)

Returns a *ViewFrame* instance for the specified frame in the specified
loop of the specified view.

This instance allows you to query properties of the frame itself, such
as its graphic, its frame-linked sound setting, and so forth.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example for more.

Example:

    ViewFrame *frame = Game.GetViewFrame(SWIMMING, 2, 3);
    Display("Frame 3 in loop 2 of view SWIMMING has sprite slot %d.", frame.Graphic);

*See Also:*
[Game.GetLoopCountForView](ags54.md#Game.GetLoopCountForView),
[Game.GetRunNextSettingForLoop](ags54.md#Game.GetRunNextSettingForLoop),
[Game.GetFrameCountForLoop](ags54.md#Game.GetFrameCountForLoop),
[ViewFrame.Graphic](ags79.md#ViewFrame.Graphic),
[ViewFrame.Speed](ags79.md#ViewFrame.Speed)

------------------------------------------------------------------------

[]()

### GiveScore

    GiveScore (int score)

Adds SCORE to the player's score. This is preferable to directly
modifying the variable since it will play the score sound, update any
status lines and call the GOT\_SCORE on\_event function.

Note that SCORE can be negative, in which case the score sound is NOT
played.

Example:

    GiveScore(5);

will give 5 points to the player.

*See Also:* [Game.DoOnceOnly](ags54.md#Game.DoOnceOnly)

------------------------------------------------------------------------

[]()

### GetFontHeight

    int GetFontHeight (int font)

Returns the given font's height, in pixels. This value may be used, for
example, to calculate arrangement of text and GUI elements on screen.

Example:

    int h = GetFontHeight(eFontSpeech);

will store the speech font's height in the variable.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [GetFontLineSpacing](ags54.md#GetFontLineSpacing)

------------------------------------------------------------------------

[]()

### GetFontLineSpacing

    int GetFontLineSpacing (int font)

Returns the step between two lines of text for the specified font. If
this value equals font's height, then each next line is rendered right
after previous one with no space in between. If the line spacing is
lower than font's height, then the lines of text are partially
overlapping.

**NOTE:** this is the distance between the **top** of the first line and
the **top** of the next line, and **not** distance between bottom of
first line and top of next one. If you need to calculate the **gap**
between the lines, then subtract [font's
height](ags54.md#GetFontHeight) from the line spacing value.

Example:

    int h = GetFontHeight(eFontSpeech);
    int spacing = GetFontLineSpacing(eFontSpeech);
    int gap = spacing - h;

will calculate the gap between two lines of text, that are drawn using
speech font.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [GetFontHeight](ags54.md#GetFontHeight)

------------------------------------------------------------------------

[]()

### InputBox

*(Formerly known as global function InputBox, which is now obsolete)*

    static String Game.InputBox(string prompt)

Pops up a window asking the user to type in a string, with PROMPT as the
text in the window. Whatever they type in will be returned from this
function.

This command displays a very basic input box, mainly useful for
debugging purposes. Due to the size of the window, only small strings up
to about 20 characters can be typed in.

The recommended way to obtain user input is to create your own GUI with
a text box on it, which allows you full customization of the look of the
window.

**TIP:** If you add a '!' character to the start of the prompt, then a
Cancel button will be available in the input box. If the player presses
this Cancel button (or the ESC key), a blank string is returned.

Example:

    String name = Game.InputBox("!What is your name?");

will prompt the user for his name and store it in the string NAME. If
the user presses Cancel, the NAME string will be blank.

*See Also:* [String.AsInt](ags76.md#String.AsInt)

------------------------------------------------------------------------

[]()

### InventoryScreen

    InventoryScreen ()

This command is obsolete.

**This command was used for displaying a default inventory window in
previous versions of AGS, but is no longer supported.**

Instead of using this command, you should create your own Inventory GUI.

------------------------------------------------------------------------

[]()

### IsGamePaused

    IsGamePaused ()

Returns *true* if the game is currently paused, or *false* otherwise.
The game is paused when either the icon bar interface has been popped
up, or a "script-only" interface has been displayed with
GUI.Visible=true. While the game is paused, no animations or other
updates take place.

Example:

    if (IsGamePaused()) UnPauseGame();

will unpause the game if it's paused.

*See Also:* [GUI.Visible](ags55.md#GUI.Visible)

------------------------------------------------------------------------

[]()

### IsInterfaceEnabled

    IsInterfaceEnabled()

Returns 1 if the player interface is currently enabled, 0 if it is
disabled. The user interface is disabled while the cursor is set to the
Wait cursor - ie. while the character is performing a blocking Walk, or
other blocking action.

Example:

    if (IsInterfaceEnabled())
        DisableInterface();

will disable the user interface if it's enabled.

*See Also:* [DisableInterface](ags54.md#DisableInterface),
[EnableInterface](ags54.md#EnableInterface)

------------------------------------------------------------------------

[]()

### IsInteractionAvailable

    IsInteractionAvailable (int x, int y, int mode)

Checks whether there is an interaction defined for clicking on the
screen at (X,Y) in cursor mode MODE.

This function is very similar to Room.ProcessClick, except that rather
than carry out any interactions it encounters, it simply returns 1 if
something would have happened, or 0 if unhandled\_event would have been
run.

This is useful for enabling options on a verb-coin style GUI, for
example.

Example:

    if (IsInteractionAvailable(mouse.x,mouse.y, eModeLookat) == 0)
      Display("looking here would not do anything.");

*See Also:*
[InventoryItem.IsInteractionAvailable](ags64.md#InventoryItem.IsInteractionAvailable),
[Hotspot.IsInteractionAvailable](ags63.md#Hotspot.IsInteractionAvailable),
[Object.IsInteractionAvailable](ags68.md#Object.IsInteractionAvailable),
[Character.IsInteractionAvailable](ags47.md#Character.IsInteractionAvailable),
[Room.ProcessClick](ags73.md#Room.ProcessClick)

------------------------------------------------------------------------

[]()

### IsKeyPressed

    IsKeyPressed(eKeyCode)

Tests whether the supplied key on the keyboard is currently pressed down
or not. You could use this to move an object while the player holds an
arrow key down, for instance.

KEYCODE is one of the [ASCII codes](ags85.md#ASCIIcodes), with some
limitations: since it tests the raw state of the key, you CANNOT pass
the Ctrl+(A-Z) or Alt+(A-Z) codes (since they are key combinations). You
can, however, use some extra codes which are listed at the bottom of the
section.

Returns 1 if the key is currently pressed, 0 if not.

**NOTE:** The numeric keypad can have inconsistent keycodes between
IsKeyPressed and on\_key\_press. With IsKeyPressed, the numeric keypad
always uses keycodes in the 370-381 range. on\_key\_press, however,
passes different values if Num Lock is on since the key presses are
interpreted as the number key rather than the arrow key.

Example:

    if (IsKeyPressed(eKeyUpArrow) == 1)
      cEgo.Walk(cEgo.x, cEgo.y+3);

will move the character EGO upwards 3 pixels when the up arrow is
pressed.

*See Also:* [Mouse.IsButtonDown](ags66.md#Mouse.IsButtonDown)

------------------------------------------------------------------------

[]()

### IsPluginLoaded

    static bool Game.IsPluginLoaded(const string name)

Checks whether the plugin of the given *name* was present and loaded for
the game.

**IMPORTANT:** If the plugin exports its own script functions that you
used in your game script, and not found when the game is launched, then
the game won't start up at all, exiting with error. IsPluginLoaded may
therefore be useful to check for plugins that are not interacted with
from game script, but just run on their own.

Example:

    if (Game.IsPluginLoaded("my_plugin")) {
      Display("My plugin is found and running!");
    }

will display a message if plugin is present.

------------------------------------------------------------------------

[]()

### IsTimerExpired

    bool IsTimerExpired(int timer_id)

Checks whether the timer TIMER\_ID has expired. If the timeout set with
SetTimer has elapsed, returns *true*. Otherwise, returns *false*.

Note that this function will only return *true* once - after that, the
timer is placed into an OFF state where it will always return *false*
until restarted.

Example:

    if (IsTimerExpired(1)) {
      Display("Timer 1 expired");
    }

will display a message when timer 1 expires.

*See Also:* [SetTimer](ags54.md#SetTimer)

------------------------------------------------------------------------

[]()

### IsTranslationAvailable

    IsTranslationAvailable ()

Finds out whether the player is using a game translation or not.

Returns 1 if a translation is in use, 0 if not.

*See Also:* [GetTranslation](ags54.md#GetTranslation),
[Game.ChangeTranslation](ags54.md#Game.ChangeTranslation),
[Game.TranslationFilename](ags54.md#Game.TranslationFilename)

------------------------------------------------------------------------

[]()

### MoveCharacterToHotspot

**This function is now obsolete. Use Character.Walk instead**

    MoveCharacterToHotspot (CHARID, int hotspot)

Moves the character CHARID from its current location to the walk-to
point for the specified hotspot. If the hotspot has no walk-to point,
nothing happens.

This is a blocking call - control is not returned to the script until
the character has reached its destination.

Example:

    MoveCharacterToHotspot(EGO,6);

will move the character EGO to the hotspot's 6 "walk to point".

*See Also:* [Hotspot.WalkToX](ags63.md#Hotspot.WalkToX),
[Hotspot.WalkToY](ags63.md#Hotspot.WalkToY),
[Character.Walk](ags47.md#Character.Walk),
[MoveCharacterToObject](ags54.md#MoveCharacterToObject)

------------------------------------------------------------------------

[]()

### MoveCharacterToObject

**This function is now obsolete. Use Character.Walk instead**

    MoveCharacterToObject (CHARID, int object)

Moves the character CHARID from its current location to a position just
below the object OBJECT. This is useful for example, if you want the man
to pick up an object. This is a blocking call - control is not returned
to the script until the character has reached its destination.

Example:

    MoveCharacterToObject (EGO, 0);
    object[0].Visible = false;

Will move the character EGO below object number 0, then turn off object
0.

*See Also:* [Character.Walk](ags47.md#Character.Walk),
[MoveCharacterToHotspot](ags54.md#MoveCharacterToHotspot)

------------------------------------------------------------------------

[]()

### PauseGame

    PauseGame ()

Stops AGS processing character movement and animations. This has the
same effect on the game as happens when a modal GUI is popped up. Game
processing will not resume until you call the UnPauseGame function.

**NOTE:** When the game is paused, game cycles will continue to run but
no animations or movement will be performed, and timers will not count
down. Apart from that, your scripts will continue to run as normal.

**NOTE:** GUI button animations will not be paused by this command, so
that you can run animations on a pop-up GUI while the rest of the game
is paused.

Example:

    if (IsKeyPressed(32)==1) PauseGame();

will pause the game if the player presses the space bar

*See Also:* [UnPauseGame](ags54.md#UnPauseGame)

------------------------------------------------------------------------

[]()

### QuitGame

    QuitGame(int ask_first)

Exits the game and returns to the operating system.

If ASK\_FIRST is zero, it will exit immediately. If ASK\_FIRST is not
zero, it will first display a message box asking the user if they are
sure they want to quit.

Example:

    QuitGame(0);

will quit the game without asking the player to confirm.

*See Also:* [AbortGame](ags54.md#AbortGame)

------------------------------------------------------------------------

[]()

### Random

    Random (int max)

Returns a random number between 0 and MAX. This could be useful to do
various effects in your game. MAX must be a positive value in range
0-32767.

**NOTE:** Because of the way Random is implemented in AGS, the return
value will never be higher than 32767.

**NOTE:** The range returned is inclusive - ie. if you do Random(3);
then it can return 0, 1, 2 or 3.

Example:

    int ran=Random(2);
    if (ran==0) cEgo.ChangeRoom(1);
    else if (ran==1) cEgo.ChangeRoom(2);
    else cEgo.ChangeRoom(3);

will change the current room to room 1,2 or 3 depending on a random
result.

------------------------------------------------------------------------

[]()

### RestartGame

    RestartGame ()

Restarts the game from the beginning.

Example:

    if (IsKeyPressed(365) == 1) RestartGame();

will restart the game if the player presses the F7 key.

*SeeAlso:* [SetRestartPoint](ags54.md#SetRestartPoint)

------------------------------------------------------------------------

[]()

### RestoreGameDialog

    RestoreGameDialog ()

Displays the restore game dialog, where the player can select a
previously saved game position to restore.

The dialog is not displayed immediately; instead, it will be displayed
when the script function finishes executing.

Example:

    if (IsKeyPressed(363) == 1) RestoreGameDialog();

will bring up the restore game dialog if the player presses the F5 key.

*See Also:* [RestoreGameSlot](ags54.md#RestoreGameSlot),
[SaveGameDialog](ags54.md#SaveGameDialog)

------------------------------------------------------------------------

[]()

### RestoreGameSlot

    RestoreGameSlot (int slot)

Restores the game position saved into slot number SLOT. You might want
to use these specific slot functions if for example you only want to
allow the player to have one save game position rather than the usual
20. If this slot number does not exist, an error message is displayed to
the player but the game continues. To avoid the error, use the
GetSaveSlotDescription function to see if the position exists before
restoring it.

**NOTE:** The game will not be restored immediately; instead, it will be
restored when the script function finishes executing.

Example:

    RestoreGameSlot(30);

will restore game slot 30 if this slot number exists.

*See Also:*
[Game.GetSaveSlotDescription](ags54.md#Game.GetSaveSlotDescription),
[RestoreGameDialog](ags54.md#RestoreGameDialog),
[SaveGameSlot](ags54.md#SaveGameSlot)

------------------------------------------------------------------------

[]()

### RunAGSGame

    RunAGSGame (string filename, int mode, int data)

Quits the current game, and loads up FILENAME instead. FILENAME must be
an AGS game EXE or AC2GAME.AGS file, and it must be in the current
directory.

MODE specifies various options about how you want to run the game.
Currently the supported values are:

    0   Current game is completely exited, new game runs as if it had been launched separately
    1   GlobalInt values are preserved and are not set to 0 for the new game.

DATA allows you to pass an integer through to the next game. The value
you pass here will be accessible to the loaded game by it reading the
game.previous\_game\_data variable.

The save game slots are shared between the two games, and if you load a
save slot that was saved in the other game, it will automatically be
loaded.

Bear in mind that because the games must be in the same folder, they
will also share the audio.vox, speech.vox and so forth. This is a
limitation of this command.

**NOTE:** The game you run will be loaded at the same resolution and
colour depth as the current game; if you mismatch colour depths some
nasty results will occur.

**NOTE:** Make sure that the game you want to run has a filename of 8
characters or less, or this command will fail in the DOS engine.

**NOTE:** The game you want to launch must have been created with the
same point-version of AGS as the one you are launching it from. (version
2.xy - the X must be the same version between the two games).

Example:

    RunAGSGame ("MyGame.exe", 0, 51);

will run the MyGame game, passing it the value 51.

------------------------------------------------------------------------

[]()

### SaveGameDialog

    SaveGameDialog ()

Displays the save game dialog, where the player can save their current
game position. If they select to save, then the game position will be
saved.

**NOTE:** The dialog will not be displayed immediately; instead, it will
be shown when the script function finishes executing.

Example:

    if (keycode == 361) SaveGameDialog();

will bring up the save game dialog if the player presses the F3 key.

*See Also:* [RestoreGameDialog](ags54.md#RestoreGameDialog),
[SaveGameSlot](ags54.md#SaveGameSlot)

------------------------------------------------------------------------

[]()

### SaveGameSlot

    SaveGameSlot (int slot, string description)

Saves the current game position to the save game number specified by
SLOT, using DESCRIPTION as the textual description of the save position.
Be careful using this function, because you could overwrite one of the
player's save slots if you aren't careful.

The SaveGameDialog function uses slots numbered from 1 to 20, so if you
don't want to interfere with the player's saves, I would recommend
saving to slot numbers of 100 and above.

**NOTE:** The game will not be saved immediately; instead, it will be
saved when the script function finishes executing.

Example:

    SaveGameSlot(30, "save game");

will save the current game position to slot 30 with the description
"Save game".

*See Also:* [DeleteSaveSlot](ags54.md#DeleteSaveSlot),
[RestoreGameSlot](ags54.md#RestoreGameSlot),
[SaveGameDialog](ags54.md#SaveGameDialog)

------------------------------------------------------------------------

[]()

### SaveScreenShot

    SaveScreenShot (string filename)

Takes a screen capture and saves it to disk. The FILENAME must end in
either ".BMP" or ".PCX", as those are the types of files which can be
saved. Returns 1 if the shot was successfully saved, or 0 if an invalid
file extension was provided.

**NOTE:** The screenshot will be saved to the Saved Games folder.

**NOTE:** This command can be slow when using the Direct3D graphics
driver.

Example:

    String input = Game.InputBox("Type the filename:");
    input = input.Append(".pcx");
    SaveScreenShot(input);

will prompt the player for a filename and then save the screenshot with
the filename the player typed.

*See Also:*
[DynamicSprite.SaveToFile](ags52.md#DynamicSprite.SaveToFile)

------------------------------------------------------------------------

[]()

### SetAmbientLightLevel

    void SetAmbientTint(int light_level);

Sets an ambient light level that affects all objects and characters in
the room.

The light level is from **-100 to 100**, where 0 means that no
adjustment will be applied to sprites.

In 8-bit games you cannot use positive light level for brightening
effect, but you may still use negative values to produce darkening
effect.

To turn light level off, call this command again but pass the
*light\_level* as 0.

**NOTE:** This function overrides any specific region light levels or
tints on the screen, but does NOT override individual character and
object light levels.

**NOTE**: Setting an ambient light level will disable ambient RGB tint,
if there one was previously set.

Example:

    SetAmbientLightLevel(50);

will apply light level 50 to every character and object on screen (which
do not have individual light levels).

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [SetAmbientTint](ags54.md#SetAmbientTint),
[Character.SetLightLevel](ags47.md#Character.SetLightLevel),
[Object.SetLightLevel](ags68.md#Object.SetLightLevel),
[Region.LightLevel](ags72.md#Region.LightLevel)

------------------------------------------------------------------------

[]()

### SetAmbientTint

    SetAmbientTint(int red, int green, int blue, int saturation, int luminance)

Tints all objects and characters on the screen to (RED, GREEN, BLUE)
with SATURATION percent saturation.

This allows you to apply a global tint to everything on the screen. The
RED, GREEN and BLUE parameters are from 0-255, and specify the colour of
the tint.

The SATURATION parameter defines how much the tint is applied, and is
from 0-100. A saturation of 100 will completely re-colourize the sprites
to the supplied colour, and a saturation of 1 will give them a very
minor tint towards the specified colour.

The LUMINANCE parameter allows you to adjust the brightness of the
sprites at the same time. It ranges from 0-100. Passing 100 will draw
the sprites at normal brightness. Lower numbers will darken the images
accordingly, right down to 0 which will draw everything black.

The tint applied by this function is global. To turn it off, call this
command again but pass the saturation as 0.

**NOTE:** This function only works in hi-colour games and with hi-colour
sprites.

**NOTE:** This function overrides any specific region light levels or
tints on the screen.

Example:

    SetAmbientTint(0, 0, 250, 30, 100);

will tint everything on the screen with a hint of blue.

*See Also:* [SetAmbientLightLevel](ags54.md#SetAmbientLightLevel),
[Character.Tint](ags47.md#Character.Tint),
[Object.Tint](ags68.md#Object.Tint),
[Region.Tint](ags72.md#Region.Tint)

------------------------------------------------------------------------

[]()

### SetGameOption

    SetGameOption (option, int value)

Changes one of the game options, originally set in the AGS Editor Game
Settings pane.

OPTION specifies which option to change, and VALUE is its new value.
Valid OPTIONs are listed below:

  -------------------------- ------------------------------------------------------------------------
  **Option**                 **Values**
  OPT\_WALKONLOOK            Walk to hotspot in look mode (0 or 1)
  OPT\_DIALOGOPTIONSGUI      Dialog options on GUI (0=none, otherwise GUI name/number)
  OPT\_DIALOGOPTIONSGAP      Pixel gap between options (0=none, otherwise num pixels)
  OPT\_WHENGUIDISABLED       When GUI is disabled, 0=grey out, 1=go black, 2=unchanged, 3=turn off
  OPT\_ALWAYSSPEECH          Always display text as speech (0 or 1)
  OPT\_PIXELPERFECT          Pixel-perfect click detection (0 or 1)
  OPT\_NOWALKMODE            Don't automatically move character in Walk mode (0 or 1)
  OPT\_FIXEDINVCURSOR        Don't use inventory graphics as cursors (0 or 1)
  OPT\_DONTLOSEINV           Don't automatically lose inventory items (0 or 1)
  OPT\_TURNBEFOREWALK        Characters turn before walking (0 or 1)
  OPT\_HANDLEINVCLICKS       Handle inventory clicks in script (0 or 1)
  OPT\_MOUSEWHEEL            Enable mouse wheel support (0 or 1)
  OPT\_DIALOGNUMBERED        Number dialog options (-1=disabled, 0=shortcuts only, 1=drawn numbers)
  OPT\_DIALOGUPWARDS         Dialog options go upwards on GUI (0 or 1)
  OPT\_CROSSFADEMUSIC        Crossfade music tracks (0=no, 1=slow, 2=slowish, 3=medium, 4=fast)
  OPT\_ANTIALIASFONTS        Anti-alias rendering of TTF fonts (0 or 1)
  OPT\_THOUGHTGUI            Thought uses bubble GUI (GUI name/number)
  OPT\_TURNWHENFACING        Characters turn to face direction (0 or 1)
  OPT\_LIPSYNCTEXT           Whether lip-sync text reading is enabled (0 or 1)
  OPT\_RIGHTTOLEFT           Right-to-left text writing (0 or 1)
  OPT\_MULTIPLEINV           Display multiple inv items multiple times (0 or 1)
  OPT\_SAVEGAMESCREENSHOTS   Save screenshots into save games (0 or 1)
  OPT\_PORTRAITPOSITION      Speech portrait side (0=left, 1=right, 2=alternate, 3=xpos)
  -------------------------- ------------------------------------------------------------------------

The game settings which are not listed here either have a separate
command to change them (such as Speech.Style), or simply cannot be
changed at run-time.

This command returns the old value of the setting.

Example:

    SetGameOption (OPT_PIXELPERFECT, 0);

will disable pixel-perfect click detection.

*See Also:* [GetGameOption](ags54.md#GetGameOption),
[Speech.Style](ags75.md#Speech.Style),
[SetTextWindowGUI](ags54.md#SetTextWindowGUI)

------------------------------------------------------------------------

[]()

### SetGameSpeed

    SetGameSpeed (int new_speed)

Sets the maximum game frame rate to NEW\_SPEED frames per second, or as
near as possible to that speed. The default frame rate is 40 fps, but
you can speed up or slow down the game by using this function. Note that
this speed is also the rate at which the Repeatedly\_Execute functions
are triggered.

The NEW\_SPEED must lie between 10 and 1000. If it does not, it will be
rounded to 10 or 1000. Note that if you set a speed which the player's
computer cannot handle (for example, a 486 will not be able to manage 80
fps), then it will go as fast as possible.

NOTE: Because the mouse cursor is repainted at the game frame rate, at
very low speeds, like 10 to 20 fps, the mouse will appear to be jumpy
and not very responsive.

NOTE: If you set the [System.VSync](ags77.md#System.VSync) property to
*true*, the game speed will be capped at the screen's refresh rate, so
you will be unable to set it higher than 60-85 (depending on the
player's screen refresh).

Example:

    SetGameSpeed(80);

will set the game speed to 80.

*See Also:* [GetGameSpeed](ags54.md#GetGameSpeed)

------------------------------------------------------------------------

[]()

### SetGlobalInt

    SetGlobalInt (int index, int value)

Sets the global int INDEX to VALUE. You can then retrieve this value
from any other script using GetGlobalInt.

There are 500 available global variables, from index 0 to 499.

**NOTE:** GlobalInts are now considered obsolete. Consider using [global
variables](ags19.md#GlobalVariables) instead, which allow you to name
the variables.

Example:

    SetGlobalInt(10,1);

will set the Global Integer 10 to 1.

*See Also:* [GetGlobalInt](ags54.md#GetGlobalInt)

------------------------------------------------------------------------

[]()

### SetGraphicalVariable

    SetGraphicalVariable(string variable_name, int value);

Sets the interaction editor VARIABLE\_NAME variable to VALUE. This
allows your script to change the values of variables set in the
interaction editor.

**NOTE:** This command is obsolete, and is only provided for backwards
compatibility with AGS 2.x. When writing new code, use [global
variables](ags19.md#GlobalVariables) instead.

Example:

    SetGraphicalVariable("climbed rock", 1);

will set the interaction editor "climbed rock" variable to 1.

*See Also:* [GetGraphicalVariable](ags54.md#GetGraphicalVariable)

------------------------------------------------------------------------

[]()

### SetMultitaskingMode

    SetMultitaskingMode (int mode)

Allows you to set what happens when the user switches away from your
game.

If MODE is 0 (the default), then if the user Alt+Tabs out of your game,
or clicks on another window, the game will pause and not continue until
they switch back into the game.

If MODE is 1, then the game will continue to run in the background if
the user switches away (useful if, for example, you are just making some
sort of jukebox music player with AGS).

Note that mode 1 does not work with some graphics cards in full-screen
mode, so you should only rely on it working when your game is run in
windowed mode.

**Cross-Platform Support**

Windows: **Yes**\
MS-DOS: **No**\
Linux: **Yes**\
MacOS: **Yes**

Example:

    SetMultitaskingMode (1);

will mean that the game continues to run in the background.

------------------------------------------------------------------------

[]()

### SetRestartPoint

    SetRestartPoint ()

Changes the game restart point to the current position. This means that
from now on, if the player chooses the Restart Game option, it will
return here.

This function is useful if the default restart point doesn't work
properly in your game - just use this function to move it.

**NOTE:** The restart point cannot be set while a script is running --
therefore, when you call this it will actually set the restart point at
the next game loop where there is not a blocking script running in the
background.

*SeeAlso:* [RestartGame](ags54.md#RestartGame)

------------------------------------------------------------------------

[]()

### SetSaveGameDirectory

    static bool Game.SetSaveGameDirectory(string directory)

Changes the directory where save game files are stored to the supplied
*directory*. If the directory does not exist, AGS will attempt to create
it.

You cannot use fully qualified directories with this command (eg.
`C:\Games\Cool\Saves`), because the player might have installed your
game to any folder, and they might not be running Windows.

Therefore, only two types of path are supported:\
1. Relative paths (eg. "Saves"). This will create a subfolder inside
**default game save folder**\
2. The special tag `$MYDOCS$` which allows you to explicitly create a
different folder for your save games inside the user's documents folder.

The actual folder referenced with `$MYDOCS$` is different on every
platform: Windows XP: "My Documents"\
Windows Vista and later: "Saved Games"\
Linux: `$XDG_DATA_HOME`/ags\
MacOS: game installation folder.

Returns *true* if the save game directory has been changed successfully;
*false* if not.

**NOTE:** We advise you against using this function without strong need.
In the most cases setting the "Save games folder name" property in the
General Settings of the editor should be sufficient.

Example:

    Game.SetSaveGameDirectory("$MYDOCS$/My Cool Game Saves");

will change the save game directory to "My Cool Game Saves" in My
Documents, and create the folder if it does not exist (might be useful
to do this in game\_start).

*See Also:*
[ListBox.FillSaveGameList](ags60.md#ListBox.FillSaveGameList),
[RestoreGameDialog](ags54.md#RestoreGameDialog)

------------------------------------------------------------------------

[]()

### SetTextWindowGUI

    SetTextWindowGUI (int gui)

Changes the GUI used for text windows to the specified GUI. This
overrides the "text windows use GUI" setting in the editor.

You can pass -1 as the GUI number to go back to using the default white
text box.

Example:

    SetTextWindowGUI (4);

will change Textwindow GUI 4 to be used for displaying text windows in
future.

------------------------------------------------------------------------

[]()

### SetTimer

    SetTimer (int timer_id, int timeout)

Starts timer TIMER\_ID ticking - it will tick once every game loop
(normally 40 times per second), until TIMEOUT loops, after which it will
stop. You can check whether the timer has finished by calling the
IsTimerExpired function.

Pass TIMEOUT as 0 to disable a currently running timer.

There are 20 available timers, with TIMER\_IDs from 1 to 20.

**NOTE:** the timer will not tick while the game is paused.

Example:

    SetTimer(1,1000);

will set the timer 1 to expire after 1000 game cycles.

*See Also:* [IsTimerExpired](ags54.md#IsTimerExpired)

------------------------------------------------------------------------

[]()

### SkipUntilCharacterStops

    SkipUntilCharacterStops(CHARID)

Skips through the game until the specified character stops walking, a
blocking script runs, or a message box is displayed.

The purpose of this command is to mimic the functionality in games such
as The Longest Journey, where the player can press ESC to instantly get
the character to its destination. It serves as a handy feature to allow
you to give the player character a relatively slow walking speed,
without annoying the player by making them wait ages just to get from A
to B.

If the specified character is not moving when this function is called,
nothing happens.

Example: (in on\_key\_press)

    if (keycode == eKeyEscape) SkipUntilCharacterStops(EGO);

This means that if the player presses ESC, the game will skip ahead
until EGO finishes moving, or is interrupted by a Display command or a
blocking cutscene.

*See Also:* [StartCutscene](ags54.md#StartCutscene)

------------------------------------------------------------------------

[]()

### StartCutscene

    StartCutscene(CutsceneSkipType)

Marks the start of a cutscene. Once your script passes this point, the
player can choose to skip a portion by pressing a key or the mouse
button. This is useful for things like introduction sequences, where you
want the player to be able to skip over an intro that they've seen
before.

The CutsceneSkipType determines how they can skip the cutscene:

    eSkipESCOnly
      by pressing ESC only
    eSkipAnyKey
      by pressing any key
    eSkipMouseClick
      by clicking a mouse button
    eSkipAnyKeyOrMouseClick
      by pressing any key or clicking a mouse button
    eSkipESCOrRightButton
      by pressing ESC or clicking the right mouse button

You need to mark the end of the cutscene with the EndCutscene command.

Be **very careful** with where you place the corresponding EndCutscene
command. The script **must** pass through EndCutscene in its normal run
in order for the skipping to work - otherwise, when the player presses
ESC the game could appear to hang.

*See Also:* [EndCutscene](ags54.md#EndCutscene),
[SkipUntilCharacterStops](ags54.md#SkipUntilCharacterStops),
[Game.InSkippableCutscene](ags54.md#Game.InSkippableCutscene),
[Game.SkippingCutscene](ags54.md#Game.SkippingCutscene)

------------------------------------------------------------------------

[]()

### UpdateInventory

    UpdateInventory ()

Updates the on-screen inventory display. If you add or remove inventory
items manually (ie. by using the InventoryQuantity array rather than the
AddInventory/LoseInventory functions), the display may not get updated.
In this case call this function after making your changes, to update
what is displayed to the player.

Note that using this function will reset the order that items are
displayed in the inventory window to the same order they were created in
the editor.

*See Also:* [Character.AddInventory](ags47.md#Character.AddInventory),
[Character.LoseInventory](ags47.md#Character.LoseInventory),
[Character.InventoryQuantity](ags47.md#Character.InventoryQuantity)

------------------------------------------------------------------------

[]()

### UnPauseGame

    UnPauseGame ()

Resumes the game.

Example:

    if (IsGamePaused() == 1)
        UnPauseGame();

will unpause the game if it is paused.

*See Also:* [PauseGame](ags54.md#PauseGame)

------------------------------------------------------------------------

[]()

### Wait

    Wait (int time)

Pauses the script and lets the game continue for TIME loops. There are
normally 40 loops/second (unless you change it with SetGameSpeed), so
using a value of 80 will wait 2 seconds. Note that no other scripts can
run while the Wait function is in the background.

Example:

    cEgo.Walk(120, 140, eBlock, eWalkableAreas);
    Wait(80);
    cEgo.FaceLocation(1000,100);

will move the character EGO to 120,140, wait until he gets there then
wait for 2 seconds (80 game cycles) and then face right.

*See Also:* [WaitKey](ags54.md#WaitKey),
[WaitMouseKey](ags54.md#WaitMouseKey)

------------------------------------------------------------------------

[]()

### WaitKey

    WaitKey (int time)

Pauses the script and lets the game continue until EITHER:

\(a) TIME loops have elapsed, or

\(b) the player presses a key

Returns 0 if the time elapsed, or 1 if the player interrupted it.

Example:

    WaitKey(200);

will pause the script and wait until 5 seconds have passed or the player
presses a key.

*See Also:* [Wait](ags54.md#Wait),
[WaitMouseKey](ags54.md#WaitMouseKey)

------------------------------------------------------------------------

[]()

### WaitMouseKey

    WaitMouseKey (int time)

Pauses the script and lets the game continue until EITHER:

\(a) TIME loops have elapsed, or

\(b) the player presses a key, or

\(c) the player clicks a mouse button

Returns 0 if the time elapsed, or 1 if the player interrupted it.

Example:

    WaitMouseKey(200);

will pause the script and wait until 5 seconds have passed or the player
presses a key or clicks the mouse.

*See Also:* [Wait](ags54.md#Wait), [WaitKey](ags54.md#WaitKey)

------------------------------------------------------------------------

[]()

### AudioClipCount property

    readonly static int Game.AudioClipCount

Returns the number of audio clips in the game.

This is useful for script modules if you need to iterate through all the
audio clips for some reason.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Game.AudioClips](ags54.md#Game.AudioClips)

------------------------------------------------------------------------

[]()

### AudioClips property

    readonly static int Game.AudioClips[int slot]

Returns the AudioClip\* pointer by its index in game resources.

Example:

    int i = 0;
    int music_count = 0;
    while (i < Game.AudioClipCount)
    {
      if (Game.AudioClips[i].Type == eAudioTypeMusic)
        music_count++;
      i++;
    }
    Display("We have %d musical clips in our game", music_count);

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Game.AudioClipCount](ags54.md#Game.AudioClipCount)

------------------------------------------------------------------------

[]()

### CharacterCount property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.CharacterCount

Returns the number of characters in the game.

This is useful for script modules if you need to iterate through all the
characters for some reason.

Example:

    Display("The game has %d characters.", Game.CharacterCount);

------------------------------------------------------------------------

[]()

### DialogCount property

    readonly static int Game.DialogCount

Returns the number of dialogs in the game.

This is useful for script modules if you need to iterate through all the
dialogs for some reason. Valid dialogs are numbered from 0 to
DialogCount - 1.

Example:

    Display("The game has %d dialogs.", Game.DialogCount);

*Compatibility:* Supported by **AGS 3.0.2** and later versions.

------------------------------------------------------------------------

[]()

### FileName property

    readonly static String Game.FileName

Gets the filename that the game is running from. This will usually be
the name of the EXE file, but could also be "ac2game.dat" if you are
just running the game using ACWIN.EXE.

Example:

    Display("The main game file is: %s", Game.FileName);

will display the game filename.

*See Also:* [Game.Name](ags54.md#Game.Name)

------------------------------------------------------------------------

[]()

### FontCount property

    readonly static int Game.FontCount

Returns the number of fonts in the game.

This is useful for script modules if you need to iterate through all the
fonts for some reason.

Example:

    Display("The game has %d fonts.", Game.FontCount);

------------------------------------------------------------------------

[]()

### GlobalMessages property

*(Formerly known as global function GetMessageText, which is now
obsolete)*

    readonly static String Game.GlobalMessages[int message]

Gets the text of the specified global message. The message number is one
of the global message numbers from 500 to 999.

If an invalid message number is supplied, *null* will be returned.
Otherwise, the message contents will be returned.

**NOTE:** Global Messages were a feature of AGS 2.x and are now
obsolete. You will not need to use this property in new games.

Example:

    String message = Game.GlobalMessages[997];
    Display("Global message 997 says: %s", message);

will display global message 997.

------------------------------------------------------------------------

[]()

### GlobalStrings property

*(Formerly known as GetGlobalString, which is now obsolete)*\
*(Formerly known as SetGlobalString, which is now obsolete)*

    static String Game.GlobalStrings[index]

Gets/sets global string *index*. Global strings provide you with an easy
way to share string variables between scripts. There are 50 available
global strings, with *index* values from 0 to 49.

Example:

    Game.GlobalStrings[15] = "Joe";
    Display("Global string 15 is now: %s", Game.GlobalStrings[15]);

will set global string 15 to contain "Joe".

*See Also:* [GetGlobalInt](ags54.md#GetGlobalInt),
[SetGlobalInt](ags54.md#SetGlobalInt)

------------------------------------------------------------------------

[]()

### GUICount property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.GUICount

Returns the number of GUIs in the game.

This is useful for script modules if you need to iterate through all the
GUIs for some reason. Valid GUIs are numbered from 0 to GUICount minus
1.

Example:

    Display("The game has %d GUIs.", Game.GUICount);

------------------------------------------------------------------------

[]()

### IgnoreUserInputAfterTextTimeoutMs property

    static int Game.IgnoreUserInputAfterTextTimeoutMs;

Gets/sets the length of time for which user input is ignored after some
text is automatically removed from the screen.

When AGS is configured to automatically remove text after a certain time
on the screen, sometimes the player might try to manually skip the text
by pressing a key just as it is removed automatically, and thus they end
up skipping the next text line by accident. This property is designed to
eliminate this problem.

This property is specified in milliseconds (1000 = 1 second), and is set
to 500 by default.

Example:

    Game.IgnoreUserInputAfterTextTimeoutMs = 1000;

will tell AGS to ignore mouse clicks and key presses for 1 second after
text is automatically removed from the screen.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:*
[Game.MinimumTextDisplayTimeMs](ags54.md#Game.MinimumTextDisplayTimeMs),
[Game.TextReadingSpeed](ags54.md#Game.TextReadingSpeed),
[Speech.SkipStyle](ags75.md#Speech.SkipStyle)

------------------------------------------------------------------------

[]()

### InSkippableCutscene property

*(Formerly known as game.in\_cutscene, which is now obsolete)*

    static bool Game.InSkippableCutscene

Returns whether the game is currently between a StartCutscene and
EndCutscene, and therefore whether the player is able to skip over this
part of the game.

When the player chooses to skip a cutscene all of the script code is run
as usual, but any blocking commands are run through without the usual
game cycle delays. Therefore, you should never normally need to use this
property since cutscenes should all be handled automatically, but it
could be useful for script modules.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example below.

Example:

    if (Game.InSkippableCutscene)
    {
      Display("The player might never see this message!");
    }

will display a message if we are within a cutscene

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [StartCutscene](ags54.md#StartCutscene),
[EndCutscene](ags54.md#EndCutscene),
[Game.SkippingCutscene](ags54.md#Game.SkippingCutscene)

------------------------------------------------------------------------

[]()

### InventoryItemCount property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.InventoryItemCount

Returns the number of inventory items in the game. This is the total
number of items that you created in the Inventory Items pane of the
editor, not how many the player is currently carrying.

Example:

    Display("The game has %d inventory items.", Game.InventoryItemCount);

------------------------------------------------------------------------

[]()

### MinimumTextDisplayTimeMs property

    static int Game.MinimumTextDisplayTimeMs;

Gets/sets the minimum length of time that text is displayed on the
screen. AGS automatically adjusts the length of time that text is
displayed for depending on the length of the text (and you can customize
this calculation with
[Game.TextReadingSpeed](ags54.md#Game.TextReadingSpeed)), but for very
short statements like "Hi!", you might want the text to remain for
longer.

This property is specified in milliseconds (1000 = 1 second), and is set
to 1000 by default.

**NOTE:** This property is ignored if lip-sync is enabled, or if the
General Settings are set not to allow text to be automatically removed.

Example:

    Game.MinimumTextDisplayTimeMs = 2000;

will ensure that even the shortest "Hi!" text line will be displayed for
at least 2 seconds

*Compatibility:* Supported by **AGS 3.1.2** and later versions.

*See Also:*
[Character.SpeechAnimationDelay](ags47.md#Character.SpeechAnimationDelay),
[Game.IgnoreUserInputAfterTextTimeoutMs](ags54.md#Game.IgnoreUserInputAfterTextTimeoutMs)
[Game.TextReadingSpeed](ags54.md#Game.TextReadingSpeed)

------------------------------------------------------------------------

[]()

### MouseCursorCount property

    readonly static int Game.MouseCursorCount

Returns the number of mouse cursors in the game.

This is useful for script modules if you need to iterate through all the
cursors for some reason.

Example:

    Display("The game has %d cursors.", Game.MouseCursorCount);

------------------------------------------------------------------------

[]()

### Name property (game)

    static String Game.Name

Gets/sets the game's name. This is initially set in the General Settings
pane of the editor, but you can change it at run-time in order to change
the window title of your game.

Example:

    Display("The game name is: %s", Game.Name);

will display the game name.

*See Also:* [Game.FileName](ags54.md#Game.FileName)

------------------------------------------------------------------------

[]()

### NormalFont property

*(Formerly known as global function SetNormalFont, which is now
obsolete)*

    static FontType Game.NormalFont

Gets/sets the font used for all in-game text, except speech. The font
number must be a valid number from the Fonts pane of the editor.

More specifically, AGS uses the Normal Font for the following:

-   Display
-   DisplayTopBar
-   dialog options text
-   the built-in save and restore dialogs

The Normal Font is font 0 by default.

Example:

    Game.NormalFont = eFontSpecial;

will change the normal font to the font "Special".

*See Also:* [Game.SpeechFont](ags54.md#Game.SpeechFont)

------------------------------------------------------------------------

[]()

### SkippingCutscene property

*(Formerly known as game.skipping\_cutscene, which is now obsolete)*

    static bool Game.SkippingCutscene

Returns whether the player has elected to skip the current cutscene.
This will return true if the game is between a StartCutscene and
EndCutscene command, and the player has chosen to skip it.

Although cutscene skipping is handled automatically by AGS, you can use
this property to optimise the process by bypassing any lengthy blocks of
code that don't need to be run if the cutscene is being skipped over.

**NOTE:** This is a static function, and thus need to be called with
`Game.` in front of it. See the example below.

Example:

    if (!Game.SkippingCutscene)
    {
      aScaryMusic.Play();
      Wait(100);
      Game.StopAudio();
    }

will only attempt to play the music if the player is not skipping the
cutscene.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [StartCutscene](ags54.md#StartCutscene),
[EndCutscene](ags54.md#EndCutscene),
[Game.InSkippableCutscene](ags54.md#Game.InSkippableCutscene)

------------------------------------------------------------------------

[]()

### SpeechFont property

*(Formerly known as global function SetSpeechFont, which is now
obsolete)*

    static FontType Game.SpeechFont;

Gets/sets the font used for character speech. The font number you supply
must be a valid number from the Fonts pane of the editor.

The Speech Font is font 1 by default.

Example:

    Game.SpeechFont = eFontStandard;

will change the speech font to "Standard".

*See Also:* [Game.NormalFont](ags54.md#Game.NormalFont)

------------------------------------------------------------------------

[]()

### SpriteHeight property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.SpriteHeight[int slot]

Returns the height of the specified sprite.

The height will be returned in the usual 320x200-resolution
co-ordinates. If an invalid sprite slot is supplied, 0 will be returned.

Example:

    Display("Object 0's sprite is sized %d x %d.", Game.SpriteWidth[object[0].Graphic],
                                                   Game.SpriteHeight[object[0].Graphic]);

*See Also:* [Game.SpriteWidth](ags54.md#Game.SpriteWidth)

------------------------------------------------------------------------

[]()

### SpriteWidth property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.SpriteWidth[int slot]

Returns the width of the specified sprite.

The width will be returned in the usual 320x200-resolution co-ordinates.
If an invalid sprite slot is supplied, 0 will be returned.

Example:

    Display("Object 0's sprite is sized %d x %d.", Game.SpriteWidth[object[0].Graphic],
                                                   Game.SpriteHeight[object[0].Graphic]);

*See Also:* [Game.SpriteHeight](ags54.md#Game.SpriteHeight)

------------------------------------------------------------------------

[]()

### TextReadingSpeed property

*(Formerly known as game.text\_speed, which is now obsolete)*

    static int Game.TextReadingSpeed;

Gets/sets the speed at which AGS assumes the player can read text, and
therefore how long speech stays on the screen before it is automatically
removed.

Specifically, the TextReadingSpeed is the number of characters of text
that the player can read in a second. It is 15 by default. A higher
number will therefore lead to the text being removed more quickly.

It is useful to link this setting to a GUI Slider on some sort of
Control Panel GUI so that the player can adjust it depending on their
reading speed.

**NOTE:** This property is ignored if lip-sync is enabled, or if the
General Settings are set not to allow text to be automatically removed.

Example:

    Game.TextReadingSpeed = 7;

sets the text reading speed to half the default, which will leave speech
on-screen for twice as long as usual.

*Compatibility:* Supported by **AGS 3.1.2** and later versions.

*See Also:*
[Character.SpeechAnimationDelay](ags47.md#Character.SpeechAnimationDelay),
[Game.MinimumTextDisplayTimeMs](ags54.md#Game.MinimumTextDisplayTimeMs),
[Speech.SkipStyle](ags75.md#Speech.SkipStyle)

------------------------------------------------------------------------

[]()

### TranslationFilename property

*(Formerly known as GetTranslationName, which is now obsolete)*

    readonly static String Game.TranslationFilename;

Gets the name of the current translation filename (without the ".tra"
extension). This may be useful if you want to use a different graphic
somewhere depending on which translation is being used.

If no translation is in use, a blank string is returned.

Example:

    if (Game.TranslationFilename == "German") {
      Display("You are using the German translation.");
    }

*See Also:* [Game.ChangeTranslation](ags54.md#Game.ChangeTranslation),
[IsTranslationAvailable](ags54.md#IsTranslationAvailable)

------------------------------------------------------------------------

[]()

### UseNativeCoordinates property

    readonly static bool Game.UseNativeCoordinates

Returns whether the game is using native co-ordinates. If native
co-ordinates are in use, then all X, Y, Top, Bottom, Width and Height
variables in the game will be expected to reflect the resolution of the
game.

If this is *false*, then the game is operating in backwards-compatible
mode where all co-ordinates are low-res.

If the game resolution is 320x200 or 320x240, this setting has no
effect.

This property is read-only; it is not possible to change this setting at
run-time.

Example:

    if (Game.UseNativeCoordinates)
    {
      Display("The player is at %d, %d -- REALLY!", player.x, player.y);
    }
    else
    {
      Display("The player is at %d, %d in the old-school system", player.x, player.y);
    }

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

------------------------------------------------------------------------

[]()

### ViewCount property

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Game.ViewCount

Returns the number of views in the game.

This is useful for script modules if you need to iterate through all the
views for some reason. Valid views are numbered from 1 to ViewCount.

Example:

    Display("The game has %d views.", Game.ViewCount);
