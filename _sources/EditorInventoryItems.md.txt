# Inventory Items Editor

A place to edit Items that can be placed on the [inventory](Settingupthegame#inventory) by the player.

![Screenshot Inventory Item Editor](images/EditorInventoryItems_img1.png)


_Cursor Image_: The image number from the [Sprite Manager](EditorSprite) that is displayed as active cursor image when selecting this inventory item from the Inventory to use it on other Inventory Items or somewhere inside your scene. You set the active hotspot, there where the click from that mouse cursor is detected, by clicking on the right image in the inventory item settings. Or you set the hotspot value by hand with the HotspotX and HotspotY Value explained below.
This image is usually a bit smaller than the normal image of the inventory item inside the inventory covered later.

_Description:_ The name of the item that is displayed for example on [@OVERHOTSPOT@] when the mouse is over the inventory item still in the inventory.

_Image:_ The image displayed for the inventory item within the normal AGS inventory. Usually a bit bigger than the mouse cursor image of the inventory item.


_HotspotX:_ Select the X Value of the active cursor image by hand. It's the distance from the left border in pixels. You can also set this value by clicking on the right image in the inventory item settings.

_HotspotY:_ Select the Y Value of the active cursor image by hand. It's the distance from the top border in pixels. You can also set this value by clicking on the right image in the inventory item settings.

_ID:_ The internal ID of this inventory Item. This value cannot be changed, it can be read only by script with the call [InventoryItem.ID](InventoryItem#id).

_Name:_ The script name of the inventory item. Usually the convention is to start inventory item names with an i, like _iKey_.

_PlayerStartsWithItem:_ Is a boolean value that means what it says, if the player character starts with this inventory item in his inventory.

Within the game the player can pick up and inventory items to his inventory by interacting with the scene or other characters. You add it to his inventory with the [cChar.AddInventory(iInvItem)](Character#addinventory) function. When the player uses or gives away the item you remove it from the character's inventory with the [cChar.LoseInventory(iInvItem)](Character#loseinventory) function. Make sure you should check the [mousemode] afterwards, especially when the active cursor is the inventory item the player just lost.


See Also: [InventoryItem](InventoryItem)
