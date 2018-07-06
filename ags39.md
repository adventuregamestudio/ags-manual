[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags38.md#ExtenderFunctions)
[![Next](forward.gif)](ags40.md#TextScriptEvents)

------------------------------------------------------------------------

Game variables
--------------

The following variables are available to your script. They allow you to
do various tweaks to the engine at run-time.

Names in **bold** are **read-only variables** and should NOT be modified
by the script.

All the following variables are `int` variables.

  ------------------------------------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  game.abort\_key                                  The keycode for Abort Game, which allows the you to quit even if your script is stuck. Default 324 (Alt+X).

  game.ambient\_sounds\_persist                    If 0 (default), ambient sounds are stopped on room change. Set to 1 to tell AGS to leave ambient sounds playing when going to a new room.

  game.anim\_background\_speed                     The current room's animating background speed - same values as in editor.

  game.auto\_use\_walkto\_points                   Default 1; set to 0 to stop AGS automatically using hotspot walk-to points.

  game.bgspeech\_game\_speed                       If 0 (default), background speech stays on the screen for the same amount of time, no matter what the game speed. If 1, the amount of time it stays is relative to the game speed.

  game.bgspeech\_stay\_on\_display                 If 0 (default), background speech is removed when a Say command happens; if 1, it isn't.

  game.close\_mouth\_end\_speech\_time             At the end of speech text, the speech animation will stop for this number of game loops. Default 10. No affect in voice mode.

  game.debug\_mode                                 Whether we are in debug mode or not.

  game.dialog\_options\_highlight\_color           Color used to draw the active (selected) dialog option

  game.dialog\_options\_x                          Offset into dialog options GUI to compensate for borders

  game.dialog\_options\_y                          Offset into dialog options GUI to compensate for borders

  game.disable\_antialiasing                       Set to 1 to disable smoothing of scaled characters, overriding the user's choice in Setup. Default 0.

  game.following\_room\_timer                      How long to wait before following char emerges in new room, default 150. (higher is longer).

  game.keep\_screen\_during\_instant\_transition   Normally the Instant transition blacks the screen in 8-bit colour modes, to avoid strange palette effects. However you can set this to 1 to prevent it doing so.

  **game.inv\_activated**                          Inventory item that the player last clicked on. Useful for unhandled\_event.

  game.inventory\_greys\_out                       Set to 1 to make inventory controls grey out when GUI disabled is set to "GUIs Grey Out"

  game.lipsync\_speed                              Similar to Game.TextReadingSpeed, but this determines how quickly the text is 'read' out by the mouth moving. You should normally only set this faster than text\_speed, otherwise the reading will get cut off when the text times out. Default 15.

  game.max\_dialogoption\_width                    Maximum width of textwindow-based dialog options box. Default 180.

  game.min\_dialogoption\_width                    Minimum width of textwindow-based dialog options box. Default 0.

  game.narrator\_speech                            Which character ID to use for voice speech within Display() command. Default initial player character. You can also use NARRATOR which uses 'NARR' prefix - special narrator character.

  game.no\_textbg\_when\_voice                     Normally 0. If 1, and the Sierra-style With Background speech style is in use, will change to the Sierra-style (No Bg) if a voice speech line is present.

  game.read\_dialog\_option\_color                 By default, -1. You can set this to a colour number, in which case dialog options that the player has selected before will be displayed in this colour.

  game.roomscript\_finished                        The on\_call function has completed executing. (See [CallRoomScript](ags54.md#CallRoomScript))

  **game.score**                                   The player's score. To modify the score, use the GiveScore script function.

  game.score\_sound                                Sound effect to play when the player gets points, originally set in the editor.

  game.screenshot\_height                          The height of screenshot images when saved into save games. The largest you can have is the full screen size (320x200), which gives the highest quality but the largest size save game files. The default is 160x100.

  game.screenshot\_width                           The width of screenshot images when saved into save games.

  game.show\_single\_dialog\_option                If only a single dialog option is available, show it anyway (default=0)

  game.sierra\_inv\_color                          The background color of the sierra-style inventory.

  game.skip\_display                               Setting for how Display() messages are skipped; valid values are same as for Speech.SkipStyle (default 3).

  game.skip\_speech\_specific\_key                 Default 0. You can set it to a keycode, in which case only that key can skip speech text.

  game.speech\_bubble\_width                       Maximum width of the thought bubble text window (default 100)

  game.speech\_text\_align                         Sets how text in Lucasarts-style speech is aligned. Same possible values as game.text\_align, default eAlignCentre

  game.speech\_text\_gui                           The textwindow GUI number used for sierra-style speech.

  game.text\_align                                 Sets how text in message boxes and Sierra-style speech is aligned:\
                                                   eAlignLeft: text aligned to left within message box (default)\
                                                   eAlignCentre: text is centred within the message box\
                                                   eAlignRight: text is right-aligned within the message box\
                                                   These options do not affect Lucasarts-style speech, which is always centred.

  game.text\_shadow\_color                         Color used for speech text shadow (default 16).

  game.top\_bar\_XXXX                              Customizations for [DisplayTopBar](ags78.md#DisplayTopBar), see link for details

  game.total\_score                                Maximum possible score, initially set in the editor.

  game.used\_mode                                  Cursor mode used with last click (use with "any click" events to find out which mode was used)

  **mouse.x**                                      Mouse X co-ordinate when the last game loop was run (320-res)

  **mouse.y**                                      Mouse Y co-ordinate when the last game loop was run (320-res)

  palette\[SLOT\].r                                The red component (0-63) of palette slot SLOT

  palette\[SLOT\].g                                The green component (0-63) of palette slot SLOT

  palette\[SLOT\].b                                The blue component (0-63) of palette slot SLOT

  player.\[x,y,name,...\]                          Alias to the current player character.
  ------------------------------------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


