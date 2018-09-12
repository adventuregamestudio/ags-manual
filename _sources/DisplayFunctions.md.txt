## Display functions

### Display

    Display (string message, ...)

Displays a message to the screen. It will be displayed in the standard
message box, and centred in the middle of the screen.

You can insert the value of variables into the message. For more
information, see the [string formatting](StringFormats)
section.

Example:

    int my_counter;
    Display ("The counter is currently set to %d.", my_counter);

will replace the '`%d`' with the value of the variable "my_counter".

NOTE: Display is a blocking function - that is, control will not return
to the script until the player has removed the text window (by pressing
a key or clicking the mouse). While the window is displayed, all other
processing, like animations and interface display, are disabled. This is
usually used for responses to the player LOOKing at things.

*See Also:* [DisplayAt](DisplayFunctions#displayat),
[DisplayMessage](DisplayFunctions#displaymessage),
[Character.Say](Character#say),
[DisplayTopBar](DisplayFunctions#displaytopbar),
[String.Format](String#format)

---

### DisplayAt

    DisplayAt(int x, int y, int width, string message, ...)

Identical to the "Display" function, only this allows you to define the
position and size of the window where the text is displayed. The X and Y
variables define the co-ordinates of the upper-left corner of the
window.

The WIDTH variable defines the maximum width of the window. The height
is then automatically calculated so that the message fits into the
window.

You can insert the value of variables into the message. For more
information, see the [string formatting](StringFormats)
section.

Note: This is a blocking call. See the "Display" help for more
information.

Example:

    DisplayAt (50,50,100, "This is a message");

will display the message at coordinates 50,50 in a box 100 pixels wide.

*See Also:* [Display](DisplayFunctions#display),
[DisplayAtY](DisplayFunctions#displayaty)

---

### DisplayAtY

    DisplayAtY (int y, string message)

Similar to the Display function, except that this will display the
message box at the specified Y location on the screen. The Y defines the
co-ordinate of the top of the message box. The horizontal positioning
will be automatically calculated as usual.

Example:

    DisplayAt (50, "This is a message");

will display the message at y coordinate 50.

*See Also:* [Display](DisplayFunctions#display),
[DisplayAt](DisplayFunctions#displayat)

---

### DisplayMessage

    DisplayMessage (int message_number)

Identical to the Display function, but this uses a message text defined
in the AGS Editor rather than in the script. It will either use a message
from the current room, or a global message (if message_number >= 500).

Example:

    DisplayMessage(220);

will display the message 220 of the Room message editor.

*See Also:* [Display](DisplayFunctions#display),
[DisplayMessageAtY](DisplayFunctions#displaymessageaty)

---

### DisplayMessageAtY

    DisplayMessageAtY (int message_number, int yposition)

Identical to the DisplayMessage function, except that the text box is
positioned with its top at YPOSITION, the same way as DisplayAtY works.

This is useful if you have an important graphic in the middle of the
screen that the text box would normally cover up - with this function
you can place the message above or below it.

Example:

    DisplayMessageAtY(527, 200);

will display global message 527, in the lower half of the screen.

*See Also:* [DisplayAtY](DisplayFunctions#displayaty),
[DisplayMessage](DisplayFunctions#displaymessage)

---

### DisplayTopBar

    DisplayTopBar(int y, int text_color, int back_color, string titleText, string message, ...)

Displays a message in a text window, with a caption bar on top of it.

This displays MESSAGE in a similar way to the normal Display command,
but above the text window a caption bar will be displayed with TITLETEXT
in it. This method was used in some early Sierra games to indicate who
was talking by having their name in the caption, and can be handy if you
don't want to draw a talking view for a character.

You can insert the value of variables into the message. For more
information, see the [string formatting](StringFormats)
section.

The Y parameter specifies the Y location on the screen where the message
box will appear. The default is 25.

The TEXT_COLOR parameter specifies the text colour of the top bar, and
the BACK_COLOR specifies the background colour of the top bar.

You can pass 0 for Y, TEXT_COLOR or BACK_COLOR - if you do, it will
use the setting you used last time.

There are a couple of game variables available which can further
customize the look of the bar. You can change these before calling
DisplayTopBar.

**game.top_bar_bordercolor** sets the colour used for the bar's border
(set to the same colour as the backcolor if you don't want a border)<br>
**game.top_bar_borderwidth** sets the width of the bar's border, in
pixels (default 1)<br>
**game.top_bar_font** sets the font to use for the top bar. The
default is -1, which means that the current Normal font is used. Set it
to a specific number to use that font instead.

Example:

    DisplayTopBar(25, 8, 7, "Evil wizard", "Get out of my house and never return!");

will display "Get out of my house and never return!" in the message box,
with the caption bar reading "Evil wizard". The message box will have
dark grey text on a light gray background.

*See Also:* [Display](DisplayFunctions#display),
[DisplayAt](DisplayFunctions#displayat)
