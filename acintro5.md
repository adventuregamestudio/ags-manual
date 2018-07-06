**Getting Started with AGS - Part 5** {#getting-started-with-ags---part-5 align="center"}
-------------------------------------

 

### Managing Inventory

Each character in the game can carry their own set of inventory items.
Inventory items are totally separate from room objects, and you must
explicitly set up every item which the player can carry at some point in
the game.

Go to the "Inventory items" node in the project tree. We visited this
briefly in part 4, but it's time to go into a bit more detail. 

*![](images/intro4_3.jpg){width="469" height="387"}\
The inventory editor, another look*

Every inventory item that the player can carry at some point during the
game is listed in the project tree. All the items there also have a
number beside them - this is the inventory item ID, which is largely for
backwards compatibility with older versions of AGS.

To edit an inventory item, double-click it in the project tree, and a
new window will open up with the item's properties in the property grid.
If you want the player character to start off carrying the selected
item, set the "PlayerStartsWithItem" option to True. Remember, if you
want to change which image is used for the item, select the "Image"
property and click the "..." button.

Now, you may have noticed that once the player had picked up the key in
our game, they could see it in their inventory window but not actually
do anything to it - clicking Look or Use on the item did nothing.

In order to give the inventory item some interactivity, we once again
need to call on the Events List. Click the "Events" (lightning) button
to bring it up:

*![](images/intro5_1.jpg){width="544" height="394"}\
The events list... this time for inventory*

Now, the important point to note here is that if you are using the
built-in inventory window (which we are), the only events which can
occur are "Look at inventory item" and "Use inventory on this item".
This is because the default inventory window only has Look and Select
options. The other modes are all available if you design your own
inventory GUI (but that's quite complex so we'll leave it for later).

So, select the "Look at inventory item" event, and click the "..."
button. You'll be taken to the script editor once more, but this time
you'll notice that there's already some existing script as well as our
new method:

*![](images/intro5_2.jpg){width="544" height="394"}\
Script for looking at the key*

#### <span style="font-weight: 400">We are now editing the *global script*. This has all the script for handling events on game-wide things like inventory items and characters. Previously we were working with hotspots and objects, so they were confined to their own *room script*.</span> {#we-are-now-editing-the-global-script.-this-has-all-the-script-for-handling-events-on-game-wide-things-like-inventory-items-and-characters.-previously-we-were-working-with-hotspots-and-objects-so-they-were-confined-to-their-own-room-script. dir="ltr"}

Anyway, for now I've just added a simple Display command to show the
player a message when they look at the key. Feel free to do something
similar.

#### Inventory item hotspots

By default, when the player selects an inventory item as their mouse
cursor and clicks on the screen with it, the centre of the item will be
used to decide what to activate. However, with some items you may well
not want this behaviour - for example, we might want the end of our key
to be the activation spot.

To set the cursor hotspot, simply click on the spot within the image.
You should see a crosshair appear where you clicked.

The "Draw crosshair" option, if activated, will draw a spot on this part
of the item in-game so that the player can easily tell which bit of the
cursor is active. You can set the inner and outer colours for the
crosshair.

#### Recap

-   Inventory items are **not** objects. The two are totally seperate,
    although often picking up an object will give the player an
    inventory item.
-   Each character has their own inventory. If you are making a game
    like Day of the Tentacle, where the player can switch between
    characters, then they will each have their own set of inventory
    items. Usually, you'll use inventory commands to operate on the
    current player character.
-   To give the player an inventory item, use the
    `         player.AddInventory` command.

 

**Go to part 6:** [Using your own graphics](acintro6.md)

Tutorial last updated 17 August 2007. Copyright (c) 2001-2007 Chris
Jones.
