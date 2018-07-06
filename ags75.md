[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags74.md#topic70)
[![Next](forward.gif)](ags76.md#topic71)

------------------------------------------------------------------------

Speech functions and properties
-------------------------------

[AnimationStopTimeMargin](#Speech.AnimationStopTimeMargin)\
[CustomPortraitPlacement](#Speech.CustomPortraitPlacement)\
[DisplayPostTimeMs](#Speech.DisplayPostTimeMs)\
[GlobalSpeechAnimationDelay](#Speech.GlobalSpeechAnimationDelay)\
[PortraitXOffset](#Speech.PortraitXOffset)\
[PortraitY](#Speech.PortraitY)\
[SkipKey](#Speech.SkipKey)\
[SkipStyle](#Speech.SkipStyle)\
[Style](#Speech.Style)\
[TextAlignment](#Speech.TextAlignment)\
[UseGlobalSpeechAnimationDelay](#Speech.UseGlobalSpeechAnimationDelay)\
[VoiceMode](#Speech.VoiceMode)\

------------------------------------------------------------------------

[]()

### AnimationStopTimeMargin

*(Formerly known as game.close\_mouth\_end\_speech\_time, which is now
obsolete)*

    static int Speech.AnimationStopTimeMargin

Gets/sets the time margin at which the character talking animation
should stop before before speech time ends. This property is specified
in **game loops** and is set to 10 by default.

**NOTE:** This property only affects the animation if voice mode is
disabled.

Example:

    Speech.AnimationStopTimeMargin = 40;

will stop talking animation 40 game loops (1 second with the default
game speed) before speech time ends.

*See Also:*
[Speech.DisplayPostTimeMs](ags75.md#Speech.DisplayPostTimeMs)

------------------------------------------------------------------------

[]()

### CustomPortraitPlacement

    static bool Speech.CustomPortraitPlacement

Enables/disables the custom speech portrait placement. When set to
**true** the character portraits are positioned at screen coordinates
defined by [Speech.PortraitXOffset](ags75.md#Speech.PortraitXOffset)
and [Speech.PortraitY](ags75.md#Speech.PortraitY). When set to
**false** the portraits will be automatically aligned again.

**NOTE:** This property has no effect if the Lucas-Arts speech style is
used.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:* [Speech.PortraitXOffset](ags75.md#Speech.PortraitXOffset),
[Speech.PortraitY](ags75.md#Speech.PortraitY)

------------------------------------------------------------------------

[]()

### DisplayPostTimeMs

    static int Speech.DisplayPostTimeMs

Gets/sets the extra time the speech will stay on screen after its base
time runs out. Commonly the time the speech lines and portrait stay on
screen is calculated based on the text length - if the text mode is on,
or voice clip length - if the voice mode is on. This property prolongs
the time the speech text and/or portrait is displayed. This property
does not interfere with speech skipping by key or mouse click: players
will still be able to skip speech any time they want (if appropriate
skip mode is enabled). This property is specified in **milliseconds**
and is set to zero by default.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:*
[Speech.AnimationStopTimeMargin](ags75.md#Speech.AnimationStopTimeMargin)

------------------------------------------------------------------------

[]()

### GlobalSpeechAnimationDelay

*(Formerly known as game.talkanim\_speed, which is now obsolete)*

    static int Speech.GlobalSpeechAnimationDelay

Gets/sets global speech animation delay which affects every character in
game. This property is specified in **game loops** and is set to 5 by
default.

**NOTE:** This property is ignored if lip sync is enabled.

**NOTE:** The property is only used when the
**Speech.UseGlobalSpeechAnimationDelay** is set to **true**. This
property **cannot** be used if the global speech animation delay is
disabled. In that case, the individual character's animation delay is
used instead.

*See Also:*
[Character.SpeechAnimationDelay](ags47.md#Character.SpeechAnimationDelay),
[Speech.UseGlobalSpeechAnimationDelay](ags75.md#Speech.UseGlobalSpeechAnimationDelay)

------------------------------------------------------------------------

[]()

### PortraitXOffset

    static int Speech.PortraitXOffset

Gets/sets the character's speech portrait **horizontal** offset relative
to screen side. The actual x coordinate of the portrait is calculated
based on whether portrait is to be displayed at the left or right side
of the screen. This property specifies the distance between the screen
side and respected portrait's border.

**NOTE:**The property is only used when the
**Speech.CustomPortraitPlacement** is set to **true**.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:*
[Speech.CustomPortraitPlacement](ags75.md#Speech.CustomPortraitPlacement),
[Speech.PortraitY](ags75.md#Speech.PortraitY)

------------------------------------------------------------------------

[]()

### PortraitY

    static int Speech.PortraitY

Gets/sets the character's speech portrait **y** coordinate on screen.

**NOTE:**The property is only used when the
**Speech.CustomPortraitPlacement** is set to **true**.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:*
[Speech.CustomPortraitPlacement](ags75.md#Speech.CustomPortraitPlacement),
[Speech.PortraitXOffset](ags75.md#Speech.PortraitXOffset)

------------------------------------------------------------------------

[]()

### SkipKey

*(Formerly known as game.skip\_speech\_specific\_key, which is now
obsolete)*

    static eKeyCode Speech.SkipKey

Gets/sets special key which can skip speech text. This makes all other
keys ignored when speech is displayed on screen, unless eKeyNone is
assigned, in which case any key can be used again.

**NOTE:**The specified key will only skip speech if the appropriate
speech skip style is enabled.

Example:

    Speech.SkipKey = eKeySpace;

will assign the "space" key to skip the speech.

*See Also:* [Speech.SkipStyle](ags75.md#Speech.SkipStyle)

------------------------------------------------------------------------

[]()

### SkipStyle

*(Formerly known as SetSkipSpeech, which is now obsolete)*\

    static SkipSpeechStyle Speech.SkipStyle

Gets/sets how the player can skip speech lines.

The accepted values are

    eSkipKeyMouseTime  player can skip text by clicking mouse or pressing key
    eSkipKeyTime       player can skip text by pressing key only, not by clicking mouse
    eSkipTime          player cannot skip text with mouse or keyboard
    eSkipKeyMouse      text does not time-out; player must click mouse or press key each time
    eSkipMouseTime     player can skip text by clicking mouse only, not by pressing key
    eSkipKey           text does not time-out; player can skip text by pressing key only
    eSkipMouse         text does not time-out; player can skip text by clicking mouse only

Example:

    Speech.SkipStyle = eSkipTime;

will make the player unable to skip the text by pressing a mouse button
or a key.

*See Also:*
[Game.IgnoreUserInputAfterTextTimeoutMs](ags54.md#Game.IgnoreUserInputAfterTextTimeoutMs),
[Game.TextReadingSpeed](ags54.md#Game.TextReadingSpeed),
[Game.Speech.SkipKey](ags75.md#Speech.SkipKey)

------------------------------------------------------------------------

[]()

### Style

*(Formerly known as SetSpeechStyle, which is now obsolete)*\

    static eSpeechStyle Speech.Style

Gets/sets theway in which speech text is displayed. This modifies the
setting originally set in the editor. SpeechStyle can be:

    eSpeechLucasarts
      speech text over character's head
    eSpeechSierra
      close-up portrait of character
    eSpeechSierraWithBackground
      close-up portrait + background window for text
    eSpeechFullScreen
      QFG4-style full screen dialog pictures

Example:

    Speech.Style = eSpeechSierra;

will change the speech style to a close up portrait of the character.

------------------------------------------------------------------------

[]()

### TextAlignment

*(Formerly known as game.speech\_text\_align, which is now obsolete)*

    static Alignment Speech.TextAlignment

Sets how text in Lucasarts-style speech is aligned.

The accepted values are

    eAlignLeft
    eAlignCentre
    eAlignRight

The default is eAlignCentre.

Example:

    Speech.TextAlignment = eAlignRight;

will align the speech text at the right side.

------------------------------------------------------------------------

[]()

### UseGlobalSpeechAnimationDelay

    static bool Speech.UseGlobalSpeechAnimationDelay

Gets/sets whether speech animation delay should use global setting, as
opposed to individual character's setting. The actual global delay value
is specified with **Speech.GlobalSpeechAnimationDelay**.

Example:

    Speech.UseGlobalSpeechAnimationDelay = true;

will make the game use global speech animation delay.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:*
[Character.SpeechAnimationDelay](ags47.md#Character.SpeechAnimationDelay),
[Speech.GlobalSpeechAnimationDelay](ags75.md#Speech.GlobalSpeechAnimationDelay)

------------------------------------------------------------------------

[]()

### VoiceMode

*(Formerly known as SetVoiceMode, which is now obsolete)*

    static eVoiceMode Speech.VoiceMode

Gets/sets whether voice and/or text captions are used in the game.

Valid values for VoiceMode are:

    eSpeechTextOnly      no voice, text only
    eSpeechVoiceAndText  both voice and text
    eSpeechVoiceOnly     voice only, no text

The default is *eSpeechVoiceAndText* if in-game speech is enabled, and
*eSpeechTextOnly* if it is not. Changing this setting changes the
behaviour of all [Say](ags47.md#Character.Say) and
[Display](ags78.md#Display) commands which have a speech file assigned
to them.

**WARNING:** you should only ever use *eSpeechVoiceOnly* at the player's
request to do so, because there is no guarantee that they even have a
sound card and so may not understand what is going on.

Example:

    if (IsSpeechVoxAvailable()==1)
        Speech.VoiceMode = eSpeechVoiceAndText;

will set the voice mode to voice and text if the voice pack is
available.


