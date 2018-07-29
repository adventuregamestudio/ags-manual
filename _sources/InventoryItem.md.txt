Inventory item functions and properties
---------------------------------------

[GetAtScreenXY](#getatscreenxy)<br>
[GetProperty](#getproperty)<br>
[GetTextProperty](#gettextproperty)<br>
[SetProperty](#setproperty)<br>
[SetTextProperty](#settextproperty)<br>
[IsInteractionAvailable (inventory)](#isinteractionavailable)<br>
[RunInteraction](#runinteraction)<br>
[CursorGraphic property](#cursorgraphic)<br>
[Graphic property](#graphic)<br>
[ID property](#id)<br>
[Name property](#name)

---

### GetAtScreenXY

*(Formerly known as global function GetInvAt, which is now obsolete)*

    static InventoryItem* InventoryItem.GetAtScreenXY(int x, int y)

Returns the inventory item at SCREEN co-ordinates (X,Y). Note that this
only detects inventory items on custom Inventory windows (that are
switched on when this function is called), and is intended to allow you
to do Verb Coin style GUIs and so on.

If there is no inventory item there, or if invalid co-ordinates are
specified, returns null.

**NOTE:** The co-ordinates are SCREEN co-ordinates, NOT ROOM
co-ordinates. This means that with a scrolling room, the co-ordinates
you pass are relative to the screen's current position, and NOT absolute
room co-ordinates. This means that this function is suitable for use
with the mouse cursor position variables.

Example:

    InventoryItem *item = InventoryItem.GetAtScreenXY(mouse.x, mouse.y);
    if (item == null) {
      Display("No inventory item at the mouse co-ordinates");
    }
    else {
      Display("Inventory item number %d at the mouse.", item.ID);
    }

will display the number of the inv item that the mouse is over

*See Also:* [InventoryItem.Name](#name),
[Game.GetLocationName](Game#getlocationname)

---

### GetProperty

*(Formerly known as GetInvProperty, which is now obsolete)*

    InventoryItem.GetProperty(string property)

Returns the custom property setting PROPERTY for the inventory item.

This command works with Number properties (it returns the number), and
with Boolean properties (returns 1 if the box was checked, 0 if not).

Use the equivalent GetTextProperty function to get a text property.

Example:

    if (inventory[1].GetProperty("Value") > 200)
      Display("Inventory item 1's value is over 200!");

will print the message if inventory item 1 has its "Value" property set
to more than 200.

*See Also:*
[InventoryItem.GetTextProperty](#gettextproperty)

---

### GetTextProperty

*(Formerly known as GetInvPropertyText, which is now obsolete)*<br>
*(Formerly known as InventoryItem.GetPropertyText, which is now
obsolete)*

    String InventoryItem.GetTextProperty(string property)

Returns the custom property setting PROPERTY for the inventory item.

This command works with Text properties only. The property's text will
be returned from this function.

Use the equivalent GetProperty function to get a non-text property.

Example:

    String description = inventory[2].GetTextProperty("Description");
    Display("Inv item 2's description: %s", description);

will retrieve inv item 2's "description" property and display it.

*See Also:*
[InventoryItem.GetProperty](#getproperty)

---

### SetProperty

    bool InventoryItem.SetProperty(const string property, int value)

Sets the new *value* for the custom *property* for the specified
inventory item. Returns TRUE if such property exists and FALSE on
failure.

This command works with Number properties (it sets the numeric value),
and with Boolean properties (sets FALSE is value is equal to 0, or TRUE
otherwise).

Use the equivalent SetTextProperty function to set new text property
value.

Example:

    iStone.SetProperty("Weight", 120);

will change Stone's "weight" custom property to 120.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:*
[InventoryItem.SetTextProperty](#settextproperty)

---

### SetTextProperty

    bool InventoryItem.SetTextProperty(const string property, const string value)

Sets the new *value* text for the custom *property* for the specified
inventory item. Returns TRUE if such property exists and FALSE on
failure.

This command works with Text properties only. The property's text will
be changed to new value.

Use the equivalent SetProperty function to set a non-text property.

Example:

    iKey.SetTextProperty("Description", "A rusty key");

will change key's "description" property.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:*
[InventoryItem.SetProperty](#setproperty)

---

### IsInteractionAvailable

*(Formerly known as IsInventoryInteractionAvailable, which is now
obsolete)*

    InventoryItem.IsInteractionAvailable(CursorMode)

Checks whether there is an event handler defined for activating the
inventory item in cursor mode MODE.

This function is very similar to RunInteraction, except that rather than
run the event handler script function, it simply returns *true* if
something would have happened, or *false* if unhandled_event would have
been run.

This is useful for enabling options on a verb-coin style GUI, for
example.

Example:

    if (iKeyring.IsInteractionAvailable(eModeLookat) == 0)
      Display("looking at this item would not do anything.");

*See Also:* [IsInteractionAvailable](Game#isinteractionavailable),
[InventoryItem.RunInteraction](#runinteraction)

---

### RunInteraction

*(Formerly known as RunInventoryInteraction, which is now obsolete)*

    InventoryItem.RunInteraction(CursorMode)

Runs the event handler as if the player had clicked the mouse on the
inventory item, using the specified cursor mode.

Example:

    if (button == eMouseLeftInv)
      inventory[game.inv_activated].RunInteraction(mouse.Mode);

will run the inventory event handler for the current cursor mode when
the player clicks on the item (Handle Inv Clicks needs to be enabled for
this to work)

*See Also:*
[InventoryItem.IsInteractionAvailable](#isinteractionavailable),
[Room.ProcessClick](Room#processclick),
[Character.RunInteraction](Character#runinteraction)

---

### CursorGraphic

    int InventoryItem.CursorGraphic

Gets/sets the sprite slot number of the inventory item's mouse cursor.
This is the sprite used as the mouse cursor when this inventory item is
selected.

**NOTE:** This property is only used if the "Use selected inventory
graphic for cursor" setting in General Settings is turned on.

Example:

    Display("The key's cursor graphic is %d", iKey.CursorGraphic);

will display inventory item *iKey*'s cursor graphic.

*Compatibility:* Supported by **AGS 3.1.2** and later versions.

*See Also:* [InventoryItem.Graphic](#graphic)

---

### Graphic

*(Formerly known as GetInvGraphic, which is now obsolete)*<br>
*(Formerly known as SetInvItemPic, which is now obsolete)*

    int InventoryItem.Graphic

Gets/sets the sprite slot number of the inventory item. You could use
this with the Object.Graphic property as a means of the player
'dropping' an inventory item, or it may be useful if you want to do a
Raw Drawn inventory window.

**NOTE:** For backwards compatibility, if you change this property and
the CursorGraphic currently has the same sprite as the main Graphic,
then the CursorGraphic will be changed too.

Example:

    int slot = player.ActiveInventory.Graphic;

will place the sprite number of the player's current inventory item into
slot.

*See Also:*
[InventoryItem.CursorGraphic](#cursorgraphic),
[InventoryItem.GetAtScreenXY](#getatscreenxy),
[InventoryItem.Name](#name)

---

### ID

    readonly int InventoryItem.ID

Gets the inventory item's ID number. This is the item's number from the
editor, and is useful with commands such as Character.AddInventory which
require an inventory number to add.

Example:

    AddInventory(EGO, iShovel.ID);

uses the obsolete AddInventory command to add the shovel to EGO's
inventory

*See Also:* [Character.AddInventory](Character#addinventory),
[Character.LoseInventory](Character#loseinventory)

---

### Name

*(Formerly known as GetInvName, which is now obsolete)*<br>
*(Formerly known as SetInvItemName, which is now obsolete)*<br>
*(Formerly known as InventoryItem.GetName, which is now obsolete)*<br>
*(Formerly known as InventoryItem.SetName, which is now obsolete)*

    String InventoryItem.Name;

Gets/sets the name of the inventory item. This is the name which is
initially set under the Game tab, Inventory mode of the AGS Editor.

You can change this property if for example you want to change a 'bowl'
to a 'bowl with water in' but want to use the same inventory item for
it.

Note that the maximum length for the name of an inventory item is 24
characters - if the name you set is longer than this, it will be
truncated.

Example:

    Display("Active inventory: %s", player.ActiveInventory.Name);

will display the name of the player's current inventory item.

*See Also:*
[InventoryItem.GetAtScreenXY](#getatscreenxy),
[InventoryItem.Graphic](#graphic),
[Game.GetLocationName](Game#getlocationname)

