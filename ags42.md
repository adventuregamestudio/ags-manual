[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags41.md#RepExec)
[![Next](forward.gif)](ags43.md#BuiltInEnums)

------------------------------------------------------------------------

Custom dialog options rendering
-------------------------------

By default, AGS comes with two types of dialog options -- displaying
them using the size and position of an existing GUI, or creating a text
window to display the options in.

As of AGS 3.1, if neither of these methods suit you (for example,
because you want to use picture-based dialog options, or you want to add
scroll arrows), you can now implement the dialog options display
yourself in the script.

**NOTE:** This topic involves some advanced scripting. If you're just
starting out with AGS, please just use one of the built-in dialog option
styles for now, and come back to this later when you're comfortable with
scripting.

To write your custom dialog options code, you need to do the following:

-   Add a `dialog_options_get_dimensions` function to your script (an
    example follows). This function is called by AGS to find out which
    part of the screen you will be drawing onto. By setting the width
    and height to values greater than 0, the custom dialog system
    is activated.
-   Add a `dialog_options_render` function, which is called by AGS when
    it needs to draw the dialog options. A standard script
    [DrawingSurface](ags51.md#DrawingSurfaceFunctions) is supplied,
    which you can use to draw onto.
-   Optionally, add a `dialog_options_mouse_click` function. This is
    called by AGS if the player clicks the mouse anywhere on dialog
    options GUI. You might want to use this to process clicks on dialog
    options, and also on some custom scroll arrows, for example.
-   Optionally, add a `dialog_options_key_press` function. This is
    called by AGS if the player presses any key while custom dialog
    options are shown on screen. You can use this to implement
    key-controlled selection of dialog option, for example.
-   Optionally, add a `dialog_options_repexec` function. This works
    similarily to general `repeatedly_execute` function, but is called
    only if custom dialog options are shown on screen. You may use this
    to handle any other situations, such as determining which option the
    mouse is currently hovering over, or scripting time-related actions.

These functions don't have to go in the global script; you can put them
in any script you like. However, beware that if the functions are
present in more than one script they could interfere with each other and
cause problems.

**COMPATIBILITY NOTE:** The older versions of AGS (pre-3.4.0) supported
slightly different set of functions. Thus, there was no
`dialog_options_repexec`, but you had to add `dialog_options_get_active`
function instead, in which you set active option property. Clicks on the
options were processed by AGS automatically, so doing this was
essential. If you have imported older project and want to keep old
dialog option scripts, then you should go to General Settings and enable
"Use old-style dialog options rendering API".

**IMPORTANT:** When adding the functions to the script, they all take in
a parameter of type
[DialogOptionsRenderingInfo](ags50.md#DialogOptionsRenderingInfoFunctions).
The dialog\_options\_mouse\_click function has an extra parameter for
the mouse button, and dialog\_options\_key\_press has an extra parameter
for the key code. See the example below.

**IMPORTANT:** All of the Custom Dialog functions run on the
non-blocking thread. That means that you should not make any blocking
calls, such as Character.Say, Wait or Display within them, as they may
not behave correctly.

**Example A. Classic mouse controls**

    int dlg_opt_color = 14;
    int dlg_opt_acolor = 13;
    int dlg_opt_ncolor = 4;

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      // Create a 200x200 dialog options area at (50,100)
      info.X = 50;
      info.Y = 100;
      info.Width = 200;
      info.Height = 200;
      // Enable alpha channel for the drawing surface
      info.HasAlphaChannel = true;
      // Put the text parser at the bottom (if enabled)
      info.ParserTextBoxX = 10;
      info.ParserTextBoxY = 160;
      info.ParserTextBoxWidth = 180;
    }

    function dialog_options_render(DialogOptionsRenderingInfo *info)
    {
      info.Surface.Clear(dlg_opt_color);
      int i = 1,  ypos = 0;
      // Render all the options that are enabled
      while (i <= info.DialogToRender.OptionCount)
      {
        if (info.DialogToRender.GetOptionState(i) == eOptionOn)
        {
          if (info.ActiveOptionID == i)
            info.Surface.DrawingColor = dlg_opt_acolor;
          else
            info.Surface.DrawingColor = dlg_opt_ncolor;
            
          info.Surface.DrawStringWrapped(5, ypos, info.Width - 10, 
                  eFontFont0, eAlignLeft, info.DialogToRender.GetOptionText(i));
          ypos += GetTextHeight(info.DialogToRender.GetOptionText(i), eFontFont0, info.Width - 10);
        }
        i++;
      }
    }

    function dialog_options_repexec(DialogOptionsRenderingInfo *info)
    {
      info.ActiveOptionID = 0;
      if (mouse.y < info.Y || mouse.y >= info.Y + info.Height ||
          mouse.x < info.X || mouse.x >= info.X + info.Width)
      {
        return; // return if the mouse is outside UI bounds
      }

      int i = 1, ypos = 0;
      // Find the option that corresponds to where the mouse cursor is
      while (i <= info.DialogToRender.OptionCount)
      {
        if (info.DialogToRender.GetOptionState(i) == eOptionOn)
        {
          ypos += GetTextHeight(info.DialogToRender.GetOptionText(i), eFontFont0, info.Width - 10);
          if ((mouse.y - info.Y) < ypos)
          {
            info.ActiveOptionID = i;
            return;
          }
        }
        i++;
      }
    }

    function dialog_options_mouse_click(DialogOptionsRenderingInfo *info, MouseButton button)
    {
      if (info.ActiveOptionID > 0)
        info.RunActiveOption();
    }

The examples above are slightly naive; in reality you would probably
want to track the Y position of each option in a variable to save having
to continually scan through all the options.

**Example B. Keyboard controls**

    int dlg_opt_color = 14;
    int dlg_opt_acolor = 13;
    int dlg_opt_ncolor = 4;

    function dialog_options_get_dimensions(DialogOptionsRenderingInfo *info)
    {
      // Create a 200x200 dialog options area at (50,100)
      info.X = 50;
      info.Y = 100;
      info.Width = 200;
      info.Height = 200;
      info.ActiveOptionID = 1; // set to first option
    }

    function dialog_options_render(DialogOptionsRenderingInfo *info)
    {
      info.Surface.Clear(dlg_opt_color);
      int i = 1,  ypos = 0;
      // Render all the options that are enabled
      while (i <= info.DialogToRender.OptionCount)
      {
        if (info.DialogToRender.GetOptionState(i) == eOptionOn)
        {
          if (info.ActiveOptionID == i)
            info.Surface.DrawingColor = dlg_opt_acolor;
          else
            info.Surface.DrawingColor = dlg_opt_ncolor;

          info.Surface.DrawStringWrapped(5, ypos, info.Width - 10, 
              eFontFont0, eAlignLeft, info.DialogToRender.GetOptionText(i));
          ypos += GetTextHeight(info.DialogToRender.GetOptionText(i), eFontFont0, info.Width - 10);
        }
        i++;
      }
    }

    function dialog_options_key_press(DialogOptionsRenderingInfo *info, eKeyCode keycode) 
    {
      if (keycode == eKeyUpArrow && info.ActiveOptionID > 1)
        info.ActiveOptionID = info.ActiveOptionID - 1;
      if (keycode == eKeyDownArrow && info.ActiveOptionID < info.DialogToRender.OptionCount)
        info.ActiveOptionID = info.ActiveOptionID + 1;
      if (keycode == eKeyReturn || keycode == eKeySpace)
        info.RunActiveOption();
    }

For more detail on the commands used here, see the
[DialogOptionsRenderingInfo](ags50.md#DialogOptionsRenderingInfoFunctions)
page.

*Compatibility:* Supported by **AGS 3.1.0** and later versions.


