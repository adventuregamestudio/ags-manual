[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags34.md#StringFormats)
[![Next](forward.gif)](ags36.md#BlockingScripts)

------------------------------------------------------------------------

Multiple Scripts
----------------

If you're working on a fairly large game, you'll find that your global
script can quickly become rather large and unwieldy. AGS allows you to
create extra scripts (formerly known as Script Modules) in order to
split up your code and easily import scripts written by other people.

The main global script still has to contain all the event functions
(Look At Character scripts, Interact With Inventory scripts and so
forth) and all the GUI handlers (btnSave\_Click, etc).

But if you have any custom functions then you can put them in a separate
script in order to divide up your code. Scripts have the added advantage
that they can be easily exported and imported, if you want to share some
of your code with other people, or even just move it from one game to
another.

The scripts for the game can be seen under the "Scripts" node in the
project tree. Each script has its own header, which is where you place
the [import](ags44.md#importkeyword) definitions for that script to
allow the rest of your game to access its functionality.

The order of the scripts is important. A script can only use
functionality from other scripts that come before it in the list, so the
Move Up and Move Down options allow you to adjust the order. The global
script is always at the bottom so that it can access all other scripts,
and room scripts are automatically provided with access to all the
scripts.

As an example, suppose you want to have a special *AddNumbers* function
in a module. You'd create a new script, then put this in its header file
(.ASH):

    import function AddNumbers(int a, int b);

Then, in the script file (.ASC) you could put:

    function AddNumbers(int a, int b) {
      return a + b;
    }

That's the basic principle behind using multiple scripts!

**Special functions**

Can extra scripts use special functions like `game_start` and
`repeatedly_execute`? Well, yes and no. They can contain the following
functions, and they will be called at the appropriate times just before
the global script's function is:

-   function game\_start()
-   function on\_event(EventType event, int data)
-   function on\_key\_press(eKeyCode keycode)
-   function on\_mouse\_click(MouseButton button)
-   function repeatedly\_execute()
-   function repeatedly\_execute\_always()
-   function late\_repeatedly\_execute\_always()

All other special functions, such as `dialog_request`, will only be
called in the Global Script, even if they exist in another script. If
you need other scripts to handle any of this functionality, you can
simply create a custom function in the script and then call it from the
global script.

The [ClaimEvent](ags54.md#ClaimEvent) command is supported for
on\_key\_press, on\_mouse\_click and on\_event. Calling it prevents the
rest of the scripts (including the global script) from being called.
