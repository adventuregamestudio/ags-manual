System functions and properties
-------------------------------

[AudioChannelCount property](#audiochannelcount)<br>
[AudioChannels property](#audiochannels)<br>
[CapsLock property](#capslock)<br>
[ColorDepth property](#colordepth)<br>
[Gamma property](#gamma)<br>
[HardwareAcceleration property](#hardwareacceleration)<br>
[HasInputFocus property](#hasinputfocus)<br>
[NumLock property](#numlock)<br>
[OperatingSystem property](#operatingsystem)<br>
[RenderAtScreenResolution property](#renderatscreenresolution)<br>
[RuntimeInfo property](#runtimeinfo)<br>
[ScreenHeight property](#screenheight)<br>
[ScreenWidth property](#screenwidth)<br>
[ScrollLock property](#scrolllock)<br>
[SupportsGammaControl property](#supportsgammacontrol)<br>
[Version property](#version)<br>
[ViewportHeight property](#viewportheight)<br>
[ViewportWidth property](#viewportwidth)<br>
[Volume property](#volume)<br>
[VSync property](#vsync)<br>
[Windowed property](#windowed)

---

### AudioChannelCount

    readonly static int System.AudioChannelCount;

Gets the number of Audio Channels available to the game (in the current
version of AGS this is 8).

This is useful if you want to loop through all the audio channels and
check what is playing on them.

Example:

    Display("There are %d audio channels.", System.AudioChannelCount);

will display a message with the number of audio channels.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [System.AudioChannels](#audiochannels)

---

### AudioChannels

    readonly static AudioChannel* System.AudioChannels[];

Gets the AudioChannel instance for the specified channel number. This
allows you to query the audio channel and find out what is playing on
it.

Example:

    AudioChannel *channel = System.AudioChannels[2];
    Display("Channel 2's current volume is %d.", channel.Volume);

will display a message with Audio Channel 2's current volume.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel](AudioChannel),
[System.AudioChannelCount](#audiochannelcount)

---

### CapsLock

    readonly static bool System.CapsLock;

Gets whether Caps Lock is active on the player's system.

You might want to use this to warn the player to switch it off before
typing a password in, for example.

Example:

    if (System.CapsLock)
    {
      Display("The CAPS LOCK light is on.");
    }

will display a message if Caps Lock is on.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [System.NumLock](#numlock),
[System.ScrollLock](#scrolllock)

---

### ColorDepth

*(Formerly known as system.color_depth, which is now obsolete)*

    readonly static int System.ColorDepth;

Returns the colour depth at which the game is running. This is the
overall game colour depth setting, and it is possible for individual
sprites or backgrounds to be different.

Example:

    Display("Game is running at: %d x %d, %d-bit colour", System.ScreenWidth,
                                      System.ScreenHeight, System.ColorDepth);

will display the current resolution and colour depth

*See Also:* [System.ScreenHeight](#screenheight),
[System.ScreenWidth](#screenwidth)

---

### Gamma

    static int System.Gamma;

Gets/sets the current screen Gamma level. This is 100 by default, and
you can set it anywhere from 0 (pitch black) to 200 (double normal
brightness).

[System.SupportsGammaControl](#supportsgammacontrol)
must return *true* in order for this property to have any effect.

Because every player's monitor will be different, you should normally
use this property linked to a GUI Slider in order to allow the player to
adjust it to suit their system.

Example:

    if (System.SupportsGammaControl) {
      System.Gamma = 150;
    }

will turn the screen brightness up to `50%` higher than normal

*See Also:*
[System.SupportsGammaControl](#supportsgammacontrol)

---

### HardwareAcceleration

    readonly static bool System.HardwareAcceleration;

Returns whether the game is running with hardware acceleration (eg.
Direct3D). If this is the case then RawDrawing is likely to be slower,
but alpha blending and large sprites are likely to be faster, than when
the non-accelerated driver is used.

**Cross-Platform Support**

Windows: **Direct3D driver**<br>
MS-DOS: **No**<br>
Linux: **No**<br>
MacOS: **No**

Example:

    if (System.HardwareAcceleration) {
      Display("Yay, we can draw loads of alpha blended sprites fast!");
    }

will display a message if the game is being run with hardware
acceleration

See Also: [AGS Graphics Drivers](GraphicsDriver)

---

### HasInputFocus

    readonly static bool System.HasInputFocus;

Tells whether the game window currently has input focus, meaning it is
active and player can control the game.

If your game is made to continue running in the background, when the
user switches out from game, you may use this property in scripts to
know if that actually happened.

Examples:

    if (!System.HasInputFocus)
      return;

skips the rest of the function if player has switched out from the game.

    function repeatedly_execute()
    {
      if (!System.HasInputFocus && IsGamePaused() == 0) {
        PauseGame();
      } else if (System.HasInputFocus && IsGamePaused() == 1) {
        UnPauseGame();
      }
    }

pauses game when player switches out, and unpauses it when player
switches back to game.

*Compatibility:* Supported by **AGS 3.3.5** and later versions.

*See Also:* [SetMultitaskingMode](Game#setmultitaskingmode)

---

### NumLock

    readonly static bool System.NumLock;

Gets whether Num Lock is active on the player's system.

You might want to use this to warn the player to switch it off before
using the numeric keypad arrow keys, for example.

Example:

    if (System.NumLock)
    {
      Display("The NUM LOCK light is on.");
    }

will display a message if Num Lock is on.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [System.CapsLock](#capslock),
[System.ScrollLock](#scrolllock)

---

### OperatingSystem

*(Formerly known as system.os, which is now obsolete)*

    readonly static eOperatingSystem System.OperatingSystem;

Returns which operating system the game is currently running under. It
can be one of the following values:

    eOSDOS
    eOSWindows
    eOSLinux
    eOSMacOS
    eOSAndroid
    eOSiOS
    eOSPSP

Example:

    if (System.OperatingSystem == eOSWindows) {
      Display("Running on Windows!");
    }
    else {
      Display("Not running on Windows!");
    }

---

### RenderAtScreenResolution

    static bool System.RenderAtScreenResolution;

Gets/sets whether sprites are rendered at screen resolution (if it's
**true**) or native game resolution (if it's **false**).

When your game has low native resolution and player is running it in
high display mode (for example 320x200 game being run in 1920x1080),
then turning this property on will let engine to take advantage of
higher display resolution and draw characters and objects less pixelated
when they are scaled up or down (e.g. on walkable area with scaling).

**IMPORTANT:** unless you have locked this parameter to certain value in
your game's [General settings](Settingupthegame#general-settings), players may also change it
in the setup program. In such case it is suggested that you do not
unconditionally modify this property in script, but rather provide a
menu option for toggling it at runtime.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

---

### RuntimeInfo

    readonly static String System.RuntimeInfo;

Returns the string containing short description of the enviroment the
game is currently running in, such as engine version, graphics mode, and
available game resources.

This is meant mainly for debug purposes.

**NOTE:** System.RuntimeInfo is a more convenient analogue of Debug(1,0) command, 
being more explicit and working on both release and debug
modes of the game.

Example:

    function on_key_press(eKeyCode keycode) {
      if (keycode == eKeyCtrlV) {
        Display(System.RuntimeInfo);
    }

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Debug](Game#debug)

---

### ScreenHeight

*(Formerly known as system.screen_height, which is now obsolete)*

    readonly static int System.ScreenHeight;

Returns the actual screen height that the game is running at. If a
graphic filter is in use, the resolution returned will be that before
any stretching by the filter has been applied. If letterbox borders are
enabled, the screen size reported will include the size of these
borders.

**NOTE:** Do **NOT** use this to calculate the centre of the screen when
working with co-ordinates. Co-ordinates are relative to the viewport, so
you should use [System.ViewportHeight](#viewportheight)
instead. Use the ScreenHeight property only for reporting purposes.

Example:

    Display("Game is running at: %d x %d, %d-bit colour", System.ScreenWidth,
                                      System.ScreenHeight, System.ColorDepth);

will display the current resolution and colour depth

*See Also:* [System.ColorDepth](#colordepth),
[System.ScreenWidth](#screenwidth),
[System.ViewportHeight](#viewportheight)

---

### ScreenWidth

*(Formerly known as system.screen_width, which is now obsolete)*

    readonly static int System.ScreenWidth;

Returns the actual screen width that the game is running at. If a
graphic filter is in use, the resolution returned will be that before
any stretching by the filter has been applied. If widescreen side
borders are enabled, the screen width reported will include the size of
these borders.

**NOTE:** Do **NOT** use this to calculate the centre of the screen when
working with co-ordinates. Co-ordinates are relative to the viewport, so
you should use [System.ViewportWidth](#viewportwidth)
instead. Use the ScreenWidth property only for reporting purposes.

Example:

    Display("Game is running at: %d x %d, %d-bit colour", System.ScreenWidth,
                                      System.ScreenHeight, System.ColorDepth);

will display the current resolution and colour depth

*See Also:* [System.ColorDepth](#colordepth),
[System.ScreenHeight](#screenheight)
[System.ViewportWidth](#viewportwidth)

---

### ScrollLock

    readonly static bool System.ScrollLock;

Gets whether Scroll Lock is active on the player's system.

Note that when running your game under the debugger, the Scroll Lock key
will break out of the game into the debugger, so it is not advised that
you use it for any other purpose in your game.

Example:

    if (System.ScrollLock)
    {
      Display("The SCROLL LOCK light is on.");
    }

will display a message if Scroll Lock is on.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [System.CapsLock](#capslock),
[System.NumLock](#numlock)

---

### SupportsGammaControl

    readonly static bool System.SupportsGammaControl;

Gets whether the player's PC supports changing the screen's gamma
control settings.

This must return *true* before you try and change the
[System.Gamma](#gamma) property. The situations in which
this will be supported are listed below.

**Cross-Platform Support**

Windows: **Full-screen only**<br>
MS-DOS: **No**<br>
Linux: **No**<br>
MacOS: **No**

Example:

    if (System.SupportsGammaControl) {
      Display("We can change the system gamma level!");
    }

will display a message if the system supports changing the gamma

*See Also:* [System.Gamma](#gamma)

---

### Version

*(Formerly known as system.version, which is now obsolete)*

    readonly static String System.Version;

Returns the AGS engine version number. This could be useful from within
script modules in order to use features available on a particular engine
version, or work around any known bugs.

The string returned is the full version number, for example "2.71.833".

Example:

    Display("AGS version: %s", System.Version);

will display the AGS version number

---

### ViewportHeight

*(Formerly known as system.viewport_height, which is now obsolete)*

    readonly static int System.ViewportHeight;

Returns the height of the current viewport. This is reported in the same
co-ordinate system that the game is using, so you can use this to find
out what the maximum possible Y co-ordinate is within the screen.

Example:

    Display("Game viewport: %d x %d", System.ViewportWidth, System.ViewportHeight);

will display the current viewport size

*See Also:* [System.ScreenHeight](#screenheight),
[System.ViewportWidth](#viewportwidth)

---

### ViewportWidth

*(Formerly known as system.viewport_width, which is now obsolete)*

    readonly static int System.ViewportWidth;

Returns the width of the current viewport. This is reported in the same
co-ordinate system that the game is using, so you can use this to find
out what the maximum possible X co-ordinate is within the screen.

Example:

    Display("Game viewport: %d x %d", System.ViewportWidth, System.ViewportHeight);

will display the current viewport size

*See Also:* [System.ScreenWidth](#screenwidth),
[System.ViewportHeight](#viewportheight)

---

### Volume

*(Formerly known as SetDigitalMasterVolume, which is now obsolete)*<br>
*(Formerly known as SetMusicMasterVolume, which is now obsolete)*

    static int System.Volume;

Gets/sets the overall system volume, from 0 to 100. This is the master
volume control, that affects all audio in the game. You would usually
attach this to a GUI Slider to enable the player to control the volume
from some sort of Control Panel GUI.

Example:

    System.Volume = 80;

will set the overall output volume to 80.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel.Volume](AudioChannel#volume),
[Game.SetAudioTypeVolume](Multimedia#setaudiotypevolume)

---

### VSync

*(Formerly known as system.vsync, which is now obsolete)*

    static bool System.VSync;

Gets/sets whether AGS waits for the vertical retrace before rendering
each frame. This is off by default.

If you switch this on, it can help to reduce the "tearing" effect that
you can get when the screen scrolls. However, doing so will lock the
game frame rate to the monitor's refresh rate, which will mean you
cannot reliably set a game speed higher than 60 fps.

**NOTE:** This property has no effect with the Direct3D driver.

Example:

    if (System.VSync) {
      Display("Vertical retrace sync is enabled!");
    }

will display a message if vsync is on

---

### Windowed

*(Formerly known as system.windowed, which is now obsolete)*

    static bool System.Windowed;

Gets/sets whether the game is running in a window (*true*) or
full-screen (*false*).

If you set this property at runtime, the game will try to switch to
alternate window mode. If it fails, it will return to previous one.

Example:

    if (System.Windowed) {
      Display("Game is running in a window!");
    }

will display a message if the game is running in a window

Example:

    function on_key_press(eKeyCode keycode) {
      if (keycode == eKeyEscape) {
        System.Windowed = !System.Windowed;
      }
    }

will switch from windowed to fullscreen mode and vice-versa whenever
player presses Escape key.

*Compatibility:* This property was read-only before **AGS 3.4.1**; it
can be set in **AGS 3.4.1** and later versions.
