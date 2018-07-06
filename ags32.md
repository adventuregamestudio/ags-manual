[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags31.md#Pointers)
[![Next](forward.gif)](ags33.md#topic45)

------------------------------------------------------------------------

Calling global functions from local scripts
-------------------------------------------

You can now call your global script functions directly from your rooms.
This means that if you have a common script that you want to use in
response to various different events during the game, you can call it
from your room scripts rather than duplicating code.

To use a global function, open up the main script header
(GlobalScript.ash), and add a line similar to the following:

    import function my_function_name (parameters);

Where *my\_function\_name* is the name of the global script function,
and *parameters* is a list of the TYPES ONLY of the parameters it takes.
For example, if you had in your global script:

    function do_animation (int anim_number) {

then you would write:

    import function do_animation (int);

To use the function, you just call it normally in your script, eg:

    do_animation (3);

You can also return a value to the caller by using the "return"
statement, and the local script picks this up the same way it does with
built-in functions. For example, the end of your global script function
could be:

    return 51;

then the local script just does:

    int value = do_animation(3);
