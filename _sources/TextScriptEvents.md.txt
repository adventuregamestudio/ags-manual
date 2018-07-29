Predefined global script functions
----------------------------------

In your main global script file, there are some functions which are
automatically added when you create the game. These are global events,
and the function is called when a particular event happens. There are
also some other events which you can add if you want to.

The available event functions are:

dialog_request (int parameter)

Called when a dialog script line "run-script" is processed. PARAMETER is
the value of the number following the "run-script" on that line of the
dialog script.

game_start ()

Called at the start of the game, before the first room is loaded. You
can use this to set up the initial positions of characters, and to turn
GUIs on and off. **You cannot run animations or do anything else which
relies on a room being loaded**.

interface_click (int interface, int button)

**(Now Obsolete)** Called when the player clicks on a button on a GUI
which has its action set as "Run script". INTERFACE is the number of the
GUI which they clicked on. BUTTON is the object number of the button
within this GUI.

on_event (EventType event, int data)

Called whenever certain game events happen. The value of DATA depends on
which event has occurred. This allows you to perform checks or update
things every time the player does something, regardless of which room it
is in. The possible values of event are:

    eEventEnterRoomBeforeFadein
          called just before room Player Enters Room event is run.
          DATA = new room number
    eEventLeaveRoom
          called just after room Player Leaves Room event is run.
          DATA = room number they are leaving
    eEventGotScore
          called whenever the player's score changes
          DATA = number of points they got
    eEventGUIMouseDown
          called when a mouse button is pressed down over a GUI
          DATA = GUI number
    eEventGUIMouseUp
          called when a mouse button is released over a GUI
          DATA = GUI number
    eEventAddInventory
          the player just got a new inventory item
          DATA = inventory item number that was added
    eEventLoseInventory
          the player just lost an inventory item
          DATA = inventory item number that was lost
    eEventRestoreGame
          tells your game that it has just been restored from a save game
          DATA = save slot number

on_key_press (eKeyCode keycode)

Called whenever a key is pressed on the keyboard. KEYCODE holds the
ASCII value of the key. A list of these values is in [this section](ASCIIcodes).

on_mouse_click (MouseButton button)

Called when the player clicks a mouse button. BUTTON is either LEFT,
RIGHT or MIDDLE, depending on which button was clicked. The "mouse.x"
and "mouse.y" global variables contain the mouse's position.<br>
If 'Handle inventory clicks in script' is enabled in the game options,
this function can also be called with eMouseLeftInv, eMouseMiddleInv or
eMouseRightInv, which indicate a left, middle or right click on an
inventory item, respectively.<br>
If 'Enable mouse wheel support' is enabled, this function can also be
called with eMouseWheelNorth or eMouseWheelSouth, which indicate the
user moving the mouse wheel north or south, respectively.

repeatedly_execute()

Called every game cycle (normally 40 times per second). See
[this help page](RepExec) for more information.

repeatedly_execute_always()

Called every game cycle, even when a blocking routine (eg.
speech/cutscene) is in progress. You **cannot** call any blocking
functions from this event handler. **repeatedly_execute_always** is
called **BEFORE** the game objects (characters, rooms, etc) get updated.
See [this help page](RepExec) for more information.

late_repeatedly_execute_always()

Called every game cycle, even when a blocking routine (eg.
speech/cutscene) is in progress. You **cannot** call any blocking
functions from this event handler. **late_repeatedly_execute_always**
is called **AFTER** the game objects (characters, rooms, etc) got
updated, but before game is redrawn on screen.

unhandled_event (int what, int type)

Called when an event occurs, but no handler is set up in the Events
list. This could be used to display a default "I can't do that" type of
message. The values of WHAT and TYPE tell you what the player did.<br>
The possible values are listed below:

WHAT | TYPE | Description
--- | --- | ---
1 | 1 | Look at hotspot
1 | 2 | Interact with hotspot
1 | 3 | Use inventory on hotspot
1 | 4 | Talk to hotspot
1 | 7 | Pick up hotspot
1 | 8 | Cursor Mode 8 on hotspot
1 | 9 | Cursor Mode 9 on hotspot
2 | 0 | Look at object
2 | 1 | Interact with object
2 | 2 | Talk to object
2 | 3 | Use inventory on object
2 | 5 | Pick up object
2 | 6 | Cursor Mode 8 on object
2 | 7 | Cursor Mode 9 on object
3 | 0 | Look at character
3 | 1 | Interact with character
3 | 2 | Speak to character
3 | 3 | Use inventory on character
3 | 5 | Pick up character
3 | 6 | Cursor Mode 8 on character
3 | 7 | Cursor Mode 9 on character
4 | 1 | Look at nothing (ie. no hotspot)
4 | 2 | Interact with nothing
4 | 3 | Use inventory with nothing
4 | 4 | Talk to nothing
5 | 0 | Look at inventory
5 | 1 | Interact with inventory (currently not possible)
5 | 2 | Speak to inventory
5 | 3 | Use an inventory item on another
5 | 4 | Other click on inventory

Note that the "Character stands on hotspot" event does not trigger this
function, and it will not be triggered if there is an "Any click" event
defined.

This function is **not** triggered if the player clicks on nothing
(hotspot 0).

The *on_key_press* and *on_mouse_click* events can also be handled
by individual room scripts. If you add their function definitions to
your room script in a similar way to how they are in the global script,
the room script can intercept the keypress/mouseclick first, and then
decide whether to pass it on to the global script or not. See the
[ClaimEvent](Game#claimevent) function for more.
