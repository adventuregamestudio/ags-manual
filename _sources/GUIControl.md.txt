GUI control functions and properties
------------------------------------

This section lists the functions and properties common to all types of
GUI control. Each individual control type (Button, ListBox, etc) also
has its own specific section.

[GetAtScreenXY](#getatscreenxy)<br>
[AsType properties](#astype)<br>
[BringToFront](#bringtofront)<br>
[Clickable property](#clickable)<br>
[Enabled property](#enabled)<br>
[Height property](#height)<br>
[ID property](#id)<br>
[OwningGUI property](#owninggui)<br>
[SendToBack](#sendtoback)<br>
[SetPosition](#setposition)<br>
[SetSize](#setsize)<br>
[Visible property](#visible)<br>
[Width property](#width)<br>
[X property](#x)<br>
[Y property](#y)<br>
[ZOrder property](#zorder)

---

### GetAtScreenXY

*(Formerly known as GetGUIObjectAt, which is now obsolete)*

    static GUIControl* GUIControl.GetAtScreenXY(int x, int y)

Checks whether there is a GUI control at screen co-ordinates (X,Y).
Returns the control object if there is, or null if there is not. You
probably want to use this in conjunction with GetGUIAtLocation.

Example:

    GUIControl *theControl = GUIControl.GetAtScreenXY(mouse.x, mouse.y);
    if (theControl == lstSaveGames) {
      Display("The mouse is over the Save Games list box.");
    }
    else if (theControl == null) {
      Display("The mouse is not over a control.");
    }
    else {
      GUI *onGui = theControl.OwningGUI;
      Display("The mouse is over control %d on GUI %d.", theControl.ID, onGui.ID);
    }

will display what control the mouse is over.

*See Also:* [GUI.GetAtScreenXY](GUI#getatscreenxy)

---

### AsType

    Button*  GUIControl.AsButton;
    InvWindow* GUIControl.AsInvWindow;
    Label*   GUIControl.AsLabel;
    ListBox* GUIControl.AsListBox;
    Slider*  GUIControl.AsSlider;
    TextBox* GUIControl.AsTextBox;

Converts a generic GUIControl\* pointer into a variable of the correct
type, and returns it. If the control is not of the requested type,
returns *null*.

Example:

    Button *theButton = gIconbar.Controls[2].AsButton;
    if (theButton == null) {
      Display("Control 2 is not a button!!!!");
    }
    else {
      theButton.NormalGraphic = 44;
    }

attempts to set Button 2 on GUI ICONBAR to have NormalGraphic 44, but if
that control is not a button, prints a message.

*See Also:* [GUI.Controls](GUI#controls)

---

### BringToFront

    GUIControl.BringToFront()

Brings this control to the front of the Z-order. This allows you to
rearrange the display order of controls within the GUI.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnBigButton.BringToFront();

will move the *btnBigButton* button to be in front of all other controls
on the GUI.

*See Also:* [GUIControl.SendToBack](#sendtoback),
[GUIControl.ZOrder](#zorder)

---

### Clickable

    bool GUIControl.Clickable

Gets/sets whether the GUI control is clickable.

This property determines whether the player can click the mouse on the
control. If it is set to *false*, then any mouse clicks will go straight
through the control onto whatever is behind it. Unlike the Enabled
property though, setting Clickable to false does not alter the
appearance of the control.

Note that disabling the control by setting Enabled to false overrides
this setting -- that is, if Enabled is false then the control will not
be clickable, regardless of the *Clickable* setting.

Also, bear in mind that if you set *Clickable* to false then any mouse
clicks will go through the control onto whatever is behind. On the other
hand, if *Enabled* is set to false then the control "absorbs" the mouse
click but does not do anything with it.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnSaveGame.Clickable = false;

will make the *btnSaveGame* button non-clickable.

*See Also:* [GUIControl.Enabled](#enabled)

---

### Enabled

*(Formerly known as SetGUIObjectEnabled, which is now obsolete)*

    bool GUIControl.Enabled

Enables or disables a GUI control.

Normally, all your GUI controls (such as buttons, sliders, etc) are
enabled at all times except during a cutscene, when they are disabled.
This command allows you to explicitly disable a control at your script's
discretion.

If you set this to true, the control will be enabled; set to false to
disable it.

Whether you set it as enabled or not, it will **always** be disabled
during a blocking cutscene, along with all the other controls.

While a control is disabled, it will not respond to mouse clicks. If it
is a button, its mouseover and pushed pictures will not be shown. The
control will be drawn according to the game "When GUI Disabled"
settings, as usual.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnSaveGame.Enabled = false;

will disable the *btnSaveGame* button.

*See Also:* [GUIControl.Clickable](#clickable),
[GUIControl.Visible](#visible)

---

### Height

    int GUIControl.Height;

Gets/sets the height of the GUI control. This allows you to dynamically
resize GUI controls while the game is running.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnConfirm.Height = 20;

makes the *btnConfirm* button 20 pixels high.

*See Also:* [GUIControl.SetSize](#setsize),
[GUIControl.Width](#width)

---

### ID

    readonly int GUIControl.ID

Gets the GUI control's ID number. This is the control's object number
from the GUI editor, and is useful if you need to interoperate with
legacy code that uses the control's number rather than object name.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    SetGUIObjectEnabled(lstSaves.OwningGUI.ID, lstSaves.ID, 1);
    lstSaves.Enabled = false;

uses the obsolete SetGUIObjectEnabled function to enable the lstSaves
list box, and then uses the equivalent modern property to disable it.

*See Also:* [GUIControl.OwningGUI](#owninggui),
[GUI.ID](GUI#id)

---

### OwningGUI

    readonly GUI* GUIControl.OwningGUI

Gets the GUI control's owning GUI, which is the GUI that contains the
control.

Returns a GUI, which allows you to use all the usual [GUI functions and
properties](GUI).

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    GUI *thegui = lstSaves.OwningGUI;
    thegui.Visible = false;

    lstSaves.OwningGUI.Visible = true;

turns off the GUI that contains the lstSaves list box, then turns it on
again using the niftier full pathing approach.

*See Also:* [GUIControl.ID](#id),
[GUI.ID](GUI#id)

---

### SendToBack

    GUIControl.SendToBack()

Sends this control to the back of the Z-order. This allows you to
rearrange the display order of controls within the GUI.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnBigButton.SendToBack();

will move the *btnBigButton* button to be behind all other controls on
the GUI.

*See Also:*
[GUIControl.BringToFront](#bringtofront),
[GUIControl.ZOrder](#zorder)

---

### SetPosition

*(Formerly known as SetGUIObjectPosition, which is now obsolete)*

    GUIControl.SetPosition(int x, int y)

Moves the top-left corner of the GUI control to be at (X,Y). These
co-ordinates are relative to the GUI which contains the control.

This allows you to dynamically move GUI controls around on the screen
while the game is running, and this may well be useful in conjunction
with GUI.SetSize if you want to create dynamically resizable GUIs.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnConfirm.SetPosition(40, 10);

will move the *btnConfirm* button to be positioned at (40,10) within the
GUI.

*See Also:* [GUIControl.Enabled](#enabled),
[GUI.SetPosition](GUI#setposition),
[GUIControl.SetSize](#setsize),
[GUIControl.X](#x),
[GUIControl.Y](#y)

---

### SetSize

*(Formerly known as SetGUIObjectSize, which is now obsolete)*

    GUIControl.SetSize(int width, int height)

Adjusts the specified GUI control to have the new size WIDTH x HEIGHT.

This allows you to dynamically resize GUI controls on the screen while
the game is running, and this may well be useful in conjunction with
GUI.SetSize and GUIControl.SetPosition if you want to create dynamically
resizable GUIs.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    invMain.SetSize(160, 100);

will resize the *invMain* control to have a size of 160 x 100.

*See Also:* [GUIControl.Height](#height),
[GUIControl.SetPosition](#setposition),
[GUI.SetSize](GUI#setsize),
[GUIControl.Width](#width),

---

### Visible

    bool GUIControl.Visible

Gets/sets whether the GUI control is visible. This is *true* by default,
but you can set it to *false* in order to temporarily remove the GUI
control from the GUI.

While the control is invisible, it will not be drawn on the screen, and
will not register clicks or otherwise respond to any user input.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnSaveGame.Visible = false;

will make the *btnSaveGame* button invisible.

*See Also:* [GUIControl.Enabled](#enabled)

---

### Width

    int GUIControl.Width;

Gets/sets the width of the GUI control. This allows you to dynamically
resize GUI controls while the game is running.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnConfirm.Width = 110;

makes the *btnConfirm* button 110 pixels wide.

*See Also:* [GUIControl.Height](#height),
[GUIControl.SetSize](#setsize)

---

### X

    int GUIControl.X;

Gets/sets the X position of the GUI control. This specifies its left
edge, and is relative to the GUI which contains the control.

This allows you to dynamically move GUI controls around on their parent
GUI while the game is running.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnConfirm.X = 10;

will move the *btnConfirm* button to be positioned 10 pixels from the
left of its GUI.

*See Also:* [GUIControl.SetPosition](#setposition),
[GUIControl.Y](#y)

---

### Y

    int GUIControl.Y;

Gets/sets the Y position of the GUI control. This specifies its top
edge, and is relative to the GUI which contains the control.

This allows you to dynamically move GUI controls around on their parent
GUI while the game is running.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

Example:

    btnConfirm.Y = 20;

will move the *btnConfirm* button to be positioned 20 pixels from the
top of its GUI.

*See Also:* [GUIControl.SetPosition](#setposition),
[GUIControl.X](#x)

---

### ZOrder

    int GUIControl.ZOrder;

Gets/sets the control's Z-order relative to other controls within the
same owning GUI. This allows you to precisely arrange the display order
of controls at runtime and to know which position the control had at
certain moment in time.

For AGS GUI Z-order means the order in wich controls are displayed from
bottom to top. That means that control at the bottom has Z-order equal
to 0, and control at the top has highest Z-order, equal to (number of
controls - 1).

Setting `GUIControl.ZOrder = 0;` will do same thing as calling
`GUIControl.SendToBack()`, and setting
`GUIControl.ZOrder = GUIControl.OwningGUI.ControlCount - 1;` will do
same thing as calling `GUIControl.BringToFront()`.

If you try to set inappropriate ZOrder, the nearest acceptable one will
be applied instead.

**Applies To**

Inherited by the Button, InvWindow, Label, ListBox, Slider and TextBox.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:*
[GUIControl.BringToFront](#bringtofront),
[GUIControl.SendToBack](#sendtoback)

