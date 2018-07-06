[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags50.md#DialogOptionsRenderingInfoFunctions)
[![Next](forward.gif)](ags52.md#topic51)

------------------------------------------------------------------------

DrawingSurface functions and properties
---------------------------------------

The DrawingSurface family of functions allow you to directly draw onto
dynamic sprites and room backgrounds in the game. You get a drawing
surface by calling
[DynamicSprite.GetDrawingSurface](ags52.md#DynamicSprite.GetDrawingSurface)
or
[Room.GetDrawingSurfaceForBackground](ags73.md#Room.GetDrawingSurfaceForBackground),
and you can then use the following methods to draw onto the surface.

**IMPORTANT:** You **MUST** call the
[Release](ags51.md#DrawingSurface.Release) method when you have
finished drawing onto the surface. This allows AGS to update its cached
copies of the image and upload it to video memory if appropriate.

[Clear (drawing surface)](#DrawingSurface.Clear)\
[CreateCopy](#DrawingSurface.CreateCopy)\
[DrawCircle](#DrawingSurface.DrawCircle)\
[DrawImage](#DrawingSurface.DrawImage)\
[DrawLine](#DrawingSurface.DrawLine)\
[DrawMessageWrapped](#DrawingSurface.DrawMessageWrapped)\
[DrawPixel](#DrawingSurface.DrawPixel)\
[DrawRectangle](#DrawingSurface.DrawRectangle)\
[DrawString](#DrawingSurface.DrawString)\
[DrawStringWrapped](#DrawingSurface.DrawStringWrapped)\
[DrawSurface](#DrawingSurface.DrawSurface)\
[DrawTriangle](#DrawingSurface.DrawTriangle)\
[Release (drawing surface)](#DrawingSurface.Release)\
[DrawingColor property](#DrawingSurface.DrawingColor)\
[GetPixel](#DrawingSurface.GetPixel)\
[Height property (drawing surface)](#DrawingSurface.Height)\
[UseHighResCoordinates property](#DrawingSurface.UseHighResCoordinates)\
[Width property (drawing surface)](#DrawingSurface.Width)\

------------------------------------------------------------------------

[]()

### Clear (drawing surface)

*(Formerly known as RawClearScreen, which is now obsolete)*

    DrawingSurface.Clear(optional int colour)

Clears the surface to the specified COLOUR (this is a number you can
find in the Colours pane of the editor). The current contents of the
surface will be lost.

If you do not supply the COLOUR parameter, or use COLOR\_TRANSPARENT,
the surface will be cleared to be fully transparent.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.Clear(14);
    surface.DrawingColor = 13;
    surface.DrawCircle(160,100,50);
    surface.Release();

clears the room background to be fully yellow, then draws a pink circle
in the middle of it.

*See Also:*
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor)

------------------------------------------------------------------------

[]()

### CreateCopy

*(Formerly known as RawSaveScreen, which is now obsolete)*

    DrawingSurface* DrawingSurface.CreateCopy()

Makes a backup copy of the current surface, in order that it can be
restored later. This could be useful to back up a background scene
before writing over it, or to save a certain state of your drawing to
restore later.

Unlike the obsolete RawSaveScreen command in previous versions of AGS,
backup surfaces created with this command are not lost when the player
changes room or restores a game. However, surfaces containing a copy of
room backgrounds can be **very large**, using up a large amount of
memory and can increase the save game sizes significantly. Therefore, it
is **strongly recommended** that you Release any backup copy surfaces as
soon as you are done with them.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    DrawingSurface *backup = surface.CreateCopy();
    surface.DrawTriangle(0,0,160,100,0,200);
    Wait(80);
    surface.DrawSurface(backup);
    backup.Release();
    surface.Release();

will save a copy of the room background, draw a triangle onto it, wait
for a while and then restore the original background.

*See Also:*
[DrawingSurface.DrawSurface](ags51.md#DrawingSurface.DrawSurface)

------------------------------------------------------------------------

[]()

### DrawCircle

*(Formerly known as RawDrawCircle, which is now obsolete)*

    DrawingSurface.DrawCircle(int x, int y, int radius)

Draws a filled circle of radius RADIUS with its centre at (X,Y) in the
current drawing colour.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawCircle(160,100,50);
    surface.Release();

will draw a circle in the centre of the screen, of 50 pixels radius.

*See Also:*
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor)

------------------------------------------------------------------------

[]()

### DrawImage

*(Formerly known as RawDrawImage, which is now obsolete)*\
*(Formerly known as RawDrawImageResized, which is now obsolete)*\
*(Formerly known as RawDrawImageTransparent, which is now obsolete)*

    DrawingSurface.DrawImage(int x, int y, int slot, optional int transparency,
                             optional int width, optional int height)

Draws image SLOT from the sprite manager onto the surface at location
(X,Y).

Optionally, you can also specify the transparency of the image. This is
a number from 0-100; using a *transparency* of 50 will draw the image
semi-transparent; using 0 means it will not be transparent.

You can also resize the image as you draw it. In order to do this,
simply specify a *width* and *height* that you wish to resize the image
to when it is drawn.

**NOTE:** This command only works if the image to be drawn is the same
colour depth as the surface that you are drawing onto.

**NOTE:** Transparency does not work in 256-colour games, or with
256-colour sprites.

**NOTE:** The X and Y co-ordinates given are ROOM co-ordinates, not
SCREEN co-ordinates. This means that in a scrolling room you can draw
outside the current visible area.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawImage(100, 100, oDoor.Graphic, 40);
    surface.Release();

will draw the *oDoor* object's graphic onto the room background at (100,
100), at `40%` transparency.

*See Also:*
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString),
[DrawingSurface.DrawSurface](ags51.md#DrawingSurface.DrawSurface),
[Room.ColorDepth](ags73.md#Room.ColorDepth)

------------------------------------------------------------------------

[]()

### DrawLine

*(Formerly known as RawDrawLine, which is now obsolete)*

    DrawingSurface.DrawLine(int from_x, int from_y, int to_x, int to_y,
                            optional int thickness)

Draws a line from (FROM\_X, FROM\_Y) to (TO\_X, TO\_Y) in the surface's
current drawing colour.

The *thickness* parameter allows you to specify how thick the line is,
the default being 1 pixel.

**NOTE:** The X and Y co-ordinates given are ROOM co-ordinates, not
SCREEN co-ordinates. This means that in a scrolling room you can draw
outside the current visible area.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawLine(0, 0, 160, 100);
    surface.Release();

will draw a line from the left top of the screen (0,0) to the middle of
the screen (160,100);

*See Also:*
[DrawingSurface.DrawCircle](ags51.md#DrawingSurface.DrawCircle),
[DrawingSurface.DrawRectangle](ags51.md#DrawingSurface.DrawRectangle),
[DrawingSurface.DrawTriangle](ags51.md#DrawingSurface.DrawTriangle),
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor)

------------------------------------------------------------------------

[]()

### DrawMessageWrapped

*(Formerly known as RawPrintMessageWrapped, which is now obsolete)*

    DrawingSurface.DrawMessageWrapped(int x, int y, int width,
                                      FontType font, int message_number)

Draws the room message MESSAGE\_NUMBER onto the surface at (x,y), using
the specified FONT.

WIDTH is the width of the virtual textbox enclosing the text, and is the
point that the text will wrap at. This command is designed for writing a
long message to the screen with it wrapping normally like a standard
label would do.

The text will be printed using the current drawing colour.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawMessageWrapped(80, 40, 160, Game.NormalFont, 10);
    surface.Release();

will display message 10 in the centre of the screen, starting from Y =
40.

*See Also:*
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString),
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor),
[DrawingSurface.DrawStringWrapped](ags51.md#DrawingSurface.DrawStringWrapped)

------------------------------------------------------------------------

[]()

### DrawPixel

    DrawingSurface.DrawPixel(int x, int y)

Draws a single pixel onto the surface at (X,Y) in the current colour.
The pixel thickness respects the
[UseHighResCoordinates](ags51.md#DrawingSurface.UseHighResCoordinates)
property.

**NOTE:** This command is not fast enough to use repeatedly to build up
an image. Only use it for single pixel adjustments.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawPixel(50, 50);
    surface.Release();

draws a yellow pixel in the top left of the room background

*See Also:*
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor),
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.GetPixel](ags51.md#DrawingSurface.GetPixel),
[DrawingSurface.UseHighResCoordinates](ags51.md#DrawingSurface.UseHighResCoordinates)

------------------------------------------------------------------------

[]()

### DrawRectangle

*(Formerly known as RawDrawRectangle, which is now obsolete)*

    DrawingSurface.DrawRectangle(int x1, int y1, int x2, int y2)

Draws a filled rectangle in the current colour with its top-left corner
at (x1,y1) and its bottom right corner at (x2, y2)

**NOTE:** The X and Y co-ordinates given are ROOM co-ordinates, not
SCREEN co-ordinates. This means that in a scrolling room you can draw
outside the current visible area.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawRectangle(0, 0, 160, 100);
    surface.Release();

will draw a rectangle over the top left hand quarter of the screen.

*See Also:*
[DrawingSurface.DrawImage](ags51.md#DrawingSurface.DrawImage),
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine)

------------------------------------------------------------------------

[]()

### DrawString

*(Formerly known as RawPrint, which is now obsolete)*

    DrawingSurface.DrawString(int x, int y, FontType font, string text, ...)

Draws the *text* onto the surface at (x, y), using the supplied font
number. The text will be drawn in the current drawing colour.

You can insert the value of variables into the message. For more
information, see the [string formatting](ags34.md#StringFormats)
section.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawString(0, 100, Game.NormalFont, "Text written into the background!");
    surface.Release();

will write some text onto the middle-left of the room background

*See Also:* [GetTextWidth](ags54.md#GetTextWidth),
[DrawingSurface.DrawStringWrapped](ags51.md#DrawingSurface.DrawStringWrapped),
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor)

------------------------------------------------------------------------

[]()

### DrawStringWrapped

    DrawingSurface.DrawStringWrapped(int x, int y, int width,
                                     FontType font, Alignment,
                                     const string text)

Draws the *text* onto the surface at (x,y), using the specified FONT.

*width* is the width of the virtual textbox enclosing the text, and is
the point that the text will wrap at. You can use the *alignment*
parameter to determine how the text is horizontally aligned.

The text will be printed using the current drawing colour.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawStringWrapped(80, 40, 160, Game.NormalFont, eAlignCentre, "Hello, my name is Bob.");
    surface.Release();

will display the text in the centre of the screen, starting from Y = 40.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:*
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString),
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor),
[DrawingSurface.DrawMessageWrapped](ags51.md#DrawingSurface.DrawMessageWrapped)

------------------------------------------------------------------------

[]()

### DrawSurface

*(Formerly known as RawDrawFrameTransparent, which is now obsolete)*\
*(Formerly known as RawRestoreScreen, which is now obsolete)*

    DrawingSurface.DrawSurface(DrawingSurface *source, optional int transparency)

Draws the specified surface on top of this surface, optionally using
*transparency* percent transparency.

This allows you to perform day-to-night fading and other special
effects.

**NOTE:** You cannot use the *transparency* parameter with 256-colour
surfaces.

**NOTE:** This command can be a bit on the slow side, so don't call it
from repeatedly\_execute.

**TIP:** If you want to gradually fade in a second background, create a
copy of the original surface and then restore it after each iteration,
otherwise the backgrounds will converge too quickly.

Example:

    DrawingSurface *mainBackground = Room.GetDrawingSurfaceForBackground(0);
    DrawingSurface *nightBackground = Room.GetDrawingSurfaceForBackground(1);
    mainBackground.DrawSurface(nightBackground, 50);
    mainBackground.Release();
    nightBackground.Release();

this will draw background frame 1 onto frame 0 at 50`%` opacity.

*See Also:*
[DrawingSurface.DrawImage](ags51.md#DrawingSurface.DrawImage),
[SetAmbientTint](ags54.md#SetAmbientTint)

------------------------------------------------------------------------

[]()

### DrawTriangle

*(Formerly known as RawDrawTriangle, which is now obsolete)*

    DrawingSurface.DrawTriangle(int x1, int y1, int x2, int y2, int x3, int y3)

Draws a filled triangle in the current colour with corners at the points
(x1,y1), (x2,y2) and (x3,y3).

Well, don't look at me, you might find it useful for something :-)

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawTriangle(0,0,160,100,0,200);
    surface.Release();

will draw a triangle with corners at the points (0,0),(160,100),(0,200).

*See Also:*
[DrawingSurface.DrawImage](ags51.md#DrawingSurface.DrawImage),
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.DrawRectangle](ags51.md#DrawingSurface.DrawRectangle)

------------------------------------------------------------------------

[]()

### Release (drawing surface)

    DrawingSurface.Release()

Tells AGS that you have finished drawing onto this surface, and that AGS
can now upload the changed image into video memory.

After calling this method, you can no longer use the DrawingSurface
instance. To do any further drawing, you need to get the surface again.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawLine(0, 0, 50, 50);
    surface.Release();

draws a yellow diagonal line across the top-left of the current room
background, then releases the image.

*See Also:*
[DynamicSprite.GetDrawingSurface](ags52.md#DynamicSprite.GetDrawingSurface),
[Room.GetDrawingSurfaceForBackground](ags73.md#Room.GetDrawingSurfaceForBackground)

------------------------------------------------------------------------

[]()

### DrawingColor property

*(Formerly known as RawSetColor, which is now obsolete)*

    int DrawingSurface.DrawingColor

Gets/sets the current drawing colour on this surface. Set this before
using commands like [DrawLine](ags51.md#DrawingSurface.DrawLine), which
use this colour for their drawing.

You can set this either to an AGS Colour Number (as you'd get from the
Colours pane in the editor) or to the special constant
COLOR\_TRANSPARENT, which allows you to draw transparent areas onto the
surface.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.DrawingColor = 14;
    surface.DrawLine(0, 0, 160, 100);
    surface.DrawingColor = Game.GetColorFromRGB(255, 255, 255);
    surface.DrawLine(0, 199, 160, 100);
    surface.Release();

will draw a yellow line from the left top of the screen (0,0) to the
middle of the screen (160,100), and a white line from the bottom left to
the middle.

*See Also:*
[DrawingSurface.DrawCircle](ags51.md#DrawingSurface.DrawCircle),
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.DrawRectangle](ags51.md#DrawingSurface.DrawRectangle),
[Game.GetColorFromRGB](ags54.md#Game.GetColorFromRGB)

------------------------------------------------------------------------

[]()

### GetPixel

    int DrawingSurface.GetPixel(int x, int y)

Returns the AGS Colour Number of the pixel at (X,Y) on the surface.

**NOTE:** In high-colour games, the first 32 colour numbers have a
special meaning due to an AGS feature which maintains compatibility with
8-bit games. Therefore, if you draw onto the surface using a blue colour
number 0-31 you will get a different number when you GetPixel -- and in
fact the colour drawn may not be what you expect. To get around this,
add 1 Red or Green component to adjust the colour number out of this
range.

**NOTE:** This command is relatively slow. Don't use it to try and
process an entire image.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    Display("The colour of the middle pixel is %d.", surface.GetPixel(160, 100));
    surface.Release();

displays the pixel colour of the centre pixel on the screen.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:*
[DrawingSurface.DrawingColor](ags51.md#DrawingSurface.DrawingColor),
[DrawingSurface.DrawPixel](ags51.md#DrawingSurface.DrawPixel),
[DrawingSurface.UseHighResCoordinates](ags51.md#DrawingSurface.UseHighResCoordinates)

------------------------------------------------------------------------

[]()

### Height property (drawing surface)

    readonly int DrawingSurface.Height

Gets the height of the surface.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    Display("The background is %d x %d!", surface.Width, surface.Height);
    surface.Release();

displays the size of the surface to the player

*See Also:*
[DrawingSurface.UseHighResCoordinates](ags51.md#DrawingSurface.UseHighResCoordinates),
[DrawingSurface.Width](ags51.md#DrawingSurface.Width)

------------------------------------------------------------------------

[]()

### UseHighResCoordinates property

    bool DrawingSurface.UseHighResCoordinates

Gets/sets whether you want to use high-resolution co-ordinates with this
surface.

By default, this property will be set such that drawing surface
co-ordinates use the same co-ordinate system as the rest of the game, as
per the "Use low-res co-ordinates in script" game setting. However, if
your game is 640x400 or higher you can customize whether this drawing
surface uses native co-ordinates or the low-res 320x200 co-ordinates by
changing this property.

Setting this property affects **ALL** other commands performed on this
drawing surface, including the [Width](ags51.md#DrawingSurface.Width)
and [Height](ags51.md#DrawingSurface.Height) properties.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    surface.UseHighResCoordinates = true;
    surface.DrawingColor = 14;
    surface.DrawLine(0, 0, 320, 200);
    surface.Release();

draws a yellow line from the top left of the screen to the middle of the
screen. If we hadn't set *UseHighResCoordinates* to true, this would
draw a line from the top left to the bottom right of the screen.

*See Also:*
[DrawingSurface.DrawCircle](ags51.md#DrawingSurface.DrawCircle),
[DrawingSurface.DrawLine](ags51.md#DrawingSurface.DrawLine),
[DrawingSurface.DrawRectangle](ags51.md#DrawingSurface.DrawRectangle),
[DrawingSurface.DrawTriangle](ags51.md#DrawingSurface.DrawTriangle)

------------------------------------------------------------------------

[]()

### Width property (drawing surface)

    readonly int DrawingSurface.Width

Gets the width of the surface.

Example:

    DrawingSurface *surface = Room.GetDrawingSurfaceForBackground();
    Display("The background is %d x %d!", surface.Width, surface.Height);
    surface.Release();

displays the size of the surface to the player

*See Also:* [DrawingSurface.Height](ags51.md#DrawingSurface.Height),
[DrawingSurface.UseHighResCoordinates](ags51.md#DrawingSurface.UseHighResCoordinates)


