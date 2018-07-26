Upgrading to AGS 3.4
--------------------

AGS 3.4 introduces a number of significant enhancements to game creation
process.

**Building game for multiple platforms**

AGS can now compile and deploy your game for more than one target
platform. Currently Windows and Linux are officially supported, but
other may be added in following updates. Check the "Built target
platforms" option in the "Compiler" section of the General Settings.

**NOTE:** for deploying your game for Linux you need to have a
Linux-related utilities to be placed in the "Linux" folder at your AGS
Editor installation. Those files are distributed along with the official
AGS release.

**Custom game resolution**

Your native game resolution can now be anything, not limited to
predefined variants anymore.

Similarily, the engine is now capable of running any game in any display
mode your system supports. To achieve this it uses scaling filter of
player's choice, and additional simple image stretching when required.
The setup program has been altered to reflect this feature.

**Script API selector**

You can now choose the variant of Script API (built-in functions and
properties available for use) with two switches in the "Backwards
Compatibility" section of the General Settings.

One switch is called "Script API version" and defines the topmost level
of built-in script content that you want to enable for your project. It
is suggested to set this to the highest possible value. However, there
may be cases when you load an older project in the newer version of AGS,
and new built-in function names conflict with names in some of the
scripts you used in your project. In such cases you may decide between
fixing your script or lowering AGS API version. The latter will let you
compile game scripts without any changes, at the price of not being able
to use newer built-in functions.

Second switch is called "Script Compatibility Level" and defines the
lowest level of built-in content. It is useful if you wish to keep using
some of the old functions that were declared obsolete by newer version
of AGS. You do so by setting this switch to version that still had those
functions.

**NOTE:** You may change those two settings anytime if you'd like to
experiment, or your plans has changed. It is recommended to do full game
rebuild after you do so though.

**Mutable custom properties**

Since introduction Custom Properties could not be changed at runtime,
they had to keep their default values set in the Editor throughout the
course of the game. Now this restriction was eliminated and you can
change any existing custom property in game script, using appropriate
SetProperty and SetTextProperty functions:

[Character.SetProperty](Character#setproperty),
[Character.SetTextProperty](Character#settextproperty),
[Hotspot.SetProperty](Hotspot#setproperty),
[Hotspot.SetTextProperty](Hotspot#settextproperty),
[InventoryItem.SetProperty](InventoryItem#setproperty),
[InventoryItem.SetTextProperty](InventoryItem#settextproperty),
[Object.SetProperty](Object#setproperty),
[Object.SetTextProperty](Object#settextproperty),
[Room.SetProperty](Room#setproperty),
[Room.SetTextProperty](Room#settextproperty)

Besides, the number of properties is no longer limited by 30, you may
make as much of them as you need for your game.

**Extended WFN fonts**

WFN (bitmap fonts) can now have up to 256 characters (as opposed to
previously supported 128). You may need a specialized editor to create
such fonts (for example, there is a good Editor plugin around meant for
this task), and AGS will properly draw any of the 256 characters.

**New script features**

First of all, you can now create your own managed structs and objects of
their type in script. The difference from common structs is that you use
pointers to work with these objects, and can pass them around as
function parameters and function return values as well. **IMPORTANT:**
there is a big limitation for user-defined managed structs now, it is
that they themselves cannot have members of pointer types (or dynamic
arrays). We suppose that this restriction is only temporary and hope to
remove it in future updates.

You can now have some new forms of loop in your script, in addition to
previously existing `while`. First is `do..while` kind of loop that
always performs its commands at least once before checking end
condition, second is `for` loop that lets you initialize internal
variable, define end condition and write iteration - all in its header.
Another introduced command is `switch`. One `switch` can replace a long
list of `if` and `else if` blocks.

See: [switch](managedmodifier#switch-case-statements),
[do..while](managedmodifier#dowhile),
[for](managedmodifier#for),
[break](managedmodifier#break),
[continue](managedmodifier#continue),
[managed](managedmodifier#managed),
[new](managedmodifier#new)

**Custom Dialog Options rendering extended**

In the past the custom dialog rendering was strictly tied to mouse
movement and clicks. Now it is extended to give you more freedom in
setting it up.

Two more related callbacks are added: `dialog_options_repexec` - that is
an analogue of `repeatedly_execute` function, but is called only while
dialog options are displayed, and `dialog_options_key_press` function,
which is called whenever player presses a key when dialog options are on
screen.

The `dialog_options_mouse_click` will now be called always, even if user
clicks on the option, but on other hand option won't be run without
explicit command:
[RunActiveOption](DialogOptionsRenderingInfo#runactiveoption).

Along with RunActiveOption,
[DialogOptionsRenderingInfo](DialogOptionsRenderingInfo)
struct received another member function:
[Update](DialogOptionsRenderingInfo#update). It forces options
GUI to redraw itself, hence may be used to implement custom animation,
or similar behavior.

**IMPORTANT:** The `dialog_options_get_active` callback was deprecated
and won't be called, at all. You will need to slightly change the logic
of your script. In most cases it may be enough to simply rename
`dialog_options_get_active` to `dialog_options_repexec`.

**NOTE:** For backwards compatibility you may use an option in General
Settings called "Use old-style custom dialog options API". This will
disable all the new stuff, but return `dialog_options_get_active` and
make `dialog_options_mouse_click` behave as it did before.

For detailed information see:
[Custom dialog options rendering](CustomDialogOptions)

**Some functions object-ised**

obsolete function/variable | replace with
--- | ---
GetRoomProperty | [Room.GetProperty](Room#getproperty)
ProcessClick | [Room.ProcessClick](Room#processclick)

**REMINDER:** you can also use "Script Compatibility Level" switch to
enable old functions.

**System limits update**

The maximal number of GUI Controls per GUI is no longer limited. The
maximal number of script modules is no longer limited.
