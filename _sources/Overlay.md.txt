## Overlay functions and properties

### CreateGraphical

*(Formerly known as CreateGraphicOverlay, which is now obsolete)*

    static Overlay* Overlay.CreateGraphical(int x, int y, int slot, bool transparent)

Creates a screen overlay containing a copy of the image from SLOT in the
Sprite Manager. The image is placed at (X,Y) on the screen (these are
screen co-ordinates, not room co-ordinates).

If *transparent* is true then the overlay will be drawn in the same way
as characters/objects, if it is false then a black rectangle will be
painted behind the sprite.

See the description of
[Overlay.CreateTextual](Overlay#createtextual) for more on
overlays.

Example:

    Overlay* myOverlay = Overlay.CreateGraphical(100, 100, 300, true);
    Wait(40);
    myOverlay.Remove();

will create an overlay of the image stored in sprite manager's slot 300,
at the coordinates 100,100. It will display for 1 second, then remove
it.

*See Also:* [Overlay.CreateTextual](Overlay#createtextual),
[Overlay.Remove](Overlay#remove)

---

### CreateTextual

*(Formerly known as CreateTextOverlay, which is now obsolete)*

    static Overlay* Overlay.CreateTextual(int x, int y, int width,
                                          FontType font, int color, string text)

Creates a screen overlay containing the text you pass at the position
specified. A screen overlay looks identical to the way speech text is
displayed in conversations, except that with this command the text stays
on the screen until either you remove it with the Remove command, or the
player goes to a different room, in which case it is automatically
removed.

The X and Y parameters specify the upper-left corner of where the text
will be written. WIDTH is the width, in pixels, of the text area. FONT
is the font number from the editor to use (0 is the normal font, 1 is
the speech font). COLOR is the text color - use one of the colours from
1 to 15. Finally, TEXT is obviously the text that gets displayed.

The function returns the Overlay, which you use later to reposition and
remove the overlay.

You can insert the value of variables into the message. For more
information, see the [string formatting](StringFormats)
section.

**NOTE:** large overlays, in the same way as objects, can impact
performance while displayed.

**NOTE:** there is currently a maximum of 10 overlays displayed at any
one time. Some other commands such as Say and SayBackground create
overlays internally, so don't rely on being able to create 10 with
CreateTextual.

**NOTE:** if the Overlay object goes out of scope, the overlay will be
removed. Hence, if you want the overlay to last on-screen outside of the
script function where it was created, the `Overlay*` variable
declaration needs to be at the top of the script and outside any script
functions.

Example:

    Overlay* myOverlay = Overlay.CreateTextual(50,80,120, Game.SpeechFont, 15,"This is a text overlay");
    Wait(40);
    myOverlay.Remove();

will display a 120 pixels text area with its upper left corner at
coordinates 50,80 containing the string "This is a text overlay" using
the speech font and white color. It will be displayed for 1 second, then
removed.

*See Also:*
[Overlay.CreateGraphical](Overlay#creategraphical),
[Overlay.X](Overlay#x), [Overlay.Y](Overlay#y),
[Overlay.Remove](Overlay#remove)

---

### Remove

*(Formerly known as RemoveOverlay, which is now obsolete)*

    Overlay.Remove()

Removes the specified overlay from the screen. Use this when you are
done using the overlay.

Example:

    Overlay* myOverlay = Overlay.CreateTextual(50,80,120,2,15,"This is a text overlay");
    Wait(200);
    myOverlay.Remove();

will create a text overlay , wait for 200 game cycles (about 5 seconds)
and then remove the overlay from the screen.

*See Also:* [Overlay.CreateTextual](Overlay#createtextual)

---

### SetText

*(Formerly known as SetTextOverlay, which is now obsolete)*

    Overlay.SetText(int width, FontType font, int color, string text, ...)

Replaces the specified overlay with a new one, at the same co-ordinates
but with the new specified text, width, font and colour.

You can insert the value of variables into the message. For more
information, see the [string formatting](StringFormats)
section.

Example:

    Overlay* myOverlay = Overlay.CreateTextual(50,80,120,Game.SpeechFont,15,"This is a text overlay");
    Wait(200);
    myOverlay.SetText(120,Game.SpeechFont,15,"This is another text overlay");

will create a text overlay , wait for 200 game cycles (about 5 seconds)
and then replace the overlay with another one.

*See Also:* [Overlay.CreateTextual](Overlay#createtextual),
[Overlay.Remove](Overlay#remove)

---

### Valid

*(Formerly known as IsOverlayValid, which is now obsolete)*

    readonly bool Overlay.Valid;

Checks whether the overlay is a current overlay or not. Returns 1 if it
is, 0 if it isn't.

Example:

    Overlay* myOverlay = Overlay.CreateTextual(50,80,120,2,15,"This is a text overlay");
    Display("Overlay valid before: %d", myOverlay.Valid);
    myOverlay.Remove();
    Display("Overlay valid after: %d", myOverlay.Valid);

creates an overlay, and prints out the Valid property (which will be 1).
Then, removes the overlay and prints Valid again (which will now be 0).

*See Also:* [Overlay.CreateTextual](Overlay#createtextual),
[Overlay.Remove](Overlay#remove)

---

### X

*(Formerly known as MoveOverlay, which is now obsolete)*

    int Overlay.X;

Gets/sets the X co-ordinate of the overlay (ie. the left hand side of
the overlay).

This allows you to dynamically move overlays around the screen.

Example:

    Overlay* testOverlay = Overlay.CreateTextual(50,80,120,2,15,"This is a text overlay");
    while (testOverlay.X < 100) {
      testOverlay.X++;
      Wait(1);
    }
    testOverlay.Remove();

creates a text overlay, then gradually slides it across the screen.

*See Also:* [Overlay.CreateTextual](Overlay#createtextual),
[Overlay.Y](Overlay#y),
[Overlay.Remove](Overlay#remove)

---

### Y

*(Formerly known as MoveOverlay, which is now obsolete)*

    int Overlay.Y;

Gets/sets the Y co-ordinate of the overlay (ie. the top edge of the
overlay).

This allows you to dynamically move overlays around the screen.

Example:

    Overlay* testOverlay = Overlay.CreateTextual(50,50,120,2,15,"This is a text overlay");
    while (testOverlay.Y < 100) {
      testOverlay.Y++;
      Wait(1);
    }
    testOverlay.Remove();

creates a text overlay, then gradually slides it down the screen.

*See Also:* [Overlay.CreateTextual](Overlay#createtextual),
[Overlay.X](Overlay#x),
[Overlay.Remove](Overlay#remove)
