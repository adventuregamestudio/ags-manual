Event Types
-----------

The following events are available in the "Events" section of the
Properties Window (when clicking the lightning bolt icon).

[Hotspot events](#hotspot-events)<br>
[Object events](#object-events)<br>
[Room events](#room-events)<br>
[Inventory item events](#inventory-item-events)<br>
[Character events](#character-events)<br>
[Region events](#region-events)

---

### Hotspot events

Player stands on hotspot

occurs repeatedly while the player character is standing on the hotspot.

Look at hotspot

occurs when the player clicks on the hotspot while in the "Look" mode
(cursor mode 1).

Interact with hotspot

occurs when the player clicks on the hotspot while in the "Interact"
mode (cursor mode 2).

Use inventory on hotspot

occurs when the player clicks on the hotspot while in the "Use
inventory" mode (cursor mode 4). You can use the
[player.ActiveInventory](Character#activeinventory) property
to distinguish which item they used.

Speak to hotspot

occurs when the player clicks on the hotspot while in the "Talk" mode
(cursor mode 3).

Any click on hotspot

occurs when the player clicks on the hotspot in any cursor mode (except
Walk). This allows you to add extra modes like smell, taste, push, pull,
and so on. This event also occurs as well as the other event for the
Look, Interact and Talk modes.

Mouse moves over hotspot

occurs repeatedly while the mouse cursor is over the hotspot. You can
use this to highlight the cursor, and for other various effects.

---

### Object events

Look at object

occurs when the player clicks on the object while in the "Look" mode
(cursor mode 1).

Interact with object

occurs when the player clicks on the object in the "Interact" mode
(cursor mode 2).

Speak to object

occurs when the player clicks on the object in the "Talk" mode (cursor
mode 3).

Use inventory on object

works like "Use inventory on hotspot" - see that description (above) for
more information.

---

### Room events

Walk off left

occurs when the player character walks off the left edge of the screen.

Walk off right

occurs when the player walks off the right edge of the screen.

Walk off bottom

occurs when the player character walks off the bottom edge of the
screen.

Walk off top

occurs when the player character walks off the top edge of the screen.

First time enters room

occurs the first time the player enters the room. This event occurs
AFTER the screen has faded in, so it allows you to display a message
describing the scene.

Player enters room (before fadein)

occurs just after the room is loaded into memory. This event occurs
every time the player enters the screen, and it happens BEFORE the
screen has faded in, which allows you to change object graphics and do
other things to the screen which the player won't notice.

*NOTE: This event is ONLY meant for adjusting things such as object and
character placement. Do NOT use this event for any sort of automated
intro to the room - use the "Enters Room After Fade In" event for that
instead.*

Repeatedly execute

occurs repeatedly on every interpreter cycle. The normal game speed is
40 cycles per second, so this event occurs about every 25 milliseconds.

Player enters room (after fadein)

occurs every time the player enters the room, AFTER the screen has
faded-in. Suitable for displaying text descriptions and so on, that you
want the player to see.

Player leaves room

occurs when the player leaves the screen, just before the screen fades
out.

---

### Inventory item events

Look at inventory

occurs when the player clicks on the inventory item while in the "look"
mode.

Interact with inventory

currently, because the Interact mode selects the inventory item, this
event can only be triggered by manually calling the
InventoryItem.RunInteraction script function (ie. you have to use the
Handle Inv Clicks in Script option).

Speak to inventory

only applies to the Lucasarts-style inventory, occurs when the player
clicks the Talk icon on the inventory item.

Use inventory on inv

occurs when the player uses another inventory object on this one. You
can use the
[player.ActiveInventory](Character#activeinventory) property
to distinguish which item they used.<br>
This event allows the player to combine items, and so on. For example,
if they had picked up a laptop computer and a battery separately, then
you could use this to allow them to insert the battery into the
computer.

Other click on inventory

only applies to the Lucasarts-style inventory, occurs when the player
clicks any other cursor mode (apart from look, talk and use_inv) on the
item.

---

### Character events

Look at character

occurs when the player clicks on a character while in the "look" mode.

Interact with character

occurs when the player clicks on a character while in the "interact"
mode.

Speak to character

occurs when the player clicks on a character while in the "talk" mode.

Use inventory on character

occurs when the player uses an inventory object on a character. This
event could be used to allow the player to give items to characters.

Any click on character

occurs when the player clicks any other cursor mode (apart from look,
talk and use_inv) on the character.

---

### Region events

While player stands on region

occurs repeatedly while the player character stands on this region

Player walks onto region

occurs when the player moves from another region onto this one. Will
also activate on whichever region they start on when they enter the
screen.

Player walks off region

occurs when the player leaves the current region. Does not occur if they
go to a different room.

