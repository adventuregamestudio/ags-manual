Room functions
--------------

[AreThingsOverlapping](#arethingsoverlapping)<br>
[DisableGroundLevelAreas](#disablegroundlevelareas)<br>
[EnableGroundLevelAreas](#enablegroundlevelareas)<br>
[GetBackgroundFrame](#getbackgroundframe)<br>
[GetDrawingSurfaceForBackground](#getdrawingsurfaceforbackground)<br>
[GetPlayerCharacter](#getplayercharacter)<br>
[GetProperty](#getproperty)<br>
[GetTextProperty](#gettextproperty)<br>
[SetProperty](#setproperty)<br>
[SetTextProperty](#settextproperty)<br>
[GetScalingAt](#getscalingat)<br>
[GetViewportX](#getviewportx)<br>
[GetViewportY](#getviewporty)<br>
[GetWalkableAreaAt](#getwalkableareaat)<br>
[HasPlayerBeenInRoom](#hasplayerbeeninroom)<br>
[ProcessClick](#processclick)<br>
[ReleaseViewport](#releaseviewport)<br>
[RemoveWalkableArea](#removewalkablearea)<br>
[ResetRoom](#resetroom)<br>
[RestoreWalkableArea](#restorewalkablearea)<br>
[SetAreaScaling](#setareascaling)<br>
[SetBackgroundFrame](#setbackgroundframe)<br>
[SetViewport](#setviewport)<br>
[SetWalkBehindBase](#setwalkbehindbase)<br>
[BottomEdge property](#bottomedge)<br>
[ColorDepth property](#colordepth)<br>
[Height property](#height)<br>
[LeftEdge property](#leftedge)<br>
[Messages property](#messages)<br>
[MusicOnLoad property](#musiconload)<br>
[ObjectCount property](#objectcount)<br>
[RightEdge property](#rightedge)<br>
[TopEdge property](#topedge)<br>
[Width property](#width)

---

### AreThingsOverlapping

    AreThingsOverlapping(int thing1, int thing2)

Checks whether two characters or objects are overlapping each other on
screen. This simply carries out a quick rectangular check on the two
things to decide - so if they have large transparent regions around the
edges, it may seem to be overlapping too soon.

THING1 and THING2 can either be a CHARID, or can be an object number
PLUS 1000. So for example, passing EGO as THING1, and 1004 as THING2,
will compare the character EGO with Object 4 in the current room.

Returns 0 if they are not overlapping, or the overlapping amount if they
are. This amount is an arbitrary scale, but 1 means they are just about
touching, all the way up to higher numbers for more overlappingness.

Calling this function with both the parameters as objects is the same as
calling Object.IsCollidingWithObject.

Example:

    if (AreThingsOverlapping(1002, EGO)) {
      // code here
    }

will run the code if object 2 is overlapping EGO. This could be useful
if object 2 was a bullet, for instance.

*See Also:*
[Character.IsCollidingWithChar](Character#iscollidingwithchar),
[Object.IsCollidingWithObject](Object#iscollidingwithobject)

---

### DisableGroundLevelAreas

    DisableGroundLevelAreas(int disableTints)

Disables all ground-level events. This means that all Region events, the
Player Stands On Hotspot event, and the room edges become disabled.

This command is useful in conjunction with the character\[\].z variable,
if you want the player to be able to temporarily fly or levitate, for
example. It allows you to stop the character from triggering Player
Stands On events while they are in the air.

This command is also useful during some cutscenes, if you don't want the
player to trigger events as they walk around the room while in the
cutscene.

The DISABLETINTS parameter specifies whether the visual effects of the
regions (ie. light levels and tints) are also disabled. If you pass this
as 0, then just the events will be turned off.

Example:

    DisableGroundLevelAreas(0);

will disable all ground-level events, but leave light levels working

*See Also:* [Hotspot.Enabled](Hotspot#enabled),
[Region.Enabled](Region#enabled),
[EnableGroundLevelAreas](Room#enablegroundlevelareas)

---

### EnableGroundLevelAreas

    EnableGroundLevelAreas()

Re-enables all ground-level events. This is used to reverse the effects
of using the DisableGroundLevelAreas command, and will return things to
normal.

Example:

    EnableGroundLevelAreas();

will re-enable all ground-level events.

*See Also:* [Hotspot.Enabled](Hotspot#enabled),
[Region.Enabled](Region#enabled),
[DisableGroundLevelAreas](Room#disablegroundlevelareas)

---

### GetBackgroundFrame

    GetBackgroundFrame()

Returns the number of the current background being displayed. In a room
without animating backgrounds, this will always return 0. Otherwise, the
current frame number is returned from 0 to 4.

Example:

    if (GetBackgroundFrame()==4)
      object[2].Visible = true;

will turn on object 2 if the background frame of the room is frame 4.

*See Also:* [SetBackgroundFrame](Room#setbackgroundframe)

---

### GetDrawingSurfaceForBackground

    static DrawingSurface* Room.GetDrawingSurfaceForBackground(optional int backgroundNumber)

Gets a drawing surface for a room background, which allows you to
directly draw onto the room's background image. You can provide a
background frame number if you want to modify a specific frame;
otherwise, the current background's surface will be returned.

After calling this method, use the various [DrawingSurface
functions](DrawingSurfaceFunctions) to modify the background,
then call Release on the surface when you are finished.

Any changes you make will only last until the player leaves the room, at
which point they will be lost. If you need to make long-lasting changes,
you can either use this method in the Player Enters Room event, or
consider using an alternate background frame for the changed image.

**NOTE:** Drawing onto the room background can be slow, especially when
using the Direct3D driver. Do not use this command in
repeatedly_execute; make sure you only use this command when absolutely
necessary.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawLine(0, 0, 50, 50);
    surface.Release();

draws a yellow diagonal line across the top-left of the current room
background, then releases the image.

*See Also:*
[DrawingSurface.DrawLine](DrawingSurfaceFunctions#drawline),
[DrawingSurface.Release](DrawingSurfaceFunctions#release)

---

### GetPlayerCharacter

    GetPlayerCharacter ()

**THIS COMMAND IS NOW OBSOLETE.**<br>
The recommended replacement is to use the player character's ID
property, as follows:

Example:

    Display("The player character number is %d", player.ID);

*See Also:* [Character.ID](Character#id)

---

### GetProperty

*(Formerly known as global function GetRoomProperty, which is now
obsolete)*

    Room.GetProperty(string property)

Returns the custom property setting of the PROPERTY for the current
room.

This command works with Number properties (it returns the number), and
with Boolean properties (returns 1 if the box was checked, 0 if not).

Use the equivalent Room.GetTextProperty function to get a text property.

Note that you cannot retrieve room properties of other rooms - only the
current room can be checked.

Example:

    if (Room.GetProperty("CanBeAttackedHere"))
      Display("An evil monster lunges at you!");

will print the message if the current room has its "CanBeAttackedHere"
box ticked.

*See Also:* [Room.GetTextProperty](Room#gettextproperty)

---

### GetTextProperty

*(Formerly known as global function GetRoomPropertyText, which is now
obsolete)*

    static String Room.GetTextProperty(string property)

Returns the custom property setting of the PROPERTY for the current
room.

This command works with Text properties only. The property's text will
be returned from this function.

Use the equivalent Room.GetProperty function to get a non-text property.

Note that you cannot retrieve room properties of other rooms - only the
current room can be checked.

Example:

    String description = Room.GetTextProperty("Description");
    Display("The room's description: %s", description);

will retrieve the room's "description" property then display it.

*See Also:* [Room.GetProperty](Room#getproperty)

---

### SetProperty

    static bool Room.SetProperty(const string property, int value)

Sets the new *value* for the custom *property* for the specified room.
Returns TRUE if such property exists and FALSE on failure.

This command works with Number properties (it sets the numeric value),
and with Boolean properties (sets FALSE is value is equal to 0, or TRUE
otherwise).

Use the equivalent SetTextProperty function to set new text property
value.

Note that you cannot set room properties of other rooms - only the
current room.

Example:

    Room.SetProperty("Darkness", 10);

will change room's "Darkness" custom property to 10.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Room.SetTextProperty](Room#settextproperty)

---

### SetTextProperty

    bool Room.SetTextProperty(const string property, const string value)

Sets the new *value* text for the custom *property* for the specified
room. Returns TRUE if such property exists and FALSE on failure.

This command works with Text properties only. The property's text will
be changed to new value.

Use the equivalent SetProperty function to set a non-text property.

Note that you cannot set room properties of other rooms - only the
current room.

Example:

    Room.SetTextProperty("Description", "The Throne Room");

will change room's "description" property.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Room.SetProperty](Room#setproperty)

---

### GetScalingAt

    GetScalingAt (int x, int y)

Returns the room area scaling at room co-ordinates (X,Y).

The value returned is from 1 to 200, with 100 being the normal un-scaled
setting.

Example:

    if (GetScalingAt(player.x, player.y) == 100)
        Display ("The player is currently at normal size.");

*See Also:* [GetWalkableAreaAt](Room#getwalkableareaat),
[SetAreaScaling](Room#setareascaling)

---

### GetViewportX

    GetViewportX ()

Returns the X-offset of the current viewport in a scrolling room. This
allows you to find out what part of the room the player is looking at.
The co-ordinate returned is the left edge of the screen, and so it can
have a value between 0 and (ROOM WIDTH - 320).

If the room is a non-scrolling room, returns 0.

See the SetViewport function description for more information.

Example:

    if (GetViewportX()>100)
        object[2].Visible = true;

will turn object 2 on if the player has scrolled the room by 100 pixels
to the right.

*See Also:* [GetViewportY](Room#getviewporty),
[SetViewport](Room#setviewport)

---

### GetViewportY

    GetViewportY ()

Returns the Y-offset of the current viewport in a scrolling room. This
allows you to find out what part of the room the player is looking at.
The co-ordinate returned is the top edge of the screen, and so it can
have a value between 0 and (ROOM HEIGHT - 200).

If the room is a non-scrolling room, returns 0.

Example:

    if (GetViewportY()>20)
        object[2].Visible = true;

will turn object 2 on if the player has scrolled the room by 20 pixels
to the bottom.

*See Also:* [GetViewportX](Room#getviewportx),
[SetViewport](Room#setviewport)

---

### GetWalkableAreaAt

    GetWalkableAreaAt (int x, int y)

Returns the number of the walkable area at SCREEN co-ordinates (X,Y). If
there is no walkable area there, or if invalid co-ordinates are
specified, returns 0.

NOTE: The co-ordinates are SCREEN co-ordinates, NOT ROOM co-ordinates.
This means that with a scrolling room, the co-ordinates you pass are
relative to the screen's current position, and NOT absolute room
co-ordinates. This means that this function is suitable for use with the
mouse cursor position variables.

Example:

    if (GetWalkableAreaAt(mouse.x,mouse.y) == 0)
        Display ("You can't walk there.");

*See Also:* [Hotspot.GetAtScreenXY](Hotspot#getatscreenxy),
[Region.GetAtRoomXY](Region#getatroomxy),
[GetScalingAt](Room#getscalingat)

---

### HasPlayerBeenInRoom

    HasPlayerBeenInRoom(int room_number)

Checks whether the player has ever been in ROOM_NUMBER (ie. has the
'First Time Player Enters Room' event there ever been run). Returns 1 if
they have, and 0 if they haven't.

You can use this function to determine whether the player has been to a
particular location previously. If you reset the room with ResetRoom,
then this command will return 0 until they enter the room again.

This command will always return 1 if you ask it about the current room;
and it will always return 0 if you ask it about a non-state saving room
(ie. rooms numbered &gt; 300).

Example:

    if (HasPlayerBeenInRoom(14)) {
      Display("The player has been to room 14 before.");
    }

will display a message if the player has been to room 14.

*See Also:* [ResetRoom](Room#resetroom)

---

### ProcessClick

*(Formerly known as global function ProcessClick, which is now
obsolete)*

    static void Room.ProcessClick(int x, int y, CursorMode)

Simulates clicking the mouse on the location (X,Y) on the screen, in the
specified cursor mode. This "click" has special behavior in that it
**only affects Room elements and characters** under given coordinates.
Any conditions attached to the first object found on given coordinates
will be executed. Game interface (buttons, sliders, and so on) will be
**ignored**. Even if the coordinates happen to lie on a button, the
simulated click will "pass through" that button as if it was not
present.

The available cursor modes are the ones you define on your Cursors tab
(but with eMode prepended to them). Usually these are eModeWalkto,
eModeLookat, etc.

Example:

    Room.ProcessClick(100, 50, eModeLookat);

will simulate a click in the Look mode on co-ordinates (100, 50).

*See Also:* [GUI.ProcessClick](GUI#processclick),
[Mouse.Click](Mouse#click),
[IsInteractionAvailable](Game#isinteractionavailable),
[Hotspot.RunInteraction](Hotspot#runinteraction)

---

### ReleaseViewport

    ReleaseViewport ()

Releases the lock on the screen viewport, allowing it to automatically
scroll around following the player character as normal.

Example:

    int x;
    while (x<100) {
       SetViewport(x,0);
       x++;
       Wait(1);
    }
    ReleaseViewport();

will scroll the room 100 pixels to the right and then return the screen
to its original position and unlock the screen viewport.

*See Also:* [SetViewport](Room#setviewport)

---

### RemoveWalkableArea

    RemoveWalkableArea (int areanum)

Removes the walkable areas in colour AREANUM from the current room. You
can put the area back with RestoreWalkableArea.

NOTE: When the player leaves the screen, all the walkable areas are
reset. Therefore, if you want an area to remain off when they leave the
screen, you will need to set a flag, then run the RemoveWalkableArea
command in the "Player enters room" event when they return.

Example:

    RemoveWalkableArea(5);

will make the walking area 5 unwalkable.

*See Also:* [RestoreWalkableArea](Room#restorewalkablearea)

---

### ResetRoom

    ResetRoom (int room_number)

Discards all the data that the engine has in memory about when the
player last visited ROOM_NUMBER, and resets it as if they'd never been
there. The next time the player goes to that room, all the objects and
scripts will be in their initial state (as set up in the editor), and
not how they were when the player left the room. The "First time enters
room" event will be run when they enter this room again.

This function is useful if you want to have a "View intro" option to
allow the player to watch an intro again - this function can reset all
the objects in the intro rooms to their starting positions.

NOTE: You cannot reset the current room (ie. the room that the player is
in).

Example:

    ResetRoom(0);

will reset the intro room so it can be played again if the player wants
to.

*See Also:* [HasPlayerBeenInRoom](Room#hasplayerbeeninroom)

---

### RestoreWalkableArea

    RestoreWalkableArea (int areanum)

Makes the area AREANUM walkable again.

Example:

    RestoreWalkableArea(4);

will make the walking area 4 walkable again.

*See Also:* [RemoveWalkableArea](Room#removewalkablearea)

---

### SetAreaScaling

    SetAreaScaling(int area, int min, int max)

Changes walkable area number AREA's scaling.

There are two ways to use this command:<br>
1. Pass the same value for MIN and MAX. This will give the walkable area
fixed scaling (same as setting it in the editor with "Use continuous
scaling" un-ticked).<br>
2. Pass different values for MIN and MAX. In this case, continuous
scaling is enabled for the walkable area, and will go from MIN at the
top to MAX at the bottom.

MIN and MAX have ranges from 5 to 200, the same as in the editor. Pass
100 for both values to revert to the normal zoom level (100`%`) for that
area.

Example:

    SetAreaScaling(5, 120, 170);

will set walkable area 5 to use continuous scaling from 120 to 170
percent.

*See Also:* [GetScalingAt](Room#getscalingat),
[GetWalkableAreaAt](Room#getwalkableareaat)

---

### SetBackgroundFrame

    SetBackgroundFrame (int frame)

Locks the background to frame number FRAME of an animating-background
screen. (Values for FRAME are from 0 to 4). This allows you to use the
animating backgrounds feature for another purpose - you can have two
frames of the background, one for example with a spaceship crashed on
it. Then, once the right event has happened, call SetBackgroundFrame in
the Player Enters Room event to set the background before the screen
fades in.

Pass the *frame* as -1 to return to the default behaviour of
automatically cycling through all the background frames.

The frame lock is released when the game changes rooms.

Example:

    if (GetGlobalInt(20)==1)
        SetBackgroundFrame(4);

will change the current room's background frame to 4 if the global
integer 20 is 1.

*See Also:* [GetBackgroundFrame](Room#getbackgroundframe)

---

### SetViewport

    SetViewport (int x, int y)

Locks the screen viewport to having the top-left hand corner at (X,Y) in
a scrolling room. This allows you to manually pan across a scrolling
room or to have the screen follow a non-player character.

The lock is released when you either call ReleaseViewport or the player
changes rooms.

**NOTE:** The co-ordinates supplied are 320x200-scale co-ordinates, and
will be automatically multiplied up by the engine.

**NOTE:** This function has no effect if the current room isn't a
scrolling room.

Example:

    int ypos = 0;
    while (ypos < 60) {
      SetViewport(0, ypos);
      Wait(1);
      ypos++;
    }
    ReleaseViewport();

will scroll the screen down from the top 60 pixels, then release it back
to follow the player around.

*See Also:* [GetViewportX](Room#getviewportx),
[GetViewportY](Room#getviewporty),
[ReleaseViewport](Room#releaseviewport)

---

### SetWalkBehindBase

    SetWalkBehindBase (int area, int baseline)

Changes the walk-behind AREA to have new BASELINE. This effectively
allows you to turn walk-behinds on and off, although you can do other
tricks with it as well. BASELINE is from 1 to the height of the room
(normally 200) and moves the line which you set originally in the
editor.

Passing BASELINE as 0 disables the walk-behind area, so that the player
will always walk in front of it.

Basically, if the character's feet are below BASELINE, he will be drawn
in front of it, otherwise he will be drawn behind it.

Example:

    SetWalkBehindBase (3,0);

will disable the walkbehind area number 3.

*See Also:* [Object.Baseline](Object#baseline)

---

### BottomEdge

    readonly static int Room.BottomEdge

Returns the Y co-ordinate of the bottom edge of the room, as set in the
Room Settings pane of the editor.

Example:

    Display("The current room's bottom edge is at %d.", Room.BottomEdge);

*See Also:* [Room.LeftEdge](Room#leftedge),
[Room.RightEdge](Room#rightedge),
[Room.TopEdge](Room#topedge)

---

### ColorDepth

    readonly static int Room.ColorDepth

Returns the colour depth of the room's background scene. This is
important if you want to use DrawImage, since any sprites that you draw
must be the same colour depth as the room itself.

Example:

    Display("The current room background is %d-bit colour.", Room.ColorDepth);

*See Also:*
[DrawingSurface.DrawImage](DrawingSurfaceFunctions#drawimage)

---

### Height

*(Formerly known as game.room_height, which is now obsolete)*

    readonly static int Room.Height

Returns the height of the room, in 320x200-style co-ordinates. This is
the same height as is displayed as the "Relative size" in the Editor.

Example:

    Display("The current room size is %d x %d.", Room.Width, Room.Height);

*See Also:* [Room.Width](Room#width)

---

### LeftEdge

    readonly static int Room.LeftEdge

Returns the X co-ordinate of the left edge of the room, as set in the
Room Settings pane of the editor.

Example:

    Display("The current room's left edge is at %d.", Room.LeftEdge);

*See Also:* [Room.BottomEdge](Room#bottomedge),
[Room.RightEdge](Room#rightedge),
[Room.TopEdge](Room#topedge)

---

### Messages

*(Formerly known as global function GetMessageText, which is now
obsolete)*

    readonly static String Room.Messages[int message]

Gets the text of the specified room message. This is useful if you want
to store, for example, a room description in Message 1 in each room --
this property allows you to retrieve the text for that message from the
current room.

If an invalid message number is supplied, *null* will be returned.
Otherwise, the message contents will be returned.

Example:

    String message1 = Room.Messages[1];
    Display("Message 1 says: %s", message1);

will print the contents of room message 1.

---

### MusicOnLoad

    readonly static int Room.MusicOnLoad

**This property is now obsolete.** It is still accessible for backwards
compatibility with old games.

Returns the music number that is set to play when the player enters this
room, as set in the "Room Settings" pane in the editor. If no music is
set for this room, returns 0.

Example:

    Display("The current room plays music %d when the player enters.", Room.MusicOnLoad);

---

### ObjectCount

*(Formerly part of GetGameParameter, which is now obsolete)*

    readonly static int Room.ObjectCount

Returns the number of objects in the room.

Example:

    Display("The current room contains %d objects.", Room.ObjectCount);

---

### RightEdge

    readonly static int Room.RightEdge

Returns the X co-ordinate of the right edge of the room, as set in the
Room Settings pane of the editor.

Example:

    Display("The current room's right edge is at %d.", Room.RightEdge);

*See Also:* [Room.BottomEdge](Room#bottomedge),
[Room.LeftEdge](Room#leftedge),
[Room.TopEdge](Room#topedge)

---

### TopEdge

    readonly static int Room.TopEdge

Returns the Y co-ordinate of the top edge of the room, as set in the
Room Settings pane of the editor.

Example:

    Display("The current room's top edge is at %d.", Room.TopEdge);

*See Also:* [Room.BottomEdge](Room#bottomedge),
[Room.LeftEdge](Room#leftedge),
[Room.RightEdge](Room#rightedge)

---

### Width

*(Formerly known as game.room_width, which is now obsolete)*

    readonly static int Room.Width

Returns the width of the room, in 320x200-style co-ordinates. This is
the same width as is displayed as the "Relative size" in the Editor.

Example:

    Display("The current room size is %d x %d.", Room.Width, Room.Height);

*See Also:* [Room.Height](Room#height)

