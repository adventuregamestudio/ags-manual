Game variables
--------------

The following variables are available to your script. They allow you to
do various tweaks to the engine at run-time.

Names in **bold** are **read-only variables** and should NOT be modified
by the script.

All the following variables are `int` variables.

**variable** | **description**
--- | ---
game.abort_key | The keycode for Abort Game, which allows the you to quit even if your script is stuck. Default 324 (Alt+X).
game.ambient_sounds_persist | If 0 (default), ambient sounds are stopped on room change. Set to 1 to tell AGS to leave ambient sounds playing when going to a new room.
game.anim_background_speed | The current room's animating background speed - same values as in editor.
game.auto_use_walkto_points | Default 1; set to 0 to stop AGS automatically using hotspot walk-to points.
game.bgspeech_game_speed | If 0 (default), background speech stays on the screen for the same amount of time, no matter what the game speed. If 1, the amount of time it stays is relative to the game speed.
game.bgspeech_stay_on_display | If 0 (default), background speech is removed when a Say command happens; if 1, it isn't.
game.close_mouth_end_speech_time | At the end of speech text, the speech animation will stop for this number of game loops. Default 10. No affect in voice mode.
game.debug_mode | Whether we are in debug mode or not.
game.dialog_options_highlight_color | Color used to draw the active (selected) dialog option
game.dialog_options_x | Offset into dialog options GUI to compensate for borders
game.dialog_options_y | Offset into dialog options GUI to compensate for borders
game.disable_antialiasing | Set to 1 to disable smoothing of scaled characters, overriding the user's choice in Setup. Default 0.
game.following_room_timer | How long to wait before following char emerges in new room, default 150. (higher is longer).
game.keep_screen_during_instant_transition | Normally the Instant transition blacks the screen in 8-bit colour modes, to avoid strange palette effects. However you can set this to 1 to prevent it doing so.
**game.inv_activated** | Inventory item that the player last clicked on. Useful for unhandled_event.
game.inventory_greys_out | Set to 1 to make inventory controls grey out when GUI disabled is set to "GUIs Grey Out"
game.lipsync_speed | Similar to Game.TextReadingSpeed, but this determines how quickly the text is 'read' out by the mouth moving. You should normally only set this faster than text_speed, otherwise the reading will get cut off when the text times out. Default 15.
game.max_dialogoption_width | Maximum width of textwindow-based dialog options box. Default 180.
game.min_dialogoption_width | Minimum width of textwindow-based dialog options box. Default 0.
game.narrator_speech | Which character ID to use for voice speech within Display() command. Default initial player character. You can also use NARRATOR which uses 'NARR' prefix - special narrator character.
game.no_textbg_when_voice | Normally 0. If 1, and the Sierra-style With Background speech style is in use, will change to the Sierra-style (No Bg) if a voice speech line is present.
game.read_dialog_option_color | By default, -1. You can set this to a colour number, in which case dialog options that the player has selected before will be displayed in this colour.
game.roomscript_finished | The on_call function has completed executing. (See [CallRoomScript](Game#callroomscript))
**game.score** | The player's score. To modify the score, use the GiveScore script function.
game.score_sound | Sound effect to play when the player gets points, originally set in the editor.
game.screenshot_height | The height of screenshot images when saved into save games. The largest you can have is the full screen size (320x200), which gives the highest quality but the largest size save game files. The default is 160x100.
game.screenshot_width | The width of screenshot images when saved into save games.
game.show_single_dialog_option | If only a single dialog option is available, show it anyway (default=0)
game.sierra_inv_color | The background color of the sierra-style inventory.
game.skip_display | Setting for how Display() messages are skipped; valid values are same as for Speech.SkipStyle (default 3).
game.skip_speech_specific_key | Default 0. You can set it to a keycode, in which case only that key can skip speech text.
game.speech_bubble_width | Maximum width of the thought bubble text window (default 100)
game.speech_text_align | Sets how text in Lucasarts-style speech is aligned. Same possible values as game.text_align, default eAlignCentre
game.speech_text_gui | The textwindow GUI number used for sierra-style speech.
game.text_align | Sets how text in message boxes and Sierra-style speech is aligned:<br>eAlignLeft: text aligned to left within message box (default)<br>eAlignCentre: text is centred within the message box<br>eAlignRight: text is right-aligned within the message box<br>These options do not affect Lucasarts-style speech, which is always centred.
game.text_shadow_color | Color used for speech text shadow (default 16).
game.top_bar_XXXX | Customizations for [DisplayTopBar](DisplayAt#displaytopbar), see link for details
game.total_score | Maximum possible score, initially set in the editor.
game.used_mode | Cursor mode used with last click (use with "any click" events to find out which mode was used)
**mouse.x** | Mouse X co-ordinate when the last game loop was run (320-res)
**mouse.y** | Mouse Y co-ordinate when the last game loop was run (320-res)
palette[SLOT].r | The red component (0-63) of palette slot SLOT
palette[SLOT].g | The green component (0-63) of palette slot SLOT
palette[SLOT].b | The blue component (0-63) of palette slot SLOT
player.[x,y,name,...] | Alias to the current player character.
