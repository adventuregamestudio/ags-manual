[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags40.md#TextScriptEvents)
[![Next](forward.gif)](ags42.md#CustomDialogOptions)

------------------------------------------------------------------------

repeatedly\_execute (\_always)
------------------------------

One of the most common things you'll need to do when scripting is to
check if something has happened in the game -- and if so, then make the
game do something in response.

For example, suppose that you want a bird to fly backwards and forwards
across the screen in the background. You need a way of telling the bird
to move in one direction, recognise when it has finished, and tell it to
move back again.

This is where *repeatedly\_execute*, *repeatedly\_execute\_always* and
*late\_repeatedly\_execute\_always* come in.

**What's the difference between them?**

The *repeatedly\_execute* event is run on every game loop (by default
this is 40 times per second), but only when the game is not blocked.
That means that it will run as long as there are no current blocking
animations or moves going on (ie. a Walk or Animate command where
*eBlock* has been specified as a parameter).

On the other hand, *repeatedly\_execute\_always* and
*late\_repeatedly\_execute\_always* are always run on every game loop,
no matter whether the game is blocked or not. This comes at a price
though, which is that you cannot run any blocking code within it. So if
you try to script a *player.Walk()* command that passes the *eBlock*
parameter -- or even just try to use a `Wait(1);` command, these will
fail within *(late\_)repeatedly\_execute\_always*.

The difference between *repeatedly\_execute\_always* and
*late\_repeatedly\_execute\_always* is that first is run **before** game
updates itself, changing animation frames, moving objects into new
position etc, while the second, "late" version, is run **after** the
game was updated, but before it redrew its new state on screen.

**What would I use each one for?**

You would usually use *repeatedly\_execute* for doing things that affect
the player character, and *repeatedly\_execute\_always* for doing
background tasks that don't directly affect the player.

For example, if your game kept track of the player's hunger, you might
want to check in *repeatedly\_execute* how long it has been since he
last ate -- and if it has been more than 20 minutes, make the player
character stop walking and rub his stomach. Because you want to perform
a blocking animation, and you wouldn't want this to interrupt any
specific cutscenes that were going on, repeatedly\_execute would be the
ideal place for it.

On the other hand, in the case of our bird flying across the screen,
because we don't want to block the game while the bird flies, and we
just want it to happen in the background, *repeatedly\_execute\_always*
would be the place to put it.

The *late\_repeatedly\_execute\_always* is used in similar way to its
"earlier" counterpart, but it may be essential if you need to precisely
keep track of a game object movement. When
*late\_repeatedly\_execute\_always* is called all the objects are
already updated to their new states, therefore you will have accurate
information about them. On contrary, the *repeatedly\_execute\_always*
will always be "one step behind" of the game state.

In a nutshell, if you need to do something right before game state
changes, use *repeatedly\_execute\_always*, if you need to do something
right after game state has changed, use
*late\_repeatedly\_execute\_always*.

**How do I create them?**

In main game scripts, you create your *repeatedly\_execute* script
function by just pasting it into the script as follows. In the
GlobalScript.asc it is already created for you:

    function repeatedly_execute()
    {
      // Put your script code here
    }

In rooms, it is slightly different. If you want to run some script that
is specific to a particular room, open that room's Events Pane and
you'll see a "Repeatedly execute" event. Click the "..." button and a
function called something like *Room\_RepExec* will be created for you.

This is important to remember -- in a room script, **you cannot simply
paste in a repeatedly\_execute function**; you need to use the Events
Pane to create it instead.

To create *repeatedly\_execute\_always*, you can simply paste it into
the script as above -- but you can also paste it into room scripts.
Therefore the following will work in any script, whether it be a room or
a global script.

    function repeatedly_execute_always()
    {
      // Put your script code here
    }

Remember, of course, that RepExec or *repeatedly\_execute\_always*
functions in a room script will only be run while the player is actually
in that room!

**Can you show me an example?**

Let's implement the two things we just talked about. Here's our hunger
checking code:

    function repeatedly_execute()
    {
      // increment our timer variable (we would have created this
      // in the Global Variables editor)
      hungerTimer++;

      if (hungerTimer == 800)
      {
        Display("You are getting very hungry.");
        player.LockView(RUBSTOMACH);
        player.Animate(0, 5, eOnce, eBlock, eForwards);
        player.UnlockView();
      }
    }

and let's put the bird flying code in the room script, because we only
want it to happen in that one room:

    function repeatedly_execute_always()
    {
      if (!cBird.Moving)
      {
        if (cBird.x < 100)
        {
          // if the bird is on the left hand side of the screen,
          // start it moving towards the right
          cBird.Walk(400, cBird.y, eNoBlock, eAnywhere);
        }
        else
        {
          // otherwise, move it towards the left
          cBird.Walk(0, cBird.y, eNoBlock, eAnywhere);
        }
      }
    }
