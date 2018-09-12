## Button functions and properties

### Click

    Button.Click()

Forces Button's OnClick event. If there is a script function bound to
that event it will be run, otherwise nothing happens.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [GUI.Click](GUI#click),
[GUI.ProcessClick](GUI#processclick)

---

### Animate

*(Formerly known as AnimateButton, which is now obsolete)*

    Button.Animate(int view, int loop, int delay, RepeatStyle)

Animates a GUI button by playing the specified view loop on it. This
could be useful for Sierra-style death animations and other effects.

LOOP from VIEW will be played on the button. The DELAY specifies the
speed of the animation - larger numbers are slower. This has the same
values you use with the Character.Animate and Object.Animate commands.

REPEAT determines whether the animation will loop repeatedly, or just
play once and stop with the last frame showing (eOnce or eRepeat are the
possible values).

You can abort an animation at any time by setting the button's
NormalGraphic property, or starting a new animation on the same button.

**NOTE:** This command destroys the button's normal, pushed and
mouseover images. If you want to return the button to normal usage after
playing an animation, you will have to set the Graphic properties to
restore the images.

**NOTE:** This command does not support flipped view frames. Any frames
marked as "Flipped" will in fact be drawn normally when on a button.

Example:

    btnDeathAnim.Animate(6, 2, 4, eRepeat);

will animate the 'btnDeathAnim' button using loop 2 of view 6, with a
delay of 4 cycles per frame, and repeat the animation continually.

*See Also:* [Button.Animating](Button#animating),
[Button.Frame](Button#frame),
[Button.Loop](Button#loop),
[Button.View](Button#view),
[Button.NormalGraphic](Button#normalgraphic)

---

### Animating

    readonly bool Button.Animating

Returns true if the specified button is currently animating, or false
otherwise.

This property is read-only. To change button's animation, use the
[Animate](Button#animate) command.

Example:

    btnDeathAnim.Animate(6, 2, 4, eRepeat);
    while (btnDeathAnim.Animating) Wait(1);

will animate button and wait until the animation finishes.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Button.Animate](Button#animate),
[Button.Frame](Button#frame),
[Button.Loop](Button#loop),
[Button.View](Button#view),
[Button.Graphic](Button#graphic)

---

### Frame

    readonly int Button.Frame

Gets the frame number that the animated button is currently set to. If
the button is not currently animated, this will be 0 (in which case the
Graphic property will hold its sprite number).

This property is read-only. To change button's animation, use the
[Animate](Button#animate) command.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Button.Animating](Button#animating),
[Button.Loop](Button#loop),
[Button.View](Button#view),
[Button.Graphic](Button#graphic)

---

### Loop

    readonly int Button.Loop

Gets the loop that the animated button is currently set to. If the
button is not currently animated, this will be 0 (in which case the
Graphic property will hold its sprite number).

This property is read-only. To change button's animation, use the
[Animate](Button#animate) command.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Button.Animate](Button#animate),
[Button.Frame](Button#frame),
[Button.View](Button#view),
[Button.Graphic](Button#graphic)

---

### View

    readonly int Button.View

Gets the view that the animated button is currently set to. If the
button is not currently animated, this will be 0 (in which case the
Graphic property will hold its sprite number).

This property is read-only. To change button's animation, use the
[Animate](Button#animate) command.

*Compatibility:* Supported by **AGS 3.4.1** and later versions.

*See Also:* [Button.Animate](Button#animate),
[Button.Frame](Button#frame),
[Button.Loop](Button#loop),
[Button.Graphic](Button#graphic)

---

### ClipImage

    bool Button.ClipImage;

Gets/sets whether the button clips its image to the button boundaries.

For example, if the button is sized 30x30, but its Graphic is a 50x50
image, then this property controls whether the image is allowed to spill
over the edge of the button.

The default is false, ie. the image is not clipped.

Setting this to true can be useful in that it ensures that the button's
image is not larger than the button's clickable area, which can cause
confusion when it happens.

Example:

    btnOK.ClipImage = true;

sets the *btnOK* button so that its image will be restrained to the
button's clickable area.

*See Also:* [Button.Graphic](Button#graphic)

---

### Font

    FontType Button.Font

Gets/sets the font used by the button to display text.

The font number must correspond to one of the fonts from the Fonts pane
in the AGS Editor.

Example:

    btnOK.Font = eFontMain;

will change the *btnOK* button to use Font "Main".

*See Also:* [Label.Font](Label#font),
[TextBox.Font](TextBox#font)

---

### Graphic

*(Formerly part of GetButtonPic, which is now obsolete)*

    readonly int Button.Graphic;

Gets the current image on a GUI button. If a value less than 1 is
returned, then no image is currently displayed on the button.

This property is read-only; in order to set the image, you must use one
of the [NormalGraphic](Button#normalgraphic),
[MouseOverGraphic](Button#mouseovergraphic) or
[PushedGraphic](Button#pushedgraphic) properties.

Example:

    Display("The button is currently using sprite %d.", btnPlay.Graphic);

will display btnPlay's current sprite number.

*See Also:* [Button.ClipImage](Button#clipimage),
[Button.MouseOverGraphic](Button#mouseovergraphic),
[Button.NormalGraphic](Button#normalgraphic),
[Button.PushedGraphic](Button#pushedgraphic)

---

### MouseOverGraphic

*(Formerly part of GetButtonPic, which is now obsolete)*<br>
*(Formerly part of SetButtonPic, which is now obsolete)*

    int Button.MouseOverGraphic;

Gets/sets the button's mouse-over sprite. This can be -1, which
indicates that the button does not have a mouse-over graphic.

Example:

    Display("The button's mouse-over image is sprite %d.", btnPlay.MouseOverGraphic);

will display btnPlay's mouse-over sprite number.

*See Also:* [Button.Graphic](Button#graphic),
[Button.NormalGraphic](Button#normalgraphic),
[Button.PushedGraphic](Button#pushedgraphic)

---

### NormalGraphic

*(Formerly part of GetButtonPic, which is now obsolete)*<br>
*(Formerly part of SetButtonPic, which is now obsolete)*

    int Button.NormalGraphic;

Gets/sets the button's normal sprite (ie. the graphic used when the
button is not pushed and the mouse is not over it).

Note that setting this to a different sprite will change the button's
size to match the size of the new sprite.

Example:

    Display("The button's normal image is sprite %d.", btnPlay.NormalGraphic);

will display btnPlay's normal sprite number.

*See Also:* [Button.ClipImage](Button#clipimage)
[Button.Graphic](Button#graphic),
[Button.MouseOverGraphic](Button#mouseovergraphic),
[Button.PushedGraphic](Button#pushedgraphic),
[Button.TextColor](Button#textcolor)

---

### PushedGraphic

*(Formerly part of GetButtonPic, which is now obsolete)*<br>
*(Formerly part of SetButtonPic, which is now obsolete)*

    int Button.PushedGraphic;

Gets/sets the button's pushed sprite (ie. the graphic used when the
button is pushed in by the user). This can be -1, which indicates that
the button does not have a pushed image.

Example:

    Display("The button's pushed image is sprite %d.", btnPlay.PushedGraphic);

will display btnPlay's pushed sprite number.

*See Also:* [Button.Graphic](Button#graphic),
[Button.MouseOverGraphic](Button#mouseovergraphic),
[Button.NormalGraphic](Button#normalgraphic)

---

### Text

*(Formerly known as SetButtonText, which is now obsolete)*<br>
*(Formerly known as Button.GetText, which is now obsolete)*<br>
*(Formerly known as Button.SetText, which is now obsolete)*

    String Button.Text;

Gets/sets the text displayed on the button.

Example:

    Display("Button displayed: %s", btnController.Text);
    btnController.Text = "Enable jibble";

will display the old text, then change button btnController to read
'Enable jibble'.

*See Also:* [Button.NormalGraphic](Button#normalgraphic),
[Label.Text](Label#text)

---

### TextColor

    int Button.TextColor;

Gets/sets the text colour used to display the button's text.

If the button is displaying an image rather than text, then this
property has no effect.

Example:

    btnRestart.TextColor = 15;

will change button 'btnRestart' to have white text.

*See Also:* [Button.NormalGraphic](Button#normalgraphic)

