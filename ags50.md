[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags49.md#topic50)
[![Next](forward.gif)](ags51.md#DrawingSurfaceFunctions)

------------------------------------------------------------------------

DialogOptionsRenderingInfo functions and properties
---------------------------------------------------

The DialogOptionsRenderingInfo instance is used by the [custom dialog
options](ags42.md#CustomDialogOptions) system. You can never create one
yourself, it will be passed in to the dialog option functions as
described in the linked page.

[RunActiveOption](#DialogOptionsRenderingInfo.RunActiveOption)\
[Update](#DialogOptionsRenderingInfo.Update)\
[ActiveOptionID property](#DialogOptionsRenderingInfo.ActiveOptionID)\
[DialogToRender property](#DialogOptionsRenderingInfo.DialogToRender)\
[HasAlphaChannel property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.HasAlphaChannel)\
[Height property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.Height)\
[ParserTextBoxWidth
property](#DialogOptionsRenderingInfo.ParserTextBoxWidth)\
[ParserTextBoxX property](#DialogOptionsRenderingInfo.ParserTextBoxX)\
[ParserTextBoxY property](#DialogOptionsRenderingInfo.ParserTextBoxY)\
[Surface property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.Surface)\
[Width property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.Width)\
[X property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.X)\
[Y property
(DialogOptionsRenderingInfo)](#DialogOptionsRenderingInfo.Y)\

------------------------------------------------------------------------

[]()

### RunActiveOption

    bool DialogOptionsRenderingInfo.RunActiveOption();

Runs the currently selected dialog option, the one set in
ActiveOptionID, and returns **true** on success.

As of AGS 3.4.0 you must call this function for conversation to
continue, most common places for such call are
`dialog_options_mouse_click` and `dialog_options_key_press` functions.

Example:

    function dialog_options_key_press(DialogOptionsRenderingInfo *info, eKeyCode key)
    {
      if (keycode == eKeyReturn)
        info.RunActiveOption();
    }

runs selected dialog option when player presses Enter/Return key.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.ActiveOptionID](ags50.md#DialogOptionsRenderingInfo.ActiveOptionID)

------------------------------------------------------------------------

[]()

### Update

    void DialogOptionsRenderingInfo.Update();

Forces dialog options to redraw, eventually leading to be
`dialog_options_render` function run.

Like other elements of interface, dialog options GUI does not redraw
itself every game loop; in attempt to optimize perfomance it aims to do
so only when there are changes to its look. But sometimes you may want
to change GUI looks based on your own decision, and not automatic
behavior. For example, you want to script animated text, or other
element belonging to dialog options. This is when you call
DialogOptionsRenderingInfo.Update().

**IMPORTANT:** Keep in mind that calling **Update** does not immediately
run `dialog_options_render`, render function will be run at least after
current script ends.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

------------------------------------------------------------------------

[]()

### ActiveOptionID property

    int DialogOptionsRenderingInfo.ActiveOptionID;

Gets/sets the currently active option on the dialog options screen. You
set this in the `dialog_options_get_active` function to tell AGS which
option the mouse is hovering over. This ensures that the correct option
is activated when the player clicks the mouse button.

You can read this property in the `dialog_options_render` function in
order to highlight the selected option in a different manner to the
others.

This property can be set to **0** which indicates that no option is
selected; otherwise it will be the option number from 1 to the number of
options in the dialog.

Example:

    function dialog_options_get_active(DialogOptionsRenderingInfo *info)
    {
      info.ActiveOptionID = 1;
    }

always selects the first option

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.RunActiveOption](ags50.md#DialogOptionsRenderingInfo.RunActiveOption),
[Dialog.GetOptionState](ags49.md#Dialog.GetOptionState)

------------------------------------------------------------------------

[]()

### DialogToRender property

    Dialog* DialogOptionsRenderingInfo.DialogToRender;

Gets the dialog that needs to be rendered. You can loop through all the
options in the dialog in order to decide what to display on the screen.

Example: For an example please see the [custom dialog
options](ags42.md#CustomDialogOptions) page.

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:* [Dialog.GetOptionState](ags49.md#Dialog.GetOptionState),
[DialogOptionsRenderingInfo.Surface](ags50.md#DialogOptionsRenderingInfo.Surface)

------------------------------------------------------------------------

[]()

### HasAlphaChannel property (DialogOptionsRenderingInfo)

    int DialogOptionsRenderingInfo.HasAlphaChannel;

Gets/sets whether the dialog options's drawing surface will have alpha
channel.

This can only be set within the `dialog_options_get_dimensions`
function, but can be read in other functions in order to render the
options.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
      info.HasAlphaChannel = true;
    }

creates a 300x150 size area with alpha channel to draw the dialog
options in.

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.Height](ags50.md#DialogOptionsRenderingInfo.Height),
[DialogOptionsRenderingInfo.Width](ags50.md#DialogOptionsRenderingInfo.Width)

------------------------------------------------------------------------

[]()

### Height property (DialogOptionsRenderingInfo)

    int DialogOptionsRenderingInfo.Height;

Gets/sets the height of the area needed to draw the dialog options.

This can only be set within the `dialog_options_get_dimensions`
function, but can be read in other functions in order to render the
options.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
    }

creates a 300x150 size area to draw the dialog options in

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.Width](ags50.md#DialogOptionsRenderingInfo.Width)

------------------------------------------------------------------------

[]()

### ParserTextBoxWidth property

    int DialogOptionsRenderingInfo.ParserTextBoxWidth;

Gets/sets the width of the text parser textbox on the dialog options. If
the text parser is not enabled for this dialog, this setting will be
ignored.

This can only be set within the `dialog_options_get_dimensions`
function.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
      // Put the text parser at the bottom (if enabled)
      info.ParserTextBoxX = 10;
      info.ParserTextBoxY = 130;
      info.ParserTextBoxWidth = 180;
    }

positions the parser text box at (10,130) inside the 300x150 dialog
options area

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.Width](ags50.md#DialogOptionsRenderingInfo.Width),
[DialogOptionsRenderingInfo.ParserTextBoxX](ags50.md#DialogOptionsRenderingInfo.ParserTextBoxX),
[DialogOptionsRenderingInfo.ParserTextBoxY](ags50.md#DialogOptionsRenderingInfo.ParserTextBoxY)

------------------------------------------------------------------------

[]()

### ParserTextBoxX property

    int DialogOptionsRenderingInfo.ParserTextBoxX;

Gets/sets the X-position of the text parser textbox on the dialog
options. If the text parser is not enabled for this dialog, this setting
will be ignored.

This X-position is relative to the dialog options surface. That is, an X
of 10 will position it 10 pixels within the dialog options area, not 10
pixels from the edge of the screen.

This can only be set within the `dialog_options_get_dimensions`
function.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
      // Put the text parser at the bottom (if enabled)
      info.ParserTextBoxX = 10;
      info.ParserTextBoxY = 130;
      info.ParserTextBoxWidth = 180;
    }

positions the parser text box at (10,130) inside the 300x150 dialog
options area

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.ParserTextBoxWidth](ags50.md#DialogOptionsRenderingInfo.ParserTextBoxWidth),
[DialogOptionsRenderingInfo.ParserTextBoxY](ags50.md#DialogOptionsRenderingInfo.ParserTextBoxY)

------------------------------------------------------------------------

[]()

### ParserTextBoxY property

    int DialogOptionsRenderingInfo.ParserTextBoxY;

Gets/sets the Y-position of the text parser textbox on the dialog
options. If the text parser is not enabled for this dialog, this setting
will be ignored.

This Y-position is relative to the dialog options surface. That is, a Y
of 10 will position it 10 pixels within the dialog options area, not 10
pixels from the edge of the screen.

This can only be set within the `dialog_options_get_dimensions`
function.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
      // Put the text parser at the bottom (if enabled)
      info.ParserTextBoxX = 10;
      info.ParserTextBoxY = 130;
      info.ParserTextBoxWidth = 180;
    }

positions the parser text box at (10,130) inside the 300x150 dialog
options area

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.ParserTextBoxX](ags50.md#DialogOptionsRenderingInfo.ParserTextBoxX)

------------------------------------------------------------------------

[]()

### Surface property (DialogOptionsRenderingInfo)

    DrawingSurface* DialogOptionsRenderingInfo.Surface;

Gets the drawing surface that can be used to draw the dialog options.

This can only be used within the `dialog_options_render` function; in
all other functions it will return *null*.

Unlike most other uses of the DrawingSurface, you do **NOT** have to
release this one. AGS will automatically do that for you after the
`dialog_options_render` function has completed.

The size of the surface should correspond to the Width and Height
requested in the `dialog_options_get_dimensions` function.

Example:

    function dialog_options_render(DialogOptionsRenderingInfo *info)
    {
      info.Surface.Clear(14);
    }

clears the dialog options area to yellow.

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:* [DrawingSurface
functions](ags51.md#DrawingSurfaceFunctions)

------------------------------------------------------------------------

[]()

### Width property (DialogOptionsRenderingInfo)

    int DialogOptionsRenderingInfo.Width;

Gets/sets the width of the area needed to draw the dialog options.

This can only be set within the `dialog_options_get_dimensions`
function, but can be read in other functions in order to render the
options.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.Width = 300;
      info.Height = 150;
    }

creates a 300x150 size area to draw the dialog options in

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.Height](ags50.md#DialogOptionsRenderingInfo.Height)

------------------------------------------------------------------------

[]()

### X property (DialogOptionsRenderingInfo)

    int DialogOptionsRenderingInfo.X;

Gets/sets the horizontal co-ordinate of the top-left corner of the
dialog options area.

This can only be set within the `dialog_options_get_dimensions`
function, but can be read in other functions in order to render the
options.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.X = 50;
      info.Y = 20;
      info.Width = 200;
      info.Height = 150;
    }

creates a 200x150 size area at (50, 20) to draw the dialog options in

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.Y](ags50.md#DialogOptionsRenderingInfo.Y)

------------------------------------------------------------------------

[]()

### Y property (DialogOptionsRenderingInfo)

    int DialogOptionsRenderingInfo.Y;

Gets/sets the vertical co-ordinate of the top-left corner of the dialog
options area.

This can only be set within the `dialog_options_get_dimensions`
function, but can be read in other functions in order to render the
options.

Example:

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      info.X = 50;
      info.Y = 20;
      info.Width = 200;
      info.Height = 150;
    }

creates a 200x150 size area at (50, 20) to draw the dialog options in

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:*
[DialogOptionsRenderingInfo.X](ags50.md#DialogOptionsRenderingInfo.X)


