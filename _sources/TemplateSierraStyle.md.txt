## Sierra-style template

This template was previously listed as the 'default' template, with the majority
of functions used being native to the engine itself. i.e. there is no separate
script file to implement any additional behaviour for the mouse cursor. This
makes it a good choice for learning how AGS works, since it makes heavy use of
the [mouse cursor functions](Mouse).

As a general guide, right clicking changes your cursor mode, left clicking uses
the current cursor mode.

This template also contains the majority of examples for save game and option
handling, and also demonstrates the default handling for an inventory window.

One script module is included, which allows the main character to be controlled
with the keyboard. This is switched on and configured with some default
settings, but can be reconfigured or switched off entirely by using the defined
functions.

Example:

    // configure the player for arcade action
    KeyboardMovement.SetMode(eKeyboardMovementModePressing);
    KeyboardMovement.SetKeyUp(eKeyW);
    KeyboardMovement.SetKeyDown(eKeyS);
    KeyboardMovement.SetKeyLeft(eKeyA);
    KeyboardMovement.SetKeyRight(eKeyD);

---

### KeyboardMovement.SetMode

    KeyboardMovement.SetMode(KeyboardMovementMode newmode);

Sets the keyboard movement mode. Possible values are:

`eKeyboardMovementModeNone` (disable keyboard control)<br>
`eKeyboardMovementModeTapping` (tap a direction to move)<br>
`eKeyboardMovementModePressing` (hold down a direction to move)

---

### KeyboardMovement.SetKeyUp

    KeyboardMovement.SetKeyUp(eKeyCode up);

Assigns the key used to move the player upwards.

---

### KeyboardMovement.SetKeyDown

    KeyboardMovement.SetKeyDown(eKeyCode down);

Assigns the key used to move the player downwards.

---

### KeyboardMovement.SetKeyLeft

    KeyboardMovement.SetKeyLeft(eKeyCode left);

Assigns the key used to move the player to the left.

---

### KeyboardMovement.SetKeyRight

    KeyboardMovement.SetKeyRight(eKeyCode right);

Assigns the key used to move the player to the right.
