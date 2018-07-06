[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags62.md#topic58)
[![Next](forward.gif)](ags64.md#topic60)

------------------------------------------------------------------------

Hotspot functions and properties
--------------------------------

[GetAtScreenXY (hotspot)](#Hotspot.GetAtScreenXY)\
[GetProperty (hotspot)](#Hotspot.GetProperty)\
[GetTextProperty (hotspot)](#Hotspot.GetTextProperty)\
[SetProperty (hotspot)](#Hotspot.SetProperty)\
[SetTextProperty (hotspot)](#Hotspot.SetTextProperty)\
[IsInteractionAvailable (hotspot)](#Hotspot.IsInteractionAvailable)\
[RunInteraction (hotspot)](#Hotspot.RunInteraction)\
[Enabled property (hotspot)](#Hotspot.Enabled)\
[ID property (hotspot)](#Hotspot.ID)\
[Name property (hotspot)](#Hotspot.Name)\
[WalkToX property](#Hotspot.WalkToX)\
[WalkToY property](#Hotspot.WalkToY)\

------------------------------------------------------------------------

[]()

### GetAtScreenXY (hotspot)

*(Formerly known as global function GetHotspotAt, which is now
obsolete)*

    static Hotspot* Hotspot.GetAtScreenXY(int x, int y)

Returns the hotspot at SCREEN co-ordinates (X,Y). If there is no hotspot
there, or if invalid co-ordinates are specified, the Hotspot\*
representing hotspot 0 will be returned.

**NOTE:** The co-ordinates are SCREEN co-ordinates, NOT ROOM
co-ordinates. This means that with a scrolling room, the co-ordinates
you pass are relative to the screen's current position, and NOT absolute
room co-ordinates. This means that this function is suitable for use
with the mouse cursor position variables.

Example:

    if (Hotspot.GetAtScreenXY(mouse.x, mouse.y) == hDoor)
      Display("Mouse on the door");
    else if (Hotspot.GetAtScreenXY(mouse.x, mouse.y) != hotspot[0])
      Display("Mouse is on something (but not the door)!");
    else
      Display("Mouse not on a hotspot");

will display a message depending on what the mouse is on.

*See Also:* [Game.GetLocationName](ags54.md#Game.GetLocationName),
[GetLocationType](ags54.md#GetLocationType)

------------------------------------------------------------------------

[]()

### GetProperty (hotspot)

*(Formerly known as GetHotspotProperty, which is now obsolete)*

    Hotspot.GetProperty(string property)

Returns the custom property setting of the PROPERTY for the hotspot.

This command works with Number properties (it returns the number), and
with Boolean properties (returns 1 if the box was checked, 0 if not).

Use the equivalent GetTextProperty function to get a text property.

Example:

    if (hotspot[1].GetProperty("Value") > 200)
      Display("Hotspot 1's value is over 200!");

will print the message if hotspot 1 has its "Value" property set to more
than 200.

*See Also:* [Hotspot.GetTextProperty](ags63.md#Hotspot.GetTextProperty)

------------------------------------------------------------------------

[]()

### GetTextProperty (hotspot)

*(Formerly known as GetHotspotPropertyText, which is now obsolete)*\
*(Formerly known as Hotspot.GetPropertyText, which is now obsolete)*

    String Hotspot.GetTextProperty(string property)

Returns the custom property setting of the PROPERTY for the hotspot.

This command works with Text properties only. The property's text will
be returned from this function.

Use the equivalent GetProperty function to get a non-text property.

Example:

    String description = hotspot[2].GetTextProperty("Description");
    Display("Hotspot 2's description: %s", description);

will retrieve hotspot 2's "description" property and display it.

*See Also:* [Hotspot.GetProperty](ags63.md#Hotspot.GetProperty)

------------------------------------------------------------------------

[]()

### SetProperty (hotspot)

    bool Hotspot.SetProperty(const string property, int value)

Sets the new *value* for the custom *property* for the specified
hotspot. Returns TRUE if such property exists and FALSE on failure.

This command works with Number properties (it sets the numeric value),
and with Boolean properties (sets FALSE is value is equal to 0, or TRUE
otherwise).

Use the equivalent SetTextProperty function to set new text property
value.

Example:

    hDoor.SetProperty("LockDifficulty", 5);

will change Door hotspot's "LockDifficulty" custom property to 5.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Hotspot.SetTextProperty](ags63.md#Hotspot.SetTextProperty)

------------------------------------------------------------------------

[]()

### SetTextProperty (hotspot)

    bool Hotspot.SetTextProperty(const string property, const string value)

Sets the new *value* text for the custom *property* for the specified
hotspot. Returns TRUE if such property exists and FALSE on failure.

This command works with Text properties only. The property's text will
be changed to new value.

Use the equivalent SetProperty function to set a non-text property.

Example:

    hDoor.SetTextProperty("Description", "The sturdy door");

will change Door's "description" property.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Hotspot.SetProperty](ags63.md#Hotspot.SetProperty)

------------------------------------------------------------------------

[]()

### IsInteractionAvailable (hotspot)

    Hotspot.IsInteractionAvailable(CursorMode)

Checks whether there is an event handler defined for activating the
hotspot in cursor mode MODE.

This function is very similar to RunInteraction, except that rather than
run the event handler script function, it simply returns *true* if
something would have happened, or *false* if unhandled\_event would have
been run.

Example:

    if (hTable.IsInteractionAvailable(eModeLookat) == 0)
      Display("looking on this table would not do anything.");

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [IsInteractionAvailable](ags54.md#IsInteractionAvailable),
[Hotspot.RunInteraction](ags63.md#Hotspot.RunInteraction)

------------------------------------------------------------------------

[]()

### RunInteraction (hotspot)

*(Formerly known as RunHotspotInteraction, which is now obsolete)*

    Hotspot.RunInteraction(CursorMode)

Processes the event handler as if the player had clicked the mouse on
the hotspot using the specified cursor mode.

Example:

    hDoor.RunInteraction(eModeLookat);

will run the code defined in the "LOOK AT HOTSPOT" event for hotspot
hDoor.

*See Also:* [Room.ProcessClick](ags73.md#Room.ProcessClick),
[Hotspot.IsInteractionAvailable](ags63.md#Hotspot.IsInteractionAvailable),
[Character.RunInteraction](ags47.md#Character.RunInteraction),
[Object.RunInteraction](ags68.md#Object.RunInteraction)

------------------------------------------------------------------------

[]()

### Enabled property (hotspot)

*(Formerly known as DisableHotspot, which is now obsolete)*\
*(Formerly known as EnableHotspot, which is now obsolete)*

    bool Hotspot.Enabled

Enables/disables the specified hotspot. If you set this to false, then
all areas of the screen that were previously made up of the hotspot now
act as type 0 (no hotspot). You can turn the hotspot back on later by
setting this back to true.

This setting is persisted in-game; that is, it will not be reset when
the player re-enters the room.

The default value of this property is always *true*.

Example:

    hBrownTree.Enabled = false;

will disable the hBrownTree hotspot.

*See Also:* [Region.Enabled](ags72.md#Region.Enabled),
[RemoveWalkableArea](ags73.md#RemoveWalkableArea),
[RestoreWalkableArea](ags73.md#RestoreWalkableArea)

------------------------------------------------------------------------

[]()

### ID property (hotspot)

    readonly int Hotspot.ID

Gets the hotspot number of this hotspot. This allows you to interoperate
with old script using the number-based hotspot functions.

Example:

    Display("Hotspot hDoor is hotspot number %d.", hDoor.ID);
    Display("Hotspot 3 is number %d.", hotspot[3].ID);

displays hDoor's hotspot number, and then displays hotspot 3's number
(which will be 3).

*See Also:* [Hotspot.GetAtScreenXY](ags63.md#Hotspot.GetAtScreenXY)

------------------------------------------------------------------------

[]()

### Name property (hotspot)

*(Formerly known as GetHotspotName, which is now obsolete)*\
*(Formerly known as Hotspot.GetName, which is now obsolete)*

    readonly String Hotspot.Name;

Gets the name of the hotspot.

This property is read-only; it is currently not possible to change
hotspot names at run-time.

Example:

    Display("Hotspot 3's name is %s.", hotspot[3].Name);

will retrieve and then display hotspot 3's name.

*See Also:* [Game.GetLocationName](ags54.md#Game.GetLocationName)

------------------------------------------------------------------------

[]()

### WalkToX property

*(Formerly known as GetHotspotPointX, which is now obsolete)*

    readonly int Hotspot.WalkToX

Gets the X room co-ordinate of the hotspot's walk-to point. If the
hotspot does not have a walk-to point, returns -1.

Example:

    player.Walk(hTable.WalkToX, hTable.WalkToY, eBlock, eWalkableAreas);

will move the character to hotspot hTable's walk-to point.

*See Also:* [Hotspot.WalkToY](ags63.md#Hotspot.WalkToY),
[MoveCharacterToHotspot](ags54.md#MoveCharacterToHotspot)

------------------------------------------------------------------------

[]()

### WalkToY property

*(Formerly known as GetHotspotPointY, which is now obsolete)*

    readonly int Hotspot.WalkToY

Gets the Y room co-ordinate of the hotspot's walk-to point. If the
hotspot does not have a walk-to point, returns -1.

Example:

    player.Walk(hTable.WalkToX, hTable.WalkToY, eBlock, eWalkableAreas);

will move the character to hotspot hTable's walk-to point.

*See Also:* [Hotspot.WalkToX](ags63.md#Hotspot.WalkToX),
[MoveCharacterToHotspot](ags54.md#MoveCharacterToHotspot)


