SCUMM_VERBCOIN_GUI functions
------------------------------

SCUMM_VERBCOIN_GUI is a script module that is included with the Verb
Coin template. The functions in this section are only available if you
have created your game using that template.

[Deselect](#deselect)<br>
[DisableVerbCoinGUI](#disableverbcoingui)<br>
[DoubleClickSpeed](#doubleclickspeed)<br>
[GoInventory](#goinventory)<br>
[Item_Count](#item_count)<br>
[InvScroll_Left](#invscroll_left)<br>
[InvScroll_Right](#invscroll_right)<br>
[Inv_Border_active](#inv_border_active)<br>
[Inv_Border_SetPos](#inv_border_setpos)<br>
[Inventory_GUI](#inventory_gui)<br>
[RunInteraction](#runinteraction)<br>
[Select](#select)<br>
[Verbcoin_GUI](#verbcoin_gui)<br>
[verbgraphic](#verbgraphic)<br>
[doubleclick (variable)](#doubleclick-variable)

---

### Deselect

    static SCUMM_VERBCOIN_GUI.Deselect()

Deselect an item if it is active or quit the inventory. Used for
keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM_VERBCOIN_GUI.RunInteraction](#runinteraction),
[SCUMM_VERBCOIN_GUI.Select](#select)

---

### DisableVerbCoinGUI

    static SCUMM_VERBCOIN_GUI.DisableVerbCoinGUI(bool disabled)

Activates/deactivates the SCUMM Verbcoin GUI system. This can be used to
turn the SCUMM VerbCoin system on and off at runtime.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.DisableVerbCoinGUI(true);

will disable all verbcoin processing code.

---

### DoubleClickSpeed

    static SCUMM_VERBCOIN_GUI.DoubleClickSpeed(int speed)

Sets the time frame in which a double-click can be registered. Increase
this value for slower double-clicks, decrease this value for quicker
double-clicks.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.DoubleClickSpeed(GetGameSpeed()/4);

will set the double-click speed to 1/4 of a second. (This is a good
default)

*See Also:*
[SCUMM_VERBCOIN_GUI.doubleclick](#doubleclick-variable)

---

### GoInventory

    static SCUMM_VERBCOIN_GUI.GoInventory()

This function opens and closes your inventory.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

---

### Item_Count

    static SCUMM_VERBCOIN_GUI.Item_Count(int count)

Sets the number of items that inventory scrolling will use to position
to the next x amount of items.

This value should equal the amount of items that fit in your inventory
window.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.Item_Count(10);

will make sure that on the next inventory scroll you will start with
item 11, 21, 31, ...

*See Also:*
[SCUMM_VERBCOIN_GUI.InvScroll_Left](#invscroll_left),
[SCUMM_VERBCOIN_GUI.InvScroll_Right](#invscroll_right)

---

### InvScroll_Left

    static SCUMM_VERBCOIN_GUI.InvScroll_Left()

Scrolls the inventory to the left, by the number of items set with
Item_Count.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM_VERBCOIN_GUI.Item_Count](#item_count),
[SCUMM_VERBCOIN_GUI.InvScroll_Right](#invscroll_right)

---

### InvScroll_Right

    static SCUMM_VERBCOIN_GUI.InvScroll_Right()

Scrolls the inventory to the right, by the number of items set with
Item_Count.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM_VERBCOIN_GUI.Item_Count](#item_count),
[SCUMM_VERBCOIN_GUI.InvScroll_Left](#invscroll_left)

---

### Inv_Border_active

    static SCUMM_VERBCOIN_GUI.Inv_Border_active(bool x_borders, bool y_borders)

Sets which inventory exit borders are active.

Inventory exit borders determine where the inventory will exit when
moving over a line.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.Inv_Border_active(false, true);

will make the game exit the inventory when moving the mouse over either
the top or the bottom of the screen.

*See Also:*
[SCUMM_VERBCOIN_GUI.Inv_Border_SetPos](#inv_border_setpos)

---

### Inv_Border_SetPos

    static SCUMM_VERBCOIN_GUI.Inv_Border_SetPos(int top, int bottom,
                                                int left, int right)

Sets the inventory exit border positions.

Inventory exit borders determine where the inventory will exit when
moving over a line.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.Inv_Border_SetPos(20, 220, 20, 295);

will set the top exit border to y-coordinate 20, the bottom border to
y-coordinate 220, the left border to x-coordinate 20 and the right
border to x-coordinate 295

*See Also:*
[SCUMM_VERBCOIN_GUI.Inv_Border_active](#inv_border_active)

---

### Inventory_GUI

    static SCUMM_VERBCOIN_GUI.Inventory_GUI(int gInventory_ID,int gInvUnderlay_ID)

Sets the inventory gui ID's, so the module will know which GUI is your
inventory and which GUI is the inventory underlay.

This allows you to change your inventory GUI's on the fly, which is
particularly interesting if you have a game with multiple playable
characters. You could have a different inventory for each character!

If the game is 32-bit with alpha-blended (transparent) GUI buttons on
the inventory, you need to use an Underlay gui which contains the actual
inventory background, and the regular gui which is empty except for the
inventory window and the gui buttons.

If your game does not use alpha-blended GUI buttons, leave the underlay
inventory empty. (use sprite 0 for its background)

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.Inventory_GUI(2, 3);

will tell the module your inventory gui is GUI nr.2 and that the
underlay gui is GUI nr.3

---

### RunInteraction

    static SCUMM_VERBCOIN_GUI.RunInteraction(CursorMode)

Runs the event of choice. Used for keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.RunInteraction(eModeTalkto);

*See Also:*
[SCUMM_VERBCOIN_GUI.Deselect](#deselect),
[SCUMM_VERBCOIN_GUI.Select](#select)

---

### Select

    static SCUMM_VERBCOIN_GUI.Select()

Selects an item, or if an item is active tries to use it. Used for
keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM_VERBCOIN_GUI.Deselect](#deselect),
[SCUMM_VERBCOIN_GUI.RunInteraction](#runinteraction)

---

### Verbcoin_GUI

    static SCUMM_VERBCOIN_GUI.Verbcoin_GUI(int gVerbcoin_ID)

Sets the verbcoin gui ID, so the module will know which GUI is your
verbcoin GUI.

This is particularly useful if you have a game with multiple playable
characters, where you could have a different verbcoin for each
character.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.Verbcoin_GUI(1);

will tell the module your verbcoin gui is GUI nr.1

---

### verbgraphic

    static SCUMM_VERBCOIN_GUI.verbgraphic(ButtonChoice, int sprite_number)

Attaches a verbcoin sprite to a button. This sprite will be displayed
when moving over the button.

The only exception is the 'bIdle' button, which is not a button but the
default verbcoin graphic with no buttons active.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.verbgraphic(bTalk, 2);

will set the sprite for moving over the talk button to sprite 2

---

### doubleclick (variable)

    global bool doubleclick

Used to determine when a double-click has occured.

**NOTE:** This variable is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

      if (doubleclick == false){
        Display("You made a single-click");
      }
      else{
        Display("You just made a double-click!");
      }

will display "You made a single-click" when you made a single-click on
the object/hotspot/character/...

*See Also:*
[SCUMM_VERBCOIN_GUI.DoubleClickSpeed](#doubleclickspeed)
