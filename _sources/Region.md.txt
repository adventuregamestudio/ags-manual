Region functions and properties
-------------------------------

[GetAtRoomXY](#getatroomxy)<br>
[RunInteraction](#runinteraction)<br>
[Tint](#tint)<br>
[Enabled property](#enabled)<br>
[ID property](#id)<br>
[LightLevel property](#lightlevel)<br>
[TintEnabled property](#tintenabled)<br>
[TintBlue property](#tintblue)<br>
[TintGreen property](#tintgreen)<br>
[TintRed property](#tintred)<br>
[TintSaturation property](#tintsaturation)<br>
[TintLuminance property](#tintluminance)

---

### GetAtRoomXY

*(Formerly known as global function GetRegionAt, which is now obsolete)*

    static Region* Region.GetAtRoomXY(int x, int y)

Returns the region at ROOM co-ordinates (X,Y). If there is no region
there, or if invalid co-ordinates are specified, the Region\*
representing region 0 will be returned.

**NOTE:** Unlike GetHotspotAtLocation, the co-ordinates specified are
ROOM co-ordinates. This means that if you want to use the mouse cursor
location, you have to add the screen offset to make it work in scrolling
rooms.

Example:

    if (Region.GetAtRoomXY(player.x, player.y) == region[0])
      Display("The player is not currently standing on a region.");

*See Also:* [GetWalkableAreaAt](Room#getwalkableareaat)

---

### RunInteraction

*(Formerly known as RunRegionInteraction, which is now obsolete)*

    Region.RunInteraction(int event)

Runs the event handler as if the EVENT for the region had been
activated.

**NOTE:** Unlike the other RunInteraction commands, this one does not
take a cursor mode. Instead, it uses an event type as follows:

0 While player stands on region<br>
1 Player walks onto region<br>
2 Player walks off region

Example:

    region[4].RunInteraction(1);

will run the actions defined in the event handler script for "Player
walks onto region" for region 4.

*See Also:*
[Character.RunInteraction](Character#runinteraction),
[Hotspot.RunInteraction](Hotspot#runinteraction)

---

### Tint

*(Formerly known as SetRegionTint, which is now obsolete)*

    Region.Tint(int red, int green, int blue, int amount, optional int luminance)

Changes the region to have RGB tint (RED, GREEN, BLUE) with AMOUNT
percent saturation.

The red, green and blue values are between 0 and 255, and you supply the
same values that you would use in the editor.

For the meaning of all the parameters, see
[SetAmbientTint](Game#setambienttint).

**NOTE**: The tint will be reset when the player leaves the room, so you
need to use it in Player Enters Room if you want a permanent change.

**NOTE:** This function only works in hi-colour games.

**NOTE**: To remove the region tint, set the LightLevel property to 0.

Example:

    region[2].Tint(180, 20, 20, 50);

will set region 2's RGB tint to (180, 20, 20) with 50`%` opacity.

*Compatibility:* Optional *luminance* parameter is supported only by
**AGS 3.4.0** and later versions.

*See Also:* [Region.LightLevel](Region#lightlevel),
[SetAmbientTint](Game#setambienttint)

---

### Enabled

*(Formerly known as DisableRegion, which is now obsolete)*<br>
*(Formerly known as EnableRegion, which is now obsolete)*

    bool Region.Enabled

Enables/disables the specified region. If you set this to false, then
all areas of the screen that were previously part of the region now act
as type 0 (no region). You can turn the region back on later by setting
this to true.

While a region is disabled, it will not be returned by
Region.GetAtRoomXY, and if the character walks onto the region then its
events will not get run.

Example:

    region[3].Enabled = false;

will disable region number 3.

*See Also:* [Hotspot.Enabled](Hotspot#enabled),
[RemoveWalkableArea](Room#removewalkablearea),
[RestoreWalkableArea](Room#restorewalkablearea)

---

### ID

    readonly int Region.ID

Gets the region number of this region. This allows you to interoperate
with old script using the number-based region functions.

Example:

    Display("Region 3 is number %d.", region[3].ID);

displays region 3's number (which will be 3).

*See Also:* [Region.GetAtRoomXY](Region#getatroomxy)

---

### LightLevel

*(Formerly known as SetAreaLightLevel, which is now obsolete)*

    int Region.LightLevel

Gets/sets the region's light level. This does the same thing as the
Light Level textbox in the editor, but allows you to change it at
run-time.

The light level is from **-100 to 100**. This is different from the
editor, which takes values from 0 to 200. Subtract 100 from the value
you would use in the editor when calling this function. The reason for
this discrepancy is legacy reasons from the DOS editor days.

In 8-bit games you cannot use positive light level for brightening
effect, but you may still use negative values to produce darkening
effect.

To disable region lighting and tinting effects, set LightLevel to 0.

**NOTE**: The light level will be reset to the editor settings when the
player leaves the room, so you need to use it in Player Enters Room if
you want a permanent change.

**NOTE**: Setting a light level will disable any RGB tint set for the
region.

**NOTE:** Region's light level does NOT override individual character
and object light levels.

Example:

    if (GetGlobalInt(10)==1)
        region[2].LightLevel = 100;

will set region 2's level light to 100 if the Global Integer 10 is 1.

*See Also:* [Region.Tint](Region#tint),
[SetAmbientLightLevel](Game#setambientlightlevel),
[Character.SetLightLevel](Character#setlightlevel),
[Object.SetLightLevel](Object#setlightlevel)

---

### TintEnabled

    readonly bool Region.TintEnabled

Gets whether the region currently has an RGB tint enabled for it.

Returns *true* if it does, and *false* if it does not. If it does not,
then the LightLevel property reflects the region lighting.

If this property is *false*, then the TintRed, TintGreen, TintBlue,
TintSaturation and TintLuminance properties are invalid.

Example:

    if (region[4].TintEnabled) {
      Display("Region 4 is tinted!!");
    }

will display a message if region 4 is tinted

*See Also:* [Region.Tint](Region#tint)

---

### TintBlue

    readonly int Region.TintBlue

Gets the *Blue* setting for the region's current tint.

This property is read-only; to change it, use the
[Region.Tint](Region#tint) command.

**NOTE:** If the [Region.TintEnabled](Region#tintenabled)
property is false, then this value is meaningless.

Example:

    if (region[4].TintEnabled) {
      Display("Region 4 is tinted RGB (%d,%d,%d) Saturation %d.",
              region[4].TintRed, region[4].TintGreen,
              region[4].TintBlue, region[4].TintSaturation);
    }

will display a message with the region's tints.

*See Also:* [Region.Tint](Region#tint),
[Region.TintEnabled](Region#tintenabled),
[Region.TintGreen](Region#tintgreen),
[Region.TintRed](Region#tintred),
[Region.TintLuminance](Region#tintluminance)

---

### TintGreen

    readonly int Region.TintGreen

Gets the *Green* setting for the region's current tint.

This property is read-only; to change it, use the
[Region.Tint](Region#tint) command.

**NOTE:** If the [Region.TintEnabled](Region#tintenabled)
property is false, then this value is meaningless.

Example:

    if (region[4].TintEnabled) {
      Display("Region 4 is tinted RGB (%d,%d,%d) Saturation %d.",
              region[4].TintRed, region[4].TintGreen,
              region[4].TintBlue, region[4].TintSaturation);
    }

will display a message with the region's tints.

*See Also:* [Region.Tint](Region#tint),
[Region.TintEnabled](Region#tintenabled),
[Region.TintBlue](Region#tintblue),
[Region.TintRed](Region#tintred),
[Region.TintSaturation](Region#tintsaturation),
[Region.TintLuminance](Region#tintluminance)

---

### TintRed

    readonly int Region.TintRed

Gets the *Red* setting for the region's current tint.

This property is read-only; to change it, use the
[Region.Tint](Region#tint) command.

**NOTE:** If the [Region.TintEnabled](Region#tintenabled)
property is false, then this value is meaningless.

Example:

    if (region[4].TintEnabled) {
      Display("Region 4 is tinted RGB (%d,%d,%d) Saturation %d.",
              region[4].TintRed, region[4].TintGreen,
              region[4].TintBlue, region[4].TintSaturation);
    }

will display a message with the region's tints.

*See Also:* [Region.Tint](Region#tint),
[Region.TintEnabled](Region#tintenabled),
[Region.TintBlue](Region#tintblue),
[Region.TintGreen](Region#tintgreen),
[Region.TintSaturation](Region#tintsaturation),
[Region.TintLuminance](Region#tintluminance)

---

### TintSaturation

    readonly int Region.TintSaturation

Gets the *saturation* setting for the region's current tint.

This property is read-only; to change it, use the
[Region.Tint](Region#tint) command.

**NOTE:** If the [Region.TintEnabled](Region#tintenabled)
property is false, then this value is meaningless.

Example:

    if (region[4].TintEnabled) {
      Display("Region 4 is tinted RGB (%d,%d,%d) Saturation %d.",
              region[4].TintRed, region[4].TintGreen,
              region[4].TintBlue, region[4].TintSaturation);
    }

will display a message with the region's tints.

*See Also:* [Region.Tint](Region#tint),
[Region.TintEnabled](Region#tintenabled),
[Region.TintBlue](Region#tintblue),
[Region.TintGreen](Region#tintgreen),
[Region.TintRed](Region#tintred),
[Region.TintLuminance](Region#tintluminance)

---

### TintLuminance

    readonly int Region.TintLuminance

Gets the *luminance* setting for the region's current tint.

This property is read-only; to change it, use the
[Region.Tint](Region#tint) command.

**NOTE:** If the [Region.TintEnabled](Region#tintenabled)
property is false, then this value is meaningless.

*See Also:* [Region.Tint](Region#tint),
[Region.TintEnabled](Region#tintenabled),
[Region.TintBlue](Region#tintblue),
[Region.TintGreen](Region#tintgreen),
[Region.TintRed](Region#tintred),
[Region.TintSaturation](Region#tintsaturation)

