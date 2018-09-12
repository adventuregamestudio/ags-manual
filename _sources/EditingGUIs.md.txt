## Editing the GUIs

The game interface is split up into GUIs. Each GUI is a rectangular
region on the screen which is drawn on top of the background scene. Each
can be set to either:

-   be always displayed (for example the Sierra status-line)
-   pop-up when the mouse moves to a certain position (eg.
    Sierra icon-bar)
-   pop-up on script command only

The default interface is made up of two GUIs - the status line, and the
icon bar.

Go to the "GUIs" node in the main tree. Under this all the GUIs in the
game are listed -- double-click one to edit it. To create a new one,
right-click on the main "GUIs" node and choose "New GUI".

Once you've opened up a GUI, you'll notice the GUI itself in the main
window, and its settings can be edited in the Properties grid. This
allows you to change the background colour of the GUI, set a background
picture, and set the location and width/height amongst other things.

The "Visibility" property allows you to set when the GUI is displayed.
The default is "Normal", which means that the GUI will initially be
visible, though you can turn it off with a GUI.Visible=false command in
game_start if you need to.

The "Popup modal" option means that the GUI will be initially off and
must be turned on by a script command. With this option, the game will
be paused while the GUI is displayed, during which time the
on_mouse_click and on_key_press functions will not get run.

The "Mouse YPos" option means that the GUI only appears when the mouse
vertical position moves above the y-coordinate set with the "Popup-YP"
option.

"Persistent" is like "Normal", except that this GUI will not be removed
during a cutscene when the setting "GUIs turn off when disabled" is set
in the general settings. Useful if you want most of your GUIs to turn
off, except a status line or whatever.

The "Z-Order" setting allows you to set which order the GUIs are drawn
in - ie. when there are two GUIs that overlap, which is drawn in front.
The Z-order setting is an arbitrary number between 0 and 1000. AGS draws
the GUIs in order, from the lowest numbered at the back to the highest
numbered at the front.

The "Clickable" setting allows you to set whether the GUI and buttons on
it respond to mouse clicks. This is on by default, but if you turn it
off and the player clicks on the GUI, the game will actually process the
click as if they clicked behind the GUI onto the actual screen. Useful
for transparent GUIs which are only used to display information.

You'll notice that the GUIs have names. These can be used in the script
in the same way as character names. For example, if a GUI is called
"gIconBar", you can use scripts such as:

`gIconBar.Visible = true;`


---

### GUI buttons

To provide interactivity with the interface, you use buttons.

To add a button, click the "Add button" button in the toolbar, and then
drag a rectangle with the mouse onto the GUI. You will see it displayed
as a text button, with the text "New button" on. Notice that the
Properties window is now displaying properties for your new button
rather than the GUI.

Using the Properties window, you can set a picture for the button
instead, and you can also set various other self-explanitory attributes.
You set what happens when the player clicks on the button by using the
"Click Action" attribute. This can be set to "Run Script" (the default),
and also "Set mode", which changes the cursor mode to the mode specified
in the "New mode number" property.

To delete a GUI button, right-click it and choose Delete.

---

### Interface text

You can easily display static text on interfaces. For example, the
Sierra-style interface displays the score in the status bar.

To show text to a GUI, you need a label. Click the "Add label" button in
the toolbar, then drag out a rectangle like you did when adding a
button. You can change the text displayed in the label by editing the
"Text" property. Notice that the text automatically wraps round to fit
inside the rectangle you drew.

As well as typing normal text into the label, you can add some special
markers which allow the text to change during the game. The following
tokens will be replaced with the relevant values in the game:

Token | Description
--- | ---
@GAMENAME@ | The game's name, specified on the Game Settings pane
@OVERHOTSPOT@ | Name of the hotspot which the cursor is over
@SCORE@ | The player's current score
@SCORETEXT@ | The text "Score: X of XX" with the relevant numbers filled in
@TOTALSCORE@ | The maximum possible score, specified on the Game Settings pane

Example: You have @SCORE@ out of @TOTALSCORE@ points.

The Properties window also allows you to align the text to left, right
or centre, as well as change its font and colour.

---

### Customized Text Windows

If you want to add a personal touch to the standard white text-boxes
which display all the messages during the game, you can create a border
using the GUI Editor. Right-click the "GUIs" node, and choose "New Text
Window GUI".

The element will be resized to about 1/4 of the screen, and you will see
8 pictures - one in each corner and one on each side. These are the
border graphics. You change the graphic for a corner in the normal way.

In the game, the corner graphics will be placed in the respective
corners of the text window, and the side graphics will be repeated along
the edge of the window. To tell the game to use your custom text window
style, go to the General Settings pane, and check the "Text windows use
GUI" box. Then, enter the number of the GUI which you used.

You can also set a background picture for the text window. In the GUI
editor, simply set a background picture for the GUI element. The graphic
you specify will not be tiled or stretched in the game; however, it will
be clipped to fit the window. You should use a graphic of at least about
250x80 pixels to make sure that it fills up the whole window.

To set the text colour in the window, simply set the Foreground Colour
of the GUI and that will be used to print the message text in.

Additionally, you may configure padding - the distance kept between text
window's border and text inside of it.

---

### Custom inventory

Another option you may have noticed in the GUI editor is the Add
Inventory button. This allows you to drag out a rectangle which will
display the player's current inventory, in the same way as the Lucasarts
games did. To make the inventory window scrollable, you will need to add
Up and Down arrow buttons, and attach script code to those buttons to
use the available functions such as
[InvWindow.ScrollUp](InvWindow#scrollup) and
[InvWindow.ScrollDown](InvWindow#scrolldown).

To see a full list of commands available for inventory windows, see the
[GUI Inv Window Functions and Properties](GUI)
section.

---

### Sliders

You can now add sliders to your GUIs. This allows you to have a nice
interface for the player to change settings such as volume and game
speed. To add a slider, click the "Add slider" button and drag out its
rectangle just like you would for a button. You can also resize it by
dragging the bottom- right hand corner out in the same way as a button.

Sliders can be either vertical or horizontal. The direction that it is
drawn in is automatic depending on the size that you stretch the slider
box to - if it is wider than it is tall you will get a horizontal
slider, otherwise you'll get a vertical slider.

For the properties of a slider you can set the minimum, maximum and
current values that the slider can have. In the game, the user will be
able to drag the handle from MIN to MAX, and the slider will start off
set to VALUE. For horizontal sliders, MIN is on the left and MAX on the
right, for vertical sliders MAX is at the top and MIN is at the bottom.

Whenever the user moves the handle's position on the slider, the
OnChange event is called. This means that if they continually drag the
handle up and down, the event will get called repeatedly.

Your script can find out the value of the slider using the Slider.Value
script property.

---

### Text Boxes

A text box is a simple device that allows the player to type information
into your game. Adding a text box works like adding the other types of
control.

If a text box is on a currently displayed GUI, all standard keypresses
(ie. letter keys, return and backspace) are diverted to the textbox
instead of being passed to the on_key_press function. When the player
presses Return in the text box, the OnActivate event is called. You can
then use the TextBox.Text property to retrieve what they typed in.

---

### List Boxes

List box controls allow you to add a list of items to your GUI. This
could be useful for doing a custom save/load dialog box, allowing the
user to choose between various options, and so forth.

You use the ListBox script functions to manipulate the list box - for
example, ListBox.AddItem to add an item, or ListBox.SelectedIndex to get
the current selection.

The ListBox.Translated property defines whether the translation will be
applied to list items or not. It is recommended to disable translation
for lists containing saved games.

The OnSelectionChanged event is fired when the player clicks on an item
in the list. You may wish to ignore this or to do something useful with
it.
