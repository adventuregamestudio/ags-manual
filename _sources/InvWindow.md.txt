GUI InvWindow functions and properties
--------------------------------------

[BringToFront](GUIControl#bringtofront)<br>
[Clickable property](GUIControl#clickable)<br>
[Enabled property](GUIControl#enabled)<br>
[Height property](GUIControl#height)<br>
[ID property](GUIControl#id)<br>
[OwningGUI property](GUIControl#owninggui)<br>
[SendToBack](GUIControl#sendtoback)<br>
[SetPosition](GUIControl#setposition)<br>
[SetSize](GUIControl#setsize)<br>
[Visible property](GUIControl#visible)<br>
[Width property](GUIControl#width)<br>
[X property](GUIControl#x)<br>
[Y property](GUIControl#y)<br>
[ZOrder property](GUIControl#zorder)

[ScrollDown](#scrolldown)<br>
[ScrollUp](#scrollup)<br>
[CharacterToUse property](#charactertouse)<br>
[ItemAtIndex property](#itematindex)<br>
[ItemCount property](#itemcount)<br>
[ItemHeight property](#itemheight)<br>
[ItemWidth property](#itemwidth)<br>
[ItemsPerRow property](#itemsperrow)<br>
[RowCount property](#rowcount)<br>
[TopItem property](#topitem)

---

### ScrollDown

    InvWindow.ScrollDown()

Scrolls the inventory window down one line, if there are more items to
display. If the inventory window is already at the bottom, then nothing
happens.

You would usually use this in response to a GUI button press on a Down
arrow button on your GUI.

Example:

    invMain.ScrollDown();

will scroll the *invMain* inv window down one row.

*See Also:* [InvWindow.ScrollUp](#scrollup),
[InvWindow.TopItem](#topitem)

---

### ScrollUp

    InvWindow.ScrollUp()

Scrolls the inventory window up one line, if there are more items to
display. If the inventory window is already at the top, then nothing
happens.

You would usually use this in response to a GUI button press on an Up
arrow button on your GUI.

Example:

    invMain.ScrollUp();

will scroll the *invMain* inv window up one row.

*See Also:* [InvWindow.ScrollDown](#scrolldown),
[InvWindow.TopItem](#topitem)

---

### CharacterToUse

    Character* InvWindow.CharacterToUse;

Gets/sets which character the inventory window is currently displaying
the inventory for. This is either set to a specific character, or it can
be set to *null*, in which case the inventory window will track the
current player character (this is the default).

Example:

    invMain.CharacterToUse = cJack;

will change the *invMain* inventory window to display character JACK's
inventory.

---

### ItemAtIndex

    readonly InventoryItem* InvWindow.ItemAtIndex[];

Gets the inventory item that is currently displayed at the specified
index in this inventory window. The number of items in the window can be
retrieved with the [ItemCount](#itemcount) property.
Indexes range from 0 to ItemCount - 1.

If an invalid index is supplied, *null* is returned.

Example:

    String firstOne = invMain.ItemAtIndex[0].Name;
    Display("First item is %s.", firstOne);

will display the name of the first item displayed in the *invMain*
inventory window.

*See Also:* [InvWindow.ItemCount](#itemcount)

---

### ItemCount

*(Formerly known as game.num_inv_items, which is now obsolete)*

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

*See Also:* [InvWindow.ItemAtIndex](#itematindex),
[InvWindow.ItemsPerRow](#itemsperrow),
[InvWindow.RowCount](#rowcount)

---

### ItemHeight

*(Formerly known as SetInvDimensions, which is now obsolete)*

    int InvWindow.ItemHeight;

Gets/sets the height of the rows in the inventory window. You should
generally set this up in game_start to the height of your largest
inventory item. The default is 22.

Example:

    invMain.ItemWidth = 50;
    invMain.ItemHeight = 30;

sets the *invMain* inventory window to use item cells 50x30 large.

*See Also:* [InvWindow.ItemWidth](#itemwidth),
[InvWindow.RowCount](#rowcount)

---

### ItemWidth

*(Formerly known as SetInvDimensions, which is now obsolete)*

    int InvWindow.ItemWidth;

Gets/sets the width of the items in the inventory window. You should
generally set this up in game_start to the width of your largest
inventory item. The default is 40.

Example:

    invMain.ItemWidth = 50;
    invMain.ItemHeight = 30;

sets the *invMain* inventory window to use item cells 50x30 large.

*See Also:* [InvWindow.ItemHeight](#itemheight),
[InvWindow.ItemsPerRow](#itemsperrow)

---

### ItemsPerRow

*(Formerly known as game.items_per_line, which is now obsolete)*

    readonly int InvWindow.ItemsPerRow;

Gets the number of items that can be displayed in each row of the
inventory window. This is calculated by the width of the inventory
window divided by the individual ItemWidth.

Example:

    Display("The inventory window can show %d items at a time", invMain.ItemsPerRow * invMain.RowCount);

displays how many items can be visible in the invMain window at once.

*See Also:* [InvWindow.ItemWidth](#itemwidth),
[InvWindow.RowCount](#rowcount)

---

### RowCount

    readonly int InvWindow.RowCount;

Gets the number of rows that can be displayed within the inventory
window. This is calculated by dividing the height of the window by the
individual ItemHeight.

Example:

    Display("The inventory window can show %d items at a time", invMain.ItemsPerRow * invMain.RowCount);

displays how many items can be visible in the invMain window at once.

*See Also:* [InvWindow.ItemHeight](#itemheight),
[InvWindow.ItemsPerRow](#itemsperrow)

---

### TopItem

*(Formerly known as game.top_inv_item, which is now obsolete)*

    int InvWindow.TopItem;

Gets/sets the index of the first item currently displayed in the
inventory window. The first item is represented by 0, and the last item
is has an index of [ItemCount](#itemcount) - 1.

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

*See Also:* [InvWindow.ItemCount](#itemcount)

