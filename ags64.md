[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags63.md#topic59)
[![Next](forward.gif)](ags65.md#topic61)

------------------------------------------------------------------------

Inventory item functions and properties
---------------------------------------

[GetAtScreenXY (inventory)](#InventoryItem.GetAtScreenXY)\
[GetProperty (inventory)](#InventoryItem.GetProperty)\
[GetTextProperty (inventory)](#InventoryItem.GetTextProperty)\
[SetProperty (inventory)](#InventoryItem.SetProperty)\
[SetTextProperty (inventory)](#InventoryItem.SetTextProperty)\
[IsInteractionAvailable
(inventory)](#InventoryItem.IsInteractionAvailable)\
[RunInteraction (inventory)](#InventoryItem.RunInteraction)\
[CursorGraphic property (inventory)](#InventoryItem.CursorGraphic)\
[Graphic property (inventory)](#InventoryItem.Graphic)\
[ID property (inventory)](#InventoryItem.ID)\
[Name property (inventory)](#InventoryItem.Name)\

------------------------------------------------------------------------

[]()

### GetAtScreenXY (inventory)

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

*See Also:* [InventoryItem.Name](ags64.md#InventoryItem.Name),
[Game.GetLocationName](ags54.md#Game.GetLocationName)

------------------------------------------------------------------------

[]()

### GetProperty (inventory)

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
[InventoryItem.GetTextProperty](ags64.md#InventoryItem.GetTextProperty)

------------------------------------------------------------------------

[]()

### GetTextProperty (inventory)

*(Formerly known as GetInvPropertyText, which is now obsolete)*\
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
[InventoryItem.GetProperty](ags64.md#InventoryItem.GetProperty)

------------------------------------------------------------------------

[]()

### SetProperty (inventory)

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
[InventoryItem.SetTextProperty](ags64.md#InventoryItem.SetTextProperty)

------------------------------------------------------------------------

[]()

### SetTextProperty (inventory)

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
[InventoryItem.SetProperty](ags64.md#InventoryItem.SetProperty)

------------------------------------------------------------------------

[]()

### IsInteractionAvailable (inventory)

*(Formerly known as IsInventoryInteractionAvailable, which is now
obsolete)*

    InventoryItem.IsInteractionAvailable(CursorMode)

Checks whether there is an event handler defined for activating the
inventory item in cursor mode MODE.

This function is very similar to RunInteraction, except that rather than
run the event handler script function, it simply returns *true* if
something would have happened, or *false* if unhandled\_event would have
been run.

This is useful for enabling options on a verb-coin style GUI, for
example.

Example:

    if (iKeyring.IsInteractionAvailable(eModeLookat) == 0)
      Display("looking at this item would not do anything.");

*See Also:* [IsInteractionAvailable](ags54.md#IsInteractionAvailable),
[InventoryItem.RunInteraction](ags64.md#InventoryItem.RunInteraction)

------------------------------------------------------------------------

[]()

### RunInteraction (inventory)

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
[InventoryItem.IsInteractionAvailable](ags64.md#InventoryItem.IsInteractionAvailable),
[Room.ProcessClick](ags73.md#Room.ProcessClick),
[Character.RunInteraction](ags47.md#Character.RunInteraction)

------------------------------------------------------------------------

[]()

### CursorGraphic property (inventory)

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

*See Also:* [InventoryItem.Graphic](ags64.md#InventoryItem.Graphic)

------------------------------------------------------------------------

[]()

### Graphic property (inventory)

*(Formerly known as GetInvGraphic, which is now obsolete)*\
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
[InventoryItem.CursorGraphic](ags64.md#InventoryItem.CursorGraphic),
[InventoryItem.GetAtScreenXY](ags64.md#InventoryItem.GetAtScreenXY),
[InventoryItem.Name](ags64.md#InventoryItem.Name)

------------------------------------------------------------------------

[]()

### ID property (inventory)

    readonly int InventoryItem.ID

Gets the inventory item's ID number. This is the item's number from the
editor, and is useful with commands such as Character.AddInventory which
require an inventory number to add.

Example:

    AddInventory(EGO, iShovel.ID);

uses the obsolete AddInventory command to add the shovel to EGO's
inventory

*See Also:* [Character.AddInventory](ags47.md#Character.AddInventory),
[Character.LoseInventory](ags47.md#Character.LoseInventory)

------------------------------------------------------------------------

[]()

### Name property (inventory)

*(Formerly known as GetInvName, which is now obsolete)*\
*(Formerly known as SetInvItemName, which is now obsolete)*\
*(Formerly known as InventoryItem.GetName, which is now obsolete)*\
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
[InventoryItem.GetAtScreenXY](ags64.md#InventoryItem.GetAtScreenXY),
[InventoryItem.Graphic](ags64.md#InventoryItem.Graphic),
[Game.GetLocationName](ags54.md#Game.GetLocationName)


