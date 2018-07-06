[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags12.md#topic20)
[![Previous](back.gif)](ags18.md#topic30)
[![Next](forward.gif)](ags20.md#topic31)

------------------------------------------------------------------------

Global variables
----------------

The Global Variables pane allows you to easily add variables to your
game which can then be accessed from all your scripts.

In previous versions of AGS, declaring a global variable in the script
involved defining it in three different places, with import and export
clauses in the appropriate locations. Now, this whole process is vastly
simplified with the new Global Variables Editor.

**When should I use a global variable?**

Use a global variable when you need to store some information that you
need to access from different scripts. For example, if you want to store
the player's health and you want all your different scripts to be able
to access this value, then use a global variable.

If you just need to store some information locally (for example, a "door
opened" flag that only applies to one particular room) then you should
declare the variable manually at the top of the room's script file
instead.

**What about GlobalInts and Graphical Variables?**

GlobalInts and Graphical Variables were ways in which previous versions
of AGS provided global variable capabilities. They are now considered
obsolete, and are replaced with this new Global Variables system
instead.

**How do I use global variables?**

The Global Variables Editor is pretty self-explanitory. To add a
variable, right-click and choose "Add". You can name the variable, and
choose its type and initial value. Most of the time you'll probably be
using the *int* and *String* types. Optionally, you can also set a
default value for the variable.

Then, in your scripts it's a simple matter of just using the variable
with the name that you gave it. Simple! So, for example if you add an
int global variable called "myVariable", then in your script you can
just do things like this:

    if (myVariable == 3)
    {
      myVariable = 4;
    }

or

`Display("myVariable: %d", myVariable);`

That's it! Just use it as you'd use any other variable declared in the
script.

Note that some of the types available are managed instance pointers,
like "GUI", "DynamicSprite" and "Character". These are for more advanced
users only. If you create one of these you cannot set a default value,
and it will initially be set to *null*. You will need to initialize the
pointer in your script to point to something before you use it.
