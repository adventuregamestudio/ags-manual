Object functions and properties
-------------------------------

[Animate](#animate)<br>
[GetAtScreenXY](#getatscreenxy)<br>
[GetProperty](#getproperty)<br>
[GetTextProperty](#gettextproperty)<br>
[SetProperty](#setproperty)<br>
[SetTextProperty](#settextproperty)<br>
[IsCollidingWithObject](#iscollidingwithobject)<br>
[MergeIntoBackground](#mergeintobackground)<br>
[Move](#move)<br>
[RemoveTint](#removetint)<br>
[IsInteractionAvailable](#isinteractionavailable)<br>
[RunInteraction](#runinteraction)<br>
[SetLightLevel](#setlightlevel)<br>
[SetPosition](#setposition)<br>
[SetView](#setview)<br>
[StopAnimating](#stopanimating)<br>
[StopMoving](#stopmoving)<br>
[Tint](#tint)<br>
[Animating property](#animating)<br>
[Baseline property](#baseline)<br>
[BlockingHeight property](#blockingheight)<br>
[BlockingWidth property](#blockingwidth)<br>
[Clickable property](#clickable)<br>
[Frame property](#frame)<br>
[Graphic property](#graphic)<br>
[HasExplicitLight property](#hasexplicitlight)<br>
[HasExplicitTint property](#hasexplicittint)<br>
[ID property](#id)<br>
[IgnoreScaling property](#ignorescaling)<br>
[IgnoreWalkbehinds property](#ignorewalkbehinds)<br>
[LightLevel property](#lightlevel)<br>
[Loop property](#loop)<br>
[Moving property](#moving)<br>
[Name property](#name)<br>
[Solid property](#solid)<br>
[TintBlue property](#tintblue)<br>
[TintGreen property](#tintgreen)<br>
[TintRed property](#tintred)<br>
[TintSaturation property](#tintsaturation)<br>
[TintLuminance property](#tintluminance)<br>
[Transparency property](#transparency)<br>
[View property](#view)<br>
[Visible property](#visible)<br>
[X property](#x)<br>
[Y property](#y)

---

### Animate

*(Formerly known as AnimateObject, which is now obsolete)*<br>
*(Formerly known as AnimateObjectEx, which is now obsolete)*

    Object.Animate(int loop, int delay, optional RepeatStyle,
                   optional BlockingStyle, optional Direction)

Starts the object animating, using loop number LOOP of its current view.
The overall speed of the animation is set with DELAY, where 0 is the
fastest, and increasing numbers mean slower. The delay for each frame is
worked out as DELAY + FRAME SPD, so the individual frame speeds are
relative to this overall speed.

The *RepeatStyle* parameter sets whether the animation will continuously
repeat the cycling through the frames. This can be *eOnce* (or zero), in
which case the animation will start from the first frame of LOOP, and go
through each frame in turn until the last frame, where it will stop. If
RepeatStyle is *eRepeat* (or 1), then when the last frame is reached, it
will go back to the first frame and start over again with the animation.
If RepeatStyle is 2 then it will do the animation once, but then return
the graphic to the first frame and stop (whereas repeat=0 will leave the
graphic on the last frame).

For *blocking* you can pass either eBlock (in which case the function
will wait for the animation to finish before returning), or eNoBlock (in
which case the animation will start to play, but your script will
continue). The default is eBlock.

*direction* specifies which way the animation plays. You can either pass
eForwards (the default) or eBackwards.

You need to use SetView at some stage before this command, in order to
set up the object's current view.

Example:

    object[0].Animate(2, 5);
    object[1].Animate(1, 3, eOnce, eBlock, eBackwards);

will animate object 0 using loop 2 of its current view, at speed 5, and
play the animation once only. This happens in the background. Then,
object 1 will animate backwards using loop 1 of its current view, at
speed 3. The function won't return until the animation is finished.

*See Also:* [Character.Animate](Character#animate),
[Object.Animating](Object#animating),
[Object.SetView](Object#setview),
[Object.StopAnimating](Object#stopanimating)

---

### GetAtScreenXY

*(Formerly known as global function GetObjectAt, which is now obsolete)*

    static Object* Object.GetAtScreenXY(int x, int y)

Checks if there is a room object at SCREEN co-ordinates (X,Y). Returns
the object if there is, or *null* if there is not.

See the description of GetLocationName for more on screen co-ordinates.

Example:

    if (Object.GetAtScreenXY(211,145) == oRock) {
      // code here
    }

will execute the code only if object oRock is on the screen coordinates
211,145.

*See Also:* [Hotspot.GetAtScreenXY](Hotspot#getatscreenxy),
[Game.GetLocationName](Game#getlocationname)

---

### GetProperty

*(Formerly known as GetObjectProperty, which is now obsolete)*

    Object.GetProperty(string property)

Returns the custom property setting of the PROPERTY for the specified
object.

This command works with Number properties (it returns the number), and
with Boolean properties (returns 1 if the box was checked, 0 if not).

Use the equivalent GetTextProperty function to get a text property.

Example:

    if (object[0].GetProperty("Value") > 200)
      Display("Object 0's value is over 200!");

will print the message if object 0 has its "Value" property set to more
than 200.

*See Also:* [Object.GetTextProperty](Object#gettextproperty)

---

### GetTextProperty

*(Formerly known as GetObjectPropertyText, which is now obsolete)*<br>
*(Formerly known as Object.GetPropertyText, which is now obsolete)*

    String Object.GetTextProperty(string property)

Returns the custom property setting of the PROPERTY for the specified
object.

This command works with Text properties only. The property's text will
be returned from this function.

Use the equivalent GetProperty function to get a non-text property.

Example:

    String description = object[0].GetTextProperty("Description");
    Display("Object 0's description: %s", description);

will retrieve Object 0's "description" property then display it.

*See Also:* [Object.GetProperty](Object#getproperty)

---

### SetProperty

    bool Object.SetProperty(const string property, int value)

Sets the new *value* for the custom *property* for the specified room
object. Returns TRUE if such property exists and FALSE on failure.

This command works with Number properties (it sets the numeric value),
and with Boolean properties (sets FALSE is value is equal to 0, or TRUE
otherwise).

Use the equivalent SetTextProperty function to set new text property
value.

Example:

    oTable.SetProperty("ItemCapacity", 5);

will change Table's "ItemCapacity" custom property to 5.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Object.SetTextProperty](Object#settextproperty)

---

### SetTextProperty

    void Object.SetTextProperty(const string property, const string value)

Sets the new *value* text for the custom *property* for the specified
room object.

This command works with Text properties only. The property's text will
be changed to new value.

Use the equivalent SetProperty function to set a non-text property.

Example:

    oTable.SetTextProperty("Description", "A dull furniture");

will change table's "description" property.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Object.SetProperty](Object#setproperty)

---

### IsCollidingWithObject

*(Formerly known as AreObjectsColliding, which is now obsolete)*

    bool Object.IsCollidingWithObject(Object* obj2)

Checks if the specified object and OBJ2 are touching each other. Returns
*true* if they are, and *false* if they are not.

**NOTE:** This function only performs a rectangular check, even when
pixel-perfect click detection is turned on.

Example:

    if (object[2].IsCollidingWithObject(object[3]))
    {
      Display("object 2 and 3 are colliding!");
    }

will display the message if the objects 2 and 3 are colliding.

*See Also:* [AreThingsOverlapping](Room#arethingsoverlapping)

---

### MergeIntoBackground

*(Formerly known as MergeObject, which is now obsolete)*

    Object.MergeIntoBackground()

Merges the object into the background scene for this room. By doing
this, the object becomes part of the background and so does not slow the
game down. This is a 1-way operation - once the object has been merged,
it cannot be changed back and the state of the room is permanently
altered. Therefore you should only use this function if a game event has
occurred that means the room is permanently changed.

**NOTE:** after calling this function, you cannot use the object any
more and it is permanently removed from the game.

**NOTE:** objects can only be merged if the object graphic was imported
at the same colour depth as the background graphic.

Example:

    object[3].MergeIntoBackground();

will merge the object's image into the room's background image and make
the object unusable.

---

### Move

*(Formerly known as MoveObject, which is now obsolete)*<br>
*(Formerly known as MoveObjectDirect, which is now obsolete)*

    Object.Move(int x, int y, int speed, optional BlockingStyle,
                optional WalkWhere);

Starts the object moving from its current location to (X,Y). It will
move at speed SPEED, which uses the same scale as the character Walk
Speed values in the AGS Editor.

If *BlockingStyle* is eNoBlock (the default), then control returns to
the script immediately, and the object will move in the background.

If *BlockingStyle* is eBlock then this command will wait for the object
to finish moving before your script resumes.

If *WalkWhere* is eWalkableAreas (the default), then the object will
attempt to get as close a possible to (X,Y) by using the room's walkable
areas.

If *WalkWhere* is eAnywhere, then the object will simply walk directly
from its current location to (X,Y), ignoring the room walkable areas.

Example:

    object[2].Move(125, 40, 4, eBlock);

will move object 2 to 125,40 and return control to the player when the
object gets there.

*See Also:* [Object.Moving](Object#moving),
[Character.Walk](Character#walk),
[Object.StopMoving](Object#stopmoving)

---

### RemoveTint

*(Formerly known as RemoveObjectTint, which is now obsolete)*

    Object.RemoveTint()

Undoes the effects of calling Tint, and returns the object to using the
room's ambient tint.

Example:

    object[1].Tint(0, 250, 0, 30, 100);
    Wait(40);
    object[1].RemoveTint();

will tint object 1 green for a second, then turn it back to normal.

*See Also:* [Object.Tint](Object#tint)

---

### IsInteractionAvailable

    Object.IsInteractionAvailable(CursorMode)

Checks whether there is an event handler defined for activating the room
object in cursor mode MODE.

This function is very similar to RunInteraction, except that rather than
run the event handler script function, it simply returns *true* if
something would have happened, or *false* if unhandled_event would have
been run.

Example:

    if (oDoor.IsInteractionAvailable(eModeInteract) == 0)
      Display("interacting with this door would not do anything.");

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [IsInteractionAvailable](Game#isinteractionavailable),
[Object.RunInteraction](Object#runinteraction)

---

### RunInteraction

*(Formerly known as RunObjectInteraction, which is now obsolete)*

    Object.RunInteraction(CursorMode)

Runs the event handler as if the player had clicked the mouse on the
object in the current room, using the specified cursor mode.

Example:

    object[3].RunInteraction(eModeInteract);

will execute the code defined in object 3's "Interact with object" event
handler.

*See Also:* [Room.ProcessClick](Room#processclick),
[Object.IsInteractionAvailable](Object#isinteractionavailable),
[Character.RunInteraction](Character#runinteraction),
[Hotspot.RunInteraction](Hotspot#runinteraction)

---

### SetLightLevel

    void Object.SetLightLevel(int light_level)

Sets individual light level for this room object.

The light level is from **-100 to 100**.

In 8-bit games you cannot use positive light level for brightening
effect, but you may still use negative values to produce darkening
effect.

To disable object lighting and tinting effects, call SetLightLevel with
parameter *light_level* 0.

**NOTE**: Setting a light level will disable any RGB tint set for the
object.

**NOTE:** Object's individual light level OVERRIDES both ambient light
level and local region light level.

Example:

    oLamp.LightLevel = 100;

This will give the lamp maximal individual brightness.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [Object.Tint](Object#tint),
[SetAmbientLightLevel](Game#setambientlightlevel),
[Character.SetLightLevel](Character#setlightlevel),
[Region.LightLevel](Region#lightlevel)

---

### SetPosition

*(Formerly known as SetObjectPosition, which is now obsolete)*

    Object.SetPosition(int x, int y)

Changes the object's position to (X,Y). These co-ordinates specify the
lower-left hand corner of the object.

This command is equivalent to setting the object.X and object.Y
separately, but provides a more convenient way of doing so.

**NOTE:** This command cannot be used while the object is moving.

Example:

    object[2].SetPosition(50, 100);

will change object's 2 position to 50,100.

*See Also:* [Object.X](Object#x),
[Object.Y](Object#y)

---

### SetView

*(Formerly known as SetObjectFrame, which is now obsolete)*<br>
*(Formerly known as SetObjectView, which is now obsolete)*

    Object.SetView(int view, optional int loop, optional int frame)

Sets the object's view to VIEW, and changes the object's graphic to
FRAME of LOOP in VIEW. If you do not supply the loop or frame, they will
be left unchanged.

You must use this command before calling Animate, so that AGS knows
which view to animate the object with.

Example:

    object[3].SetView(14);
    object[1].SetView(5, 2, 0);

will change object 3's view to view number 14, and change object 1 to
view 5, loop 2, frame 0.

*See Also:* [Object.Animate](Object#animate)

---

### StopAnimating

    Object.StopAnimating()

Stops the object from animating. It will remain on its current frame
until you change it or start a new animation.

Example:

    if (object[2].Animating) {
      object[2].StopAnimating();
    }

will stop object 2 animating if it currently is doing so.

*See Also:* [Object.Animate](Object#animate),
[Object.Animating](Object#animating)

---

### StopMoving

*(Formerly known as StopObjectMoving, which is now obsolete)*

    Object.StopMoving()

Stops the object from moving. It will remain in its current position
until any further commands are issued.

Example:

    if (object[2].Moving) {
      object[2].StopMoving();
    }

will stop object 2 moving if it currently is doing so.

*See Also:* [Object.Moving](Object#moving),
[Object.Move](Object#move),
[Character.StopMoving](Character#stopmoving)

---

### Tint

*(Formerly known as SetObjectTint, which is now obsolete)*

    Object.Tint(int red, int green, int blue,
                int saturation, int luminance)

Tints the object on the screen to (RED, GREEN, BLUE) with SATURATION
percent saturation.

This function applies a tint to a specific object. For the meaning of
all the parameters, see [SetAmbientTint](Game#setambienttint).

The tint set by this function overrides any ambient tint set for the
room. For this reason, passing the SATURATION as 0 to this function does
not turn it off - rather, it ensures that no tint is applied to the
object (even if an ambient tint is set).

To remove the tint set by this function and return to using the ambient
tint for this object, call [RemoveTint](Object#removetint).

**NOTE:** This function only works in hi-colour games and with hi-colour
sprites.

Example:

    object[1].Tint(0, 250, 0, 30, 100);

will tint object 1 green.

*See Also:* [Object.RemoveTint](Object#removetint),
[SetAmbientTint](Game#setambienttint)

---

### Animating

*(Formerly known as IsObjectAnimating, which is now obsolete)*

    readonly bool Object.Animating

Returns 1 if the specified object is currently animating.<br>
Returns 0 if the object has finished its animation.

This property is read-only. To change object animation, use the
[Animate](Object#animate) command.

Example:

    object[2].Animate(5, 0);
    while (object[2].Animating) Wait(1);

will animate object 2 and wait until the animation finishes.

In reality, you would simply use the Blocking parameter of Animate so
you wouldn't need to do this.

*See Also:* [Object.Animate](Object#animate),
[Object.Moving](Object#moving),
[Object.StopAnimating](Object#stopanimating),
[Object.X](Object#x), [Object.Y](Object#y)

---

### Baseline

*(Formerly known as GetObjectBaseline, which is now obsolete)*<br>
*(Formerly known as SetObjectBaseline, which is now obsolete)*

    int Object.Baseline

Gets/sets the object's baseline. This allows you to modify the line you
can set in the editor. You can disable the baseline (and revert to using
the base of the object's image on the screen) by setting it to 0.

Otherwise, set it to the Y screen co-ordinate you want to use, normally
from 1 to 200 unless you have a taller than usual room.

If you want to get the baseline and it returns 0, then the baseline is
the object's Y co-ordinate.

Example:

    object[4].Baseline = 100;

will change object's 4 baseline to a line positioned at y coordinate
100.

*See Also:* [Character.Baseline](Character#baseline),
[Object.Y](Object#y),
[SetWalkBehindBase](Room#setwalkbehindbase)

---

### BlockingHeight

    int Object.BlockingHeight

Gets/sets the object's blocking height.

The blocking height determines how large of a blocking rectangle the
object exerts to stop characters walking through it. If this is set to 0
(the default), then the blocking rectangle is automatically calculated
to be the object's width, and 5 pixels high.

You can manually change the setting by entering a blocking height in
pixels, which is the size of walkable area that the object effectively
removes by being there.

**NOTE:** This property has no effect unless the
[Solid](Object#solid) property is set to *true*.

Example:

    oRock.BlockingHeight = 20;

will make the Rock object block 20 pixels high (10 above and 10 below
its baseline)

*See Also:* [Object.BlockingWidth](Object#blockingwidth),
[Object.Solid](Object#solid)

---

### BlockingWidth

    int Character.BlockingWidth

Gets/sets the object's blocking width.

The blocking width determines how large of a blocking rectangle the
object exerts to stop characters walking through it. If this is set to 0
(the default), then the blocking rectangle is automatically calculated
to be the object's width, and 5 pixels high.

You can manually change the setting by entering a blocking width in
pixels, which is the size of walkable area that the object effectively
removes by being there.

**NOTE:** This property has no effect unless the
[Solid](Object#solid) property is set to *true*.

Example:

    oRock.BlockingWidth = 50;

will make the Rock object block 50 pixels wide (25 pixels to the left of
his centre, and 25 to the right)

*See Also:* [Object.BlockingHeight](Object#blockingheight),
[Object.Solid](Object#solid)

---

### Clickable

*(Formerly known as SetObjectClickable, which is now obsolete)*

    bool Object.Clickable

Gets/sets whether the object is recognised as something which the player
can interact with.

If this is set to 1, then the player can look at, speak to, and so on
the object. If it is set to 0, then the object will not respond to
clicks and the mouse will activate whatever is behind the object. This
is useful if you are using the object for visual effects and don't want
it to be clicked on by the player.

Example:

    object[2].Clickable = 0;

will make object 2 ignore clicks from the player.

*See Also:* [Character.Clickable](Character#clickable),
[Object.IgnoreWalkbehinds](Object#ignorewalkbehinds)

---

### Frame

    readonly int Object.Frame

Gets the frame number that the object is currently set to. If the object
is not currently assigned a view, this will be 0 (in which case the
Graphic property will hold its sprite number).

This property is read-only. To change the frame, use the animation
functions.

Example:

    Display("Object oDoor's frame is currently %d.", oDoor.Frame);

will display the oDoor object's current frame number

*SeeAlso:* [Object.Graphic](Object#graphic),
[Object.Loop](Object#loop),
[Object.View](Object#view)

---

### Graphic

*(Formerly known as GetObjectGraphic, which is now obsolete)*<br>
*(Formerly known as SetObjectGraphic, which is now obsolete)*

    int Object.Graphic

Gets/sets the sprite slot number that the object is currently displayed
as. You can get the slot number from the Sprite Manager. If the object
is currently animating (from an Animate command) and you change the
Graphic, then the animation will be stopped.

Example:

    object[2].Graphic = 100;

will change the object 2's image to the image stored in the sprite
manager's slot 100.

*See Also:* [Object.SetView](Object#setview)

---

### HasExplicitLight

    readonly bool Object.HasExplicitTint

Returns *true* if the object has a light set explicitly with the
[Object.SetLightLevel](Object#setlightlevel) command.

Returns *false* if the object has no explicit light level, but it may
still be lighted by
[SetAmbientLightLevel](Game#setambientlightlevel) or a region
light.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*SeeAlso:* [Object.SetLightLevel](Object#setlightlevel)

---

### HasExplicitTint

    readonly bool Object.HasExplicitTint

Returns *true* if the object has a tint set explicitly with the
[Object.Tint](Object#tint) command.

Returns *false* if the object has no explicit tint, but it may still be
tinted by [SetAmbientTint](Game#setambienttint) or a region tint.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*SeeAlso:* [Object.Tint](Object#tint),
[Object.RemoveTint](Object#removetint)

---

### ID

    readonly int Object.ID

Gets the object's ID number. This is the object's number from the
editor, and is useful if you need to interoperate with legacy code that
uses the object's number rather than name.

Example:

    MoveObject(oRock.ID, 100, 50, 5);

uses the obsolete MoveObject function to move the Rock object to (100,
50) at speed 5.

---

### IgnoreScaling

    bool Object.IgnoreScaling

Gets/sets whether the object is affected by walkable area scaling. This
is equivalent, **though opposite**, to the "Use walkable area scaling"
checkbox in the Objects pane of the editor.

If this is set to true, the object will always be the same size. If it
is set to false, then the object will be stretched or shrunk as
appropriate on walkable areas.

Example:

    oDoor.IgnoreScaling = true;

will tell the Door object not to be scaled on walkable areas.

*See Also:*
[Object.IgnoreWalkbehinds](Object#ignorewalkbehinds)

---

### IgnoreWalkbehinds

*(Formerly known as SetObjectIgnoreWalkbehinds, which is now obsolete)*

    bool Object.IgnoreWalkbehinds

Sets whether the object is affected by walkbehind areas. Setting this to
*false* (the default setting) means that the object will be placed
behind walk-behind areas according to the relevant baselines.

If this is set to *true*, then the object will never be placed behind a
walk-behind area. This is useful if for example you want an object to be
a picture on a wall, and the wall can be walked behind - but you also
want it to act correctly in relation to characters, so changing its
baseline wouldn't work.

**NOTE:** enabling this property does not currently work properly when
using the Direct3D driver.

Example:

    object[1].IgnoreWalkbehinds = true;

will make object 1 ignore walk behinds.

*See Also:* [Object.Baseline](Object#baseline),
[Object.Clickable](Object#clickable),
[Object.IgnoreScaling](Object#ignorescaling)

---

### LightLevel

    readonly int Object.LightLevel

If the object has an individual light set explicitly with the
[Object.SetLightLevel](Object#setlightlevel) command, this
property returns the light level value. Otherwise it returns 0.

**NOTE:** without individual light level set, Object.LightLevel returns
0 even if the object is affected by the ambient or region's light.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*SeeAlso:* [Object.SetLightLevel](Object#setlightlevel),
[SetAmbientLightLevel](Game#setambientlightlevel),

---

### Loop

    readonly int Object.Loop

Gets the loop that the object is currently set to. If the object is not
currently assigned a view, this will be 0 (in which case the Graphic
property will hold its sprite number).

This property is read-only. To change the loop, use the animation
functions.

Example:

    Display("Object oDoor's loop is currently %d.", oDoor.Loop);

will display the oDoor object's current loop number

*SeeAlso:* [Object.Frame](Object#frame),
[Object.Graphic](Object#graphic),
[Object.View](Object#view)

---

### Moving

*(Formerly known as IsObjectMoving, which is now obsolete)*

    readonly bool Object.Moving

Returns 1 if the object is currently moving, or 0 if not.

This property is read-only; to change the object's movement, use the
[Move](Object#move) and
[StopMoving](Object#stopmoving) commands.

Example:

    object[2].Move(125,40,3);
    while (object[2].Moving) Wait(1);

will move object 2 to 125,40 and return control to the player when the
object gets there.

*See Also:* [Object.Animating](Object#animating),
[Object.StopMoving](Object#stopmoving)

---

### Name

*(Formerly known as GetObjectName, which is now obsolete)*<br>
*(Formerly known as Object.GetName, which is now obsolete)*

    readonly String Object.Name;

Gets the name of the object.

**NOTE**: This property is read-only. It is not currently possible to
change the name of an object at run-time.

Example:

    Display("Object 0's name is %s.", object[0].Name);

will retrieve and then display object 0's name.

*See Also:* [Game.GetLocationName](Game#getlocationname)

---

### Solid

    bool Object.Solid

Gets/sets whether the object can be walked through by characters.

If this is set to true, then the object is solid and will block the path
of solid characters. If this is set to false, then the object can be
walked through by characters.

**NOTE:** solid objects only block characters, they don't block other
objects from moving through them.

Example:

    oSmallrock.Solid = true;

will mean that the Smallrock object blocks the path of characters.

*See Also:* [Object.BlockingHeight](Object#blockingheight),
[Object.BlockingWidth](Object#blockingwidth)

---

### TintBlue

    readonly int Object.TintBlue

Gets the *Blue* setting for the object's current tint.

This property is read-only; to change it, use the
[Object.Tint](Object#tint) command.

**NOTE:** If the
[Object.HasExplicitTint](Object#hasexplicittint) property is
false, then this value is meaningless.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Object.Tint](Object#tint),
[Object.HasExplicitTint](Object#hasexplicittint),
[Object.TintGreen](Object#tintgreen),
[Object.TintRed](Object#tintred),
[Object.TintLuminance](Object#tintluminance)

---

### TintGreen

    readonly int Object.TintGreen

Gets the *Green* setting for the object's current tint.

This property is read-only; to change it, use the
[Object.Tint](Object#tint) command.

**NOTE:** If the
[Object.HasExplicitTint](Object#hasexplicittint) property is
false, then this value is meaningless.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Object.Tint](Object#tint),
[Object.TintBlue](Object#tintblue),
[Object.TintRed](Object#tintred),
[Object.TintSaturation](Object#tintsaturation),
[Object.TintLuminance](Object#tintluminance)

---

### TintRed

    readonly int Object.TintRed

Gets the *Red* setting for the object's current tint.

This property is read-only; to change it, use the
[Object.Tint](Object#tint) command.

**NOTE:** If the
[Object.HasExplicitTint](Object#hasexplicittint) property is
false, then this value is meaningless.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Object.Tint](Object#tint),
[Object.TintBlue](Object#tintblue),
[Object.TintGreen](Object#tintgreen),
[Object.TintSaturation](Object#tintsaturation),
[Object.TintLuminance](Object#tintluminance)

---

### TintSaturation

    readonly int Object.TintSaturation

Gets the *saturation* setting for the object's current tint.

This property is read-only; to change it, use the
[Object.Tint](Object#tint) command.

**NOTE:** If the
[Object.HasExplicitTint](Object#hasexplicittint) property is
false, then this value is meaningless.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Object.Tint](Object#tint),
[Object.TintBlue](Object#tintblue),
[Object.TintGreen](Object#tintgreen),
[Object.TintRed](Object#tintred),
[Object.TintLuminance](Object#tintluminance)

---

### TintLuminance

    readonly int Object.TintLuminance

Gets the *luminance* setting for the object's current tint.

This property is read-only; to change it, use the
[Object.Tint](Object#tint) command.

**NOTE:** If the
[Object.HasExplicitTint](Object#hasexplicittint) property is
false, then this value is meaningless.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Object.Tint](Object#tint),
[Object.TintBlue](Object#tintblue),
[Object.TintGreen](Object#tintgreen),
[Object.TintRed](Object#tintred),
[Object.TintSaturation](Object#tintsaturation)

---

### Transparency

*(Formerly known as SetObjectTransparency, which is now obsolete)*

    int Object.Transparency

Gets/sets the object's transparency level.

If this is set to 100, it means that the object is totally invisible,
and lower values represent varying levels of transparency. Set this to 0
to stop the object being transparent.

**NOTE:** Transparency only works in 16-bit and 32-bit colour games.

**NOTE:** When using the DirectX 5 driver, a large transparent object
can significantly slow down AGS.

Some rounding is done internally when the transparency is stored --
therefore, if you get the transparency after setting it, the value you
get back might be one out. Therefore, using a loop with
`object[0].Transparency++;` is not recommended as it will probably end
too quickly.

In order to fade an object in/out, the best approach is shown in the
example below:

Example:

    int trans = object[0].Transparency;
    while (trans < 100) {
      trans++;
      object[0].Transparency = trans;
      Wait(1);
    }

will gradually fade out the object from its current transparency level
to being fully invisible.

*See Also:* [Character.Transparency](Character#transparency),
[GUI.Transparency](GUI#transparency)

---

### View

    readonly int Object.View

Gets the view that the object is currently set to. This is either the
view number, or 0 if the object is not currently assigned a view (in
which case the Graphic property will hold its sprite number instead).

This property is read-only. To change the view, use the SetView
function. To remove the view, set the Graphic property to a sprite slot.

Example:

    Display("Object oDoor's view is currently view %d.", oDoor.View);

will display the oDoor object's current view number

*SeeAlso:* [Object.SetView](Object#setview),
[Object.Graphic](Object#graphic),
[Object.Loop](Object#loop),
[Object.Frame](Object#frame)

---

### Visible

*(Formerly known as IsObjectOn, which is now obsolete)*<br>
*(Formerly known as ObjectOff, which is now obsolete)*<br>
*(Formerly known as ObjectOn, which is now obsolete)*

    bool Object.Visible

Gets/sets the visible state of the object. If this is 1 (true), the
object is switched on and visible in the room. If you set this to 0
(false), the object disappears and no longer appears in the room.

Example:

    object[5].Visible = false;

will make object number 5 in the current room disappear.

---

### X

*(Formerly known as GetObjectX, which is now obsolete)*

    int Object.X

Gets/sets the X co-ordinate of the object.

**NOTE:** This property cannot be changed while the object is moving.

Example:

    Display("Object 1's X co-ordinate is %d.", object[1].X);

will display the X co-ordinate of object 1.

*See Also:* [Object.Y](Object#y),
[Object.Animating](Object#animating),
[Object.Visible](Object#visible),
[Object.SetPosition](Object#setposition)

---

### Y

*(Formerly known as GetObjectY, which is now obsolete)*

    int Object.Y

Gets/sets the Y co-ordinate of the object, which is the bottom of the
object's image.

**NOTE:** This property cannot be changed while the object is moving.

**NOTE:** If you try to use this co-ordinate with Object.GetAtScreenXY,
you will find that the object does not get picked up. The object's
sprite is drawn from the Y co-ordinate at (Object.Y - Height) to
(Object.Y - 1).

Example:

    Display("Object 1's Y co-ordinate is %d.", object[1].Y);

will display the Y co-ordinate of object 1.

*See Also:* [Object.Animating](Object#animating),
[Object.Baseline](Object#baseline),
[Object.X](Object#x),
[Object.SetPosition](Object#setposition)

