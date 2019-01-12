## BASS template

This template is a modified version of what was previously known as the
'Lightweight BASS stub', although the script module within retains its
previous name of TwoClickHandler. The behaviour of the script module aims to
simplify and mask the cursor modes, removing the need for the player
to manually set them. It also implements default behaviours where none are
explicitly implemented, through the use of [unhandled_event](TextScriptEvents)
in the global script.

Without making any direct comparisons which might result in a lawsuit, in the
**default** mode left-clicking will do things, right-clicking will look at
things. In the **classic** mode the mouse buttons are reversed, left-clicking
will look at things, right-clicking will do things.

**NOTE: Currently the pop-up threshold for the inventory bar is defined
in the script header**

    #define INVENTORY_POPUP_POSITION 15

Example:

    // register a GUI to use for the inventory bar
    TwoClickHandler.RegisterInventoryGui(gInventoryBar);
    // register a Label to use for action text
    TwoClickHandler.RegisterActionLabel(lblAction);
    // select the classic button mode (left-click to look, right-click to use)
    TwoClickHandler.SetMouseMode(eTwoClickMouseModeClassic);
---

### TwoClickHandler.RegisterInventoryGui

    TwoClickHandler.RegisterInventoryGui(GUI* inventory_gui);

Assigns the [GUI](GUI) which will be used for the inventory.

---

### TwoClickHandler.RegisterActionLabel

    TwoClickHandler.RegisterActionLabel(Label* label);

Assigns the [Label](Label) which will be used to display text descriptions.

---

### TwoClickHandler.SetMouseMode

    TwoClickHandler.SetMouseMode(TwoClickMouseMode mode);

Sets how left and right clicks are processed. Possible values are:

`eTwoClickMouseModeNormal` (left-click to use, right-click to look)<br>
`eTwoClickMouseModeClassic` (left-click to look, right-click to use)
