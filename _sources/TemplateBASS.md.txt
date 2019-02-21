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
things. In the **reversed** mode, left-clicking will look at things,
right-clicking will do things.

The popup threshold for the GUI is managed by two properties (PopupProportional
and PopupDistance), both of which are considered at the same time. Setting both
to 0 means that the GUI will never appear.

Example:

    // register a GUI to use for the inventory bar
    TwoClickHandler.InventoryGui = gInventoryBar;
    // register a Label to use for action text
    TwoClickHandler.ActionLabel = lblAction;
    // select the reversed button mode (left-click to look, right-click to use)
    TwoClickHandler.ReversedClicks = true;
    // Set the popup threshold for the inventory bar
    TwoClickHandler.PopupProportional = 0.5;        // 50% of the GUI height or
    TwoClickHandler.PopupDistance = 50;             // 50 pixels
---

### TwoClickHandler.InventoryGui

    GUI* TwoClickHandler.InventoryGui

Assigns the [GUI](GUI) which will be used for the inventory.

---

### TwoClickHandler.ActionLabel

    Label* TwoClickHandler.ActionLabel

Assigns the [Label](Label) which will be used to display text descriptions.

---

### TwoClickHandler.ReversedClicks

    bool TwoClickHandler.ReversedClicks

Sets how left and right clicks are processed.

When `true`: left-click to look, right-click to use<br>
When `false`: left-click to use, right-click to look

The default value is `false`.

---

### TwoClickHandler.PopupProportional

    float TwoClickHandler.PopupProportional

Show and hide the inventory GUI when the mouse cursor y value is less than this
proportion of the GUI height. For example, if the inventory GUI has a height of
100 pixels, a value of 0.9 will show the GUI when the mouse cursor distance to
the top of the screen is less than 90 pixels.

The default value is `0.75`.

---

### TwoClickHandler.PopupDistance

    int TwoClickHandler.PopupDistance

Show and hide the inventory when the mouse cursor y value is less than this
value.

The default value is `0` (effectively disabled in favour of PopupProportional).
