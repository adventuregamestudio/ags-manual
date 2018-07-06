[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags12.md#topic20)
[![Previous](back.gif)](ags23.md#topic38)
[![Next](forward.gif)](ags25.md#topic39)

------------------------------------------------------------------------

Debugging features
------------------

It happens to the best of us - you're merrily ploughing along making
your game, when suddenly something just isn't working right. It's not
always obvious where the problem is.

AGS now has some advanced debugging features that can help you out. If
all else fails, you can of course ask for help on the AGS forums.

There are two different types of debugging, that are enabled in
different ways. The script debugger is only enabled when you use F5 to
run your game; but the Debug() commands are only available when "Enable
debug mode" is set in your Game Settings. So, just before you release
your game, set that option to False and compile the game again to make
sure the player can't cheat using these features.

**1. The script debugger**

When you run the game using the Run (F5) option, the game will be
started with the debugger. This allows you to pause your game and follow
it through one line at a time.

There are two main ways to use this feature:

\* Press SCROLL LOCK while playing the game. This will break out when
the next line of script is run.

\* Place a breakpoint in your script. You do this by clicking on a line
of code in the script editor, then pressing F9. Then, when the game
arrives at this line of code, it will stop running.

**NOTE:** The editor will allow you to place a breakpoint on any line of
script. However, in order for it to work, it must be placed on a line
that has some code on it.

Once the script has stopped, you can use the "Step Into" button (F11) to
step through the lines of code, one by one. To allow the game to
continue running normally, use the Run (F5) button.

**NOTE:** The Script Debugger is not supported on Windows 98 or Windows
ME systems. If you're still using Windows 98, please upgrade to Windows
XP or higher to take advantage of this feature.

**2. The Debug() command**

There is a scripting command, [Debug](ags54.md#Debug), which you can
use in your script to help you find problems. The default setup enables
some hotkeys for the various features - in particular, Ctrl+X allows you
to teleport to another room, Ctrl+A shows the walkable areas on the
screen and Ctrl+S gives you all the inventory items.

You can also use the Debug command to assign a hotkey to toggle FPS
display on and off. (FPS is Frames Per Second, which allows you to see
the game speed and spot any slow-running rooms).

This command only works if Debug Mode is enabled in your Game Settings.

**3. Current room information**

Pressing Ctrl+D displays some information about the current room. It
tells you what room number you are in, followed by the current status of
all objects in the room. After that, another messagebox tells you all
the characters that are in the current room and various information
about them.

This command only works if Debug Mode is enabled in your Game Settings.
