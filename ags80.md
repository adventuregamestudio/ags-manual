[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags79.md#topic74)
[![Next](forward.gif)](ags81.md#topic76)

------------------------------------------------------------------------

SCUMM\_VERBCOIN\_GUI functions
------------------------------

SCUMM\_VERBCOIN\_GUI is a script module that is included with the Verb
Coin template. The functions in this section are only available if you
have created your game using that template.

[SCUMM\_VERBCOIN\_GUI Deselect](#SCUMM_VERBCOIN_GUI.Deselect)\
[SCUMM\_VERBCOIN\_GUI
DisableVerbCoinGUI](#SCUMM_VERBCOIN_GUI.DisableVerbCoinGUI)\
[SCUMM\_VERBCOIN\_GUI
DoubleClickSpeed](#SCUMM_VERBCOIN_GUI.DoubleClickSpeed)\
[SCUMM\_VERBCOIN\_GUI GoInventory](#SCUMM_VERBCOIN_GUI.GoInventory)\
[SCUMM\_VERBCOIN\_GUI Item\_Count](#SCUMM_VERBCOIN_GUI.Item_Count)\
[SCUMM\_VERBCOIN\_GUI
InvScroll\_Left](#SCUMM_VERBCOIN_GUI.InvScroll_Left)\
[SCUMM\_VERBCOIN\_GUI
InvScroll\_Right](#SCUMM_VERBCOIN_GUI.InvScroll_Right)\
[SCUMM\_VERBCOIN\_GUI
Inv\_Border\_active](#SCUMM_VERBCOIN_GUI.Inv_Border_active)\
[SCUMM\_VERBCOIN\_GUI
Inv\_Border\_SetPos](#SCUMM_VERBCOIN_GUI.Inv_Border_SetPos)\
[SCUMM\_VERBCOIN\_GUI
Inventory\_GUI](#SCUMM_VERBCOIN_GUI.Inventory_GUI)\
[SCUMM\_VERBCOIN\_GUI
RunInteraction](#SCUMM_VERBCOIN_GUI.RunInteraction)\
[SCUMM\_VERBCOIN\_GUI Select](#SCUMM_VERBCOIN_GUI.Select)\
[SCUMM\_VERBCOIN\_GUI Verbcoin\_GUI](#SCUMM_VERBCOIN_GUI.Verbcoin_GUI)\
[SCUMM\_VERBCOIN\_GUI verbgraphic](#SCUMM_VERBCOIN_GUI.verbgraphic)\
[SCUMM\_VERBCOIN\_GUI doubleclick
variable](#SCUMM_VERBCOIN_GUI.doubleclick)\

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Deselect

    static SCUMM_VERBCOIN_GUI.Deselect()

Deselect an item if it is active or quit the inventory. Used for
keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM\_VERBCOIN\_GUI.RunInteraction](ags80.md#SCUMM_VERBCOIN_GUI.RunInteraction),
[SCUMM\_VERBCOIN\_GUI.Select](ags80.md#SCUMM_VERBCOIN_GUI.Select)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI DisableVerbCoinGUI

    static SCUMM_VERBCOIN_GUI.DisableVerbCoinGUI(bool disabled)

Activates/deactivates the SCUMM Verbcoin GUI system. This can be used to
turn the SCUMM VerbCoin system on and off at runtime.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.DisableVerbCoinGUI(true);

will disable all verbcoin processing code.

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI DoubleClickSpeed

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
[SCUMM\_VERBCOIN\_GUI.doubleclick](ags80.md#SCUMM_VERBCOIN_GUI.doubleclick)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI GoInventory

    static SCUMM_VERBCOIN_GUI.GoInventory()

This function opens and closes your inventory.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Item\_Count

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
[SCUMM\_VERBCOIN\_GUI.InvScroll\_Left](ags80.md#SCUMM_VERBCOIN_GUI.InvScroll_Left),
[SCUMM\_VERBCOIN\_GUI.InvScroll\_Right](ags80.md#SCUMM_VERBCOIN_GUI.InvScroll_Right)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI InvScroll\_Left

    static SCUMM_VERBCOIN_GUI.InvScroll_Left()

Scrolls the inventory to the left, by the number of items set with
Item\_Count.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM\_VERBCOIN\_GUI.Item\_Count](ags80.md#SCUMM_VERBCOIN_GUI.Item_Count),
[SCUMM\_VERBCOIN\_GUI.InvScroll\_Right](ags80.md#SCUMM_VERBCOIN_GUI.InvScroll_Right)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI InvScroll\_Right

    static SCUMM_VERBCOIN_GUI.InvScroll_Right()

Scrolls the inventory to the right, by the number of items set with
Item\_Count.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM\_VERBCOIN\_GUI.Item\_Count](ags80.md#SCUMM_VERBCOIN_GUI.Item_Count),
[SCUMM\_VERBCOIN\_GUI.InvScroll\_Left](ags80.md#SCUMM_VERBCOIN_GUI.InvScroll_Left)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Inv\_Border\_active

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
[SCUMM\_VERBCOIN\_GUI.Inv\_Border\_SetPos](ags80.md#SCUMM_VERBCOIN_GUI.Inv_Border_SetPos)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Inv\_Border\_SetPos

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
[SCUMM\_VERBCOIN\_GUI.Inv\_Border\_active](ags80.md#SCUMM_VERBCOIN_GUI.Inv_Border_active)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Inventory\_GUI

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

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI RunInteraction

    static SCUMM_VERBCOIN_GUI.RunInteraction(CursorMode)

Runs the event of choice. Used for keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

Example:

    SCUMM_VERBCOIN_GUI.RunInteraction(eModeTalkto);

*See Also:*
[SCUMM\_VERBCOIN\_GUI.Deselect](ags80.md#SCUMM_VERBCOIN_GUI.Deselect),
[SCUMM\_VERBCOIN\_GUI.Select](ags80.md#SCUMM_VERBCOIN_GUI.Select)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Select

    static SCUMM_VERBCOIN_GUI.Select()

Selects an item, or if an item is active tries to use it. Used for
keyboard support.

**NOTE:** This function is part of the Verb Coin template and is only
available if you used this template to create your game.

*See Also:*
[SCUMM\_VERBCOIN\_GUI.Deselect](ags80.md#SCUMM_VERBCOIN_GUI.Deselect),
[SCUMM\_VERBCOIN\_GUI.RunInteraction](ags80.md#SCUMM_VERBCOIN_GUI.RunInteraction)

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI Verbcoin\_GUI

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

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI verbgraphic

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

------------------------------------------------------------------------

[]()

### SCUMM\_VERBCOIN\_GUI doubleclick variable

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
[SCUMM\_VERBCOIN\_GUI.DoubleClickSpeed](ags80.md#SCUMM_VERBCOIN_GUI.DoubleClickSpeed)


