[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags37.md#DynamicArrays)
[![Next](forward.gif)](ags39.md#Gamevariables)

------------------------------------------------------------------------

Extender functions
------------------

Suppose that you wanted to add a new function, "Scream", to characters
which would make them cry out "AARRRGGGHHH". Because the Character type
is defined within AGS, it's not possible for you to just add a method to
it.

That's where Extender Functions come in. Here's an example:

    function Scream(this Character*)
    {
      this.Say("AAAAARRRRGGGGHHHHHH!!!!");
    }

This adds a new "Scream" function to the Character type, so that in your
script code elsewhere you can do things like:

    player.Scream();
    character[EGO].Scream();
    cJohn.Scream();

and so on.

**Where do I put this code?**

In the script header, you'd put:

`import function Scream(this Character*);`

and then put the main function in the script file. This will then allow
it to be used by other scripts.

**Static extenders**

Since AGS 3.4.0 you may also create static extender functions, that is
functions that are called from type, rather than an actual object.
Static extender declaration is a bit different, for example:

    int AbsInt(static Maths, int value)
    {
      if (value < 0)
        return -value;
      return value;
    }

You declare the function's import in the script header:

`import int AbsInt(static Maths, int value);`

and you use such function as:

    int x = Maths.AbsInt(-10);
