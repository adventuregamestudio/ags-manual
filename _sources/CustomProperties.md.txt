## Custom Properties

**What are custom properties?**

Suppose you're making a Lucasarts-style game, and you want all your
hotspots to have a default event (so if the player right-clicks a
window, for example, "Open" will be the default, but if they click on a
pen, "Pick up" will be the default).

To do that, surely you would have to script in lots of code to change
the default mode over each different object?

This is where Custom Properties come to the rescue. You can create a
custom property for "Default event", for example, and then have some
simple code in the global script to use the setting accordingly.

**How do I use them?**

You'll notice that characters, objects, hotspots, rooms and inventory
items all have a "Properties" option in their property grids. Select it
and click the "..." button.

Since you don't yet have any custom properties, you'll get a blank
window, so click the "Edit Schema" button. This takes you to the Schema
Editor, where you can create the various properties you want in your
game. To begin with you are presented with an empty list box, so
right-click in it and choose "Add property".

In the "Add Property" window you can set various options about the new
property:

-   **Name** - this is the name by which you will access the property
    from the script. This cannot be changed after the property has
    been created.
-   **Description** - this is the user-friendly description which will
    be displayed in the custom property editor when you are setting
    the property.
-   **Type** - this specifies what type of property you want. "Boolean"
    gives you a checkbox (which will return 0 or 1 to the script),
    "Number" gives you a text box which you can type numbers into, and
    "Text" gives you a larger text box which can store a string.
-   **Default value** - this specifies what the default value of the
    property will be for objects where you have not set it specifically.

For example, add a new "Boolean" property. Close the schema editor, and
then click the "Properties" button again. You'll now have a window with
a checkbox with the description text you typed in. You can click the
"Edit schema" button there to return to the schema editor if you like.

All types of game item share the same schema. That is, if you create a
"Jibble" property in the schema editor for a hotspot, it will also
appear in the properties window for characters, objects, and so on.

**Getting and setting values in the script**

To access the properties from the script, there are various script
functions. See their descriptions for how they work:

[Character.GetProperty](Character#getproperty)<br>
[Character.GetTextProperty](Character#gettextproperty)<br>
[Character.SetProperty](Character#setproperty)<br>
[Character.SetTextProperty](Character#settextproperty)<br>
[Hotspot.GetProperty](Hotspot#getproperty)<br>
[Hotspot.GetTextProperty](Hotspot#gettextproperty)<br>
[Hotspot.SetProperty](Hotspot#setproperty)<br>
[Hotspot.SetTextProperty](Hotspot#settextproperty)<br>
[InventoryItem.GetProperty](InventoryItem#getproperty)<br>
[InventoryItem.GetTextProperty](InventoryItem#gettextproperty)<br>
[InventoryItem.SetProperty](InventoryItem#setproperty)<br>
[InventoryItem.SetTextProperty](InventoryItem#settextproperty)<br>
[Object.GetProperty](Object#getproperty)<br>
[Object.GetTextProperty](Object#gettextproperty)<br>
[Object.SetProperty](Object#setproperty)<br>
[Object.SetTextProperty](Object#settextproperty)<br>
[Room.GetProperty](Room#getproperty)<br>
[Room.GetTextProperty](Room#gettextproperty)<br>
[Room.SetProperty](Room#setproperty)<br>
[Room.SetTextProperty](Room#settextproperty)

**NOTE:** Calling [ResetRoom](Room#resetroom) will reset that
room's properties to default values, as well as that room's hotspot and
object properties.
