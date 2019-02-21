## VerbCoin template

This template is a replacement for the previous VerbCoin template,
with the aim of dropping legacy features and offering a simpler base to
build upon.

The main changes are:

- There is no built-in mechanism for using timed clicks, so no press and
  hold of a mouse button is required anywhere
- Inventory is still right-click to open, but now [BASS](TemplateBASS)
  style controls are used within the inventory window
- No additional VerbCoin interfaces will be opened over the top of inventory items
- Rather than customise the action description per object/hotspot/character
  and allow actions to change based on context, the emphasis is on fixed
  actions with fallback to defaults (using [unhandled_event](TextScriptEvents))

As a general guide, left click on things to open the Verbcoin, right click
to open the inventory window.

The script module functions are mostly to register the interface components
used for displaying the VerbCoin and managing the inventory window.

Example:

    // setup VerbCoin GUI and buttons
    VerbCoin.InterfaceGui = gVerbCoin;
    VerbCoin.RegisterButton(btnLook, eVerbCoinPositionNorth, eModeLookat, "Look at");
    VerbCoin.RegisterButton(btnTalk, eVerbCoinPositionEast, eModeTalkto, "Talk to");
    VerbCoin.RegisterButton(btnInteract, eVerbCoinPositionSouth, eModeInteract, "Use");
    VerbCoin.RegisterButton(btnPickup, eVerbCoinPositionWest, eModePickup, "Pick up");
  
    // select the inventory GUI and action label
    VerbCoin.InventoryGui = gInventory;
    VerbCoin.ActionLabel = lblAction;
  
    // disable buttons where click events would be unhandled
    VerbCoin.ButtonAutoDisable = true;

---

### VerbCoin.Radius

    int VerbCoin.Radius

Sets the radius used when drawing the circle that renders the VerbCoin.

---

### VerbCoin.BackgroundTransparency

    int VerbCoin.BackgroundTransparency

Sets the background transparency level (from 0 to 100) for the VerbCoin

---

### VerbCoin.BackgroundColor

    int VerbCoin.BackgroundColor

Sets the background color (0 to 65535) for the VerbCoin.

---

### VerbCoin.BorderColor

    int VerbCoin.BorderColor

Sets the border color (0 to 65535) for the VerbCoin

---

### VerbCoin.BorderWidth

    int VerbCoin.BorderWidth;

Sets the border width for the VerbCoin.

---

### VerbCoin.OnClick

    VerbCoin.OnClick(GUIControl* control, MouseButton button);

Since click handlers can currently only be implemented in the global
script, this function is used to pass the event back into the VerbCoin
module.

---

### VerbCoin.RegisterButton

    VerbCoin.RegisterButton(GUIControl* control, VerbCoinPosition position, CursorMode mode, String verbtext);

Registers a button for use with the VerbCoin. The design is currently
4-point, so valid positions are:

`eVerbCoinPositionNorth`<br>
`eVerbCoinPositionEast`<br>
`eVerbCoinPositionSouth`<br>
`eVerbCoinPositionWest`

The cursor mode relates to standard the standard AGS cursor mode, which
is used to determine the action performaned. 'verbtext' is the text description
of the action, so if the mode being used is eModeInteract, a suitable description
could be 'use'.

---

### VerbCoin.InterfaceGui

    GUI* VerbCoin.InterfaceGui

Registers the [GUI](GUI) used for the VerbCoin.

### VerbCoin.InventoryGui

    GUI* VerbCoin.InventoryGui

Registers the [GUI](GUI) used for the inventory window.

### VerbCoin.ActionLabel

    Label* VerbCoin.ActionLabel

Registers the [Label](Label) used to display text descriptions.

### VerbCoin.Enable

    VerbCoin.Enable();

Enables the VerbCoin interface.

### VerbCoin.Disable

    VerbCoin.Disable();

Disables the VerbCoin interface.

### VerbCoin.IsEnabled

    VerbCoin.IsEnabled();

Returns true if the VerbCoin interface is currently enabled, else
returns false.

### VerbCoin.Open

    VerbCoin.Open();

Opens the VerbCoin interface (i.e. show its GUI).

### VerbCoin.Close

    VerbCoin.Close();

Closes the VerbCoin interface (i.e. hide its GUI)

### VerbCoin.IsOpen

    VerbCoin.IsOpen();

Returns true if the VerbCoin interface is currently open, else
returns false.

### VerbCoin.ButtonAutoDisable

    bool VerbCoin.ButtonAutoDisable

Sets whether VerbCoin buttons should be disabled, if clicking them
would result in an unhandled event.
