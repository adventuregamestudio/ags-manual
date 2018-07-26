Screen functions
----------------

[FadeIn](#fadein)<br>
[FadeOut](#fadeout)<br>
[FlipScreen](#flipscreen)<br>
[SetFadeColor](#setfadecolor)<br>
[SetNextScreenTransition](#setnextscreentransition)<br>
[SetScreenTransition](#setscreentransition)<br>
[ShakeScreen](#shakescreen)<br>
[ShakeScreenBackground](#shakescreenbackground)<br>
[TintScreen](#tintscreen)

---

### FadeIn

    FadeIn (int speed)

Fades in from a black screen to the current palette. This is used to
restore the screen after a FadeOut call. SPEED is from 1 (slowest) to 64
(fastest).

*NOTE: This is a blocking function.*

Example:

    FadeOut(30);
    Wait(40);
    FadeIn(10);

will fade the screen to black, wait 1 sec (40 game cycles) and then fade
in again.

*See Also:* [CyclePalette](CyclePalette#cyclepalette),
[FadeOut](#fadeout), [SetFadeColor](#setfadecolor)

---

### FadeOut

    FadeOut (int speed)

Fades the screen out to black. SPEED is the speed of the fade, from 1
(slowest) to 64 (instant). You can restore the screen with FadeIn.

*NOTE: This is a blocking function.*

Example:

    FadeOut(30);
    Wait(40);
    FadeIn(10);

will fade the screen to black, wait 1 sec (40 game cycles) and then fade
in again.

*See Also:* [CyclePalette](CyclePalette#cyclepalette),
[FadeIn](#fadein), [SetFadeColor](#setfadecolor)

---

### FlipScreen

    FlipScreen (int way)

Flips the screen round either the horizontal or vertical axis, or both.
This function is for special effects only - all co-ordinates remain the
same and it doesn't effect any other script functions.

way value | flip direction
--- | ---
0 | normal
1 | horizontal-flip (upside-down)
2 | vertical-flip (left-to-right)
3 | both (upside-down and backwards)

**NOTE**: This function is still a bit buggy - black parts of the screen
may show up wrong, and and pop-up messages will flip the screen back to
normal.

Example:

    FlipScreen(1);

will flip the screen upside down.

---

### SetFadeColor

    SetFadeColor(int red, int green, int blue)

Changes the colour which the screen fades out to, to have the specified
RGB value. Each of the parameters can range from 0-255. The default is
black, ie. (0, 0, 0)

The colour that you set here will be used in all future calls to
FadeIn/FadeOut, and also for the screen transition if it is set to Fade
In/Out.

Example:

    SetFadeColor(200, 0, 0);

will mean that next time the screen fades out, it fades to red instead
of black.

SeeAlso: [FadeIn](#fadein), [FadeOut](#fadeout),
[SetScreenTransition](#setscreentransition)

---

### SetNextScreenTransition

    SetNextScreenTransition(TransitionStyle)

Sets the room transition type to *TransitionStyle*, but ONLY for the
next room change. After that, it will revert back to the normal
transition type specified in the editor or with SetScreenTransition.

For the possible values for TransitionStyle, see
[SetScreenTransition](#setscreentransition).

Example:

    SetNextScreenTransition(eTransitionBoxout);
    cEgo.ChangeRoom(10);

will go to room 10 with a box-out effect, but then return to the normal
transition type from then on.

SeeAlso: [SetScreenTransition](#setscreentransition)

---

### SetScreenTransition

    SetScreenTransition(TransitionStyle)

Changes the default screen transition. TransitionStyle can be one of the
following:

    eTransitionFade
    eTransitionInstant
    eTransitionDissolve
    eTransitionBoxout
    eTransitionCrossfade

All future transitions will be done as specified until you call this
function again.

Example:

    SetScreenTransition(eTransitionFade);

will change the room transitions to Fade.

SeeAlso: [SetNextScreenTransition](#setnextscreentransition)

---

### ShakeScreen

    ShakeScreen (int amount)

Shakes the screen to simulate, for example, an earthquake. AMOUNT is how
much the screen shakes: 1 is hardly anything, and 25 is a lot.

Example:

    ShakeScreen(5);

will shake the screen a little.

*See Also:* [ShakeScreenBackground](#shakescreenbackground)

---

### ShakeScreenBackground

    ShakeScreenBackground (int delay, int amount, int length)

Shakes the screen to simulate, for example, an earthquake. The game is
not paused while the screen shakes - it will continue in the background.

DELAY specifies the 'shakiness' of the shake - 2 is the lowest you can
pass for this, and will create the most shaky screen.

AMOUNT specifies the ferociousness of the shake - ie. how much the
screen moves by when it does shake. Here, 1 is a very tiny shake, up to
about 30 for a ferocious shake.

LENGTH specifies how long the shake lasts for, in game loops. For
example, 80 would be equivalent to 2 seconds at the default game speed.

You can abort any current background shake that is in progress by
calling this command with the LENGTH parameter as zero.

Example:

    ShakeScreenBackground (4, 10, 80);

will shake the screen a little for 2 seconds.

*See Also:* [ShakeScreen](#shakescreen)

---

### TintScreen

    TintScreen (int red, int green, int blue)

Tints the screen with the specified RGB values. RED, GREEN and BLUE
range from 1 to 100.

Pass (0, 0, 0) to turn off the tinting and go back to how the screen
normally looks.

For historical reasons, the tint works by applying a 50`%`-transparent
layer of the specified colour to the screen after everything else has
been drawn. Therefore, it may not lead to the sort of results you might
expect.

**NOTE:** This command is currently experimental, since it causes a
massive slowdown in the engine, especially at high resolutions. If you
use it, you should provide an option for the player to turn it off.

**NOTE:** This feature does not work in 256-colour games.

Example:

    TintScreen (100, 50, 50);

will tint a heavy dose of red.
