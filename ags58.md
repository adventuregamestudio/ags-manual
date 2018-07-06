[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags57.md#topic54)
[![Next](forward.gif)](ags59.md#topic55)

------------------------------------------------------------------------

GUI InvWindow functions and properties
--------------------------------------

[BringToFront (inherited)](ags56.md#GUIControl.BringToFront)\
[Clickable property (inherited)](ags56.md#GUIControl.Clickable)\
[Enabled property (inherited)](ags56.md#GUIControl.Enabled)\
[Height property (inherited)](ags56.md#GUIControl.Height)\
[ID property (inherited)](ags56.md#GUIControl.ID)\
[OwningGUI property (inherited)](ags56.md#GUIControl.OwningGUI)\
[SendToBack (inherited)](ags56.md#GUIControl.SendToBack)\
[SetPosition (inherited)](ags56.md#GUIControl.SetPosition)\
[SetSize (inherited)](ags56.md#GUIControl.SetSize)\
[Visible property (inherited)](ags56.md#GUIControl.Visible)\
[Width property (inherited)](ags56.md#GUIControl.Width)\
[X property (inherited)](ags56.md#GUIControl.X)\
[Y property (inherited)](ags56.md#GUIControl.Y)\
[ZOrder property (inherited)](ags56.md#GUIControl.ZOrder)

[ScrollDown (inv window)](#InvWindow.ScrollDown)\
[ScrollUp (inv window)](#InvWindow.ScrollUp)\
[CharacterToUse property](#InvWindow.CharacterToUse)\
[ItemAtIndex property](#InvWindow.ItemAtIndex)\
[ItemCount property (inv window)](#InvWindow.ItemCount)\
[ItemHeight property](#InvWindow.ItemHeight)\
[ItemWidth property](#InvWindow.ItemWidth)\
[ItemsPerRow property](#InvWindow.ItemsPerRow)\
[RowCount property (inv window)](#InvWindow.RowCount)\
[TopItem property (inv window)](#InvWindow.TopItem)\

------------------------------------------------------------------------

[]()

### ScrollDown (inv window)

    InvWindow.ScrollDown()

Scrolls the inventory window down one line, if there are more items to
display. If the inventory window is already at the bottom, then nothing
happens.

You would usually use this in response to a GUI button press on a Down
arrow button on your GUI.

Example:

    invMain.ScrollDown();

will scroll the *invMain* inv window down one row.

*See Also:* [InvWindow.ScrollUp](ags58.md#InvWindow.ScrollUp),
[InvWindow.TopItem](ags58.md#InvWindow.TopItem)

------------------------------------------------------------------------

[]()

### ScrollUp (inv window)

    InvWindow.ScrollUp()

Scrolls the inventory window up one line, if there are more items to
display. If the inventory window is already at the top, then nothing
happens.

You would usually use this in response to a GUI button press on an Up
arrow button on your GUI.

Example:

    invMain.ScrollUp();

will scroll the *invMain* inv window up one row.

*See Also:* [InvWindow.ScrollDown](ags58.md#InvWindow.ScrollDown),
[InvWindow.TopItem](ags58.md#InvWindow.TopItem)

------------------------------------------------------------------------

[]()

### CharacterToUse property

    Character* InvWindow.CharacterToUse;

Gets/sets which character the inventory window is currently displaying
the inventory for. This is either set to a specific character, or it can
be set to *null*, in which case the inventory window will track the
current player character (this is the default).

Example:

    invMain.CharacterToUse = cJack;

will change the *invMain* inventory window to display character JACK's
inventory.

------------------------------------------------------------------------

[]()

### ItemAtIndex property

    readonly InventoryItem* InvWindow.ItemAtIndex[];

Gets the inventory item that is currently displayed at the specified
index in this inventory window. The number of items in the window can be
retrieved with the [ItemCount](ags58.md#InvWindow.ItemCount) property.
Indexes range from 0 to ItemCount - 1.

If an invalid index is supplied, *null* is returned.

Example:

    String firstOne = invMain.ItemAtIndex[0].Name;
    Display("First item is %s.", firstOne);

will display the name of the first item displayed in the *invMain*
inventory window.

*See Also:* [InvWindow.ItemCount](ags58.md#InvWindow.ItemCount)

------------------------------------------------------------------------

[]()

### ItemCount property (inv window)

*(Formerly known as game.num\_inv\_items, which is now obsolete)*

    readonly int InvWindow.ItemCount;

Gets the total number of items contained in the inventory window. This
will tend to equal the total number of items that the character has
(though it may not if the "Display multiple items multiple times" game
setting is not checked).

Example:

    if (invMain.ItemCount > (invMain.ItemsPerRow * invMain.RowCount)) {
      btnInvUp.Enabled = true;
      btnInvDown.Enabled = false;
    }

will enable the GUI buttons *btnInvUp* and *btnInvDown* if there are
more inventory items than will fit in the inventory window.

*See Also:* [InvWindow.ItemAtIndex](ags58.md#InvWindow.ItemAtIndex),
[InvWindow.ItemsPerRow](ags58.md#InvWindow.ItemsPerRow),
[InvWindow.RowCount](ags58.md#InvWindow.RowCount)

------------------------------------------------------------------------

[]()

### ItemHeight property

*(Formerly known as SetInvDimensions, which is now obsolete)*

    int InvWindow.ItemHeight;

Gets/sets the height of the rows in the inventory window. You should
generally set this up in game\_start to the height of your largest
inventory item. The default is 22.

Example:

    invMain.ItemWidth = 50;
    invMain.ItemHeight = 30;

sets the *invMain* inventory window to use item cells 50x30 large.

*See Also:* [InvWindow.ItemWidth](ags58.md#InvWindow.ItemWidth),
[InvWindow.RowCount](ags58.md#InvWindow.RowCount)

------------------------------------------------------------------------

[]()

### ItemWidth property

*(Formerly known as SetInvDimensions, which is now obsolete)*

    int InvWindow.ItemWidth;

Gets/sets the width of the items in the inventory window. You should
generally set this up in game\_start to the width of your largest
inventory item. The default is 40.

Example:

    invMain.ItemWidth = 50;
    invMain.ItemHeight = 30;

sets the *invMain* inventory window to use item cells 50x30 large.

*See Also:* [InvWindow.ItemHeight](ags58.md#InvWindow.ItemHeight),
[InvWindow.ItemsPerRow](ags58.md#InvWindow.ItemsPerRow)

------------------------------------------------------------------------

[]()

### ItemsPerRow property

*(Formerly known as game.items\_per\_line, which is now obsolete)*

    readonly int InvWindow.ItemsPerRow;

Gets the number of items that can be displayed in each row of the
inventory window. This is calculated by the width of the inventory
window divided by the individual ItemWidth.

Example:

    Display("The inventory window can show %d items at a time", invMain.ItemsPerRow * invMain.RowCount);

displays how many items can be visible in the invMain window at once.

*See Also:* [InvWindow.ItemWidth](ags58.md#InvWindow.ItemWidth),
[InvWindow.RowCount](ags58.md#InvWindow.RowCount)

------------------------------------------------------------------------

[]()

### RowCount property (inv window)

    readonly int InvWindow.RowCount;

Gets the number of rows that can be displayed within the inventory
window. This is calculated by dividing the height of the window by the
individual ItemHeight.

Example:

    Display("The inventory window can show %d items at a time", invMain.ItemsPerRow * invMain.RowCount);

displays how many items can be visible in the invMain window at once.

*See Also:* [InvWindow.ItemHeight](ags58.md#InvWindow.ItemHeight),
[InvWindow.ItemsPerRow](ags58.md#InvWindow.ItemsPerRow)

------------------------------------------------------------------------

[]()

### TopItem property (inv window)

*(Formerly known as game.top\_inv\_item, which is now obsolete)*

    int InvWindow.TopItem;

Gets/sets the index of the first item currently displayed in the
inventory window. The first item is represented by 0, and the last item
is has an index of [ItemCount](ags58.md#InvWindow.ItemCount) - 1.

You can use this to work out whether to display scroll arrows or not.

Example:

    if (invMain.TopItem > 0) {
      btnScrollUp.Visible = true;
    }
    else {
      btnScrollUp.Visible = false;
    }

makes the *btnScrollUp* button visible or invisible depending on whether
the inventory list can be scrolled up.

*See Also:* [InvWindow.ItemCount](ags58.md#InvWindow.ItemCount)


