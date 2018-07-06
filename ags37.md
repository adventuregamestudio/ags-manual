[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags36.md#BlockingScripts)
[![Next](forward.gif)](ags38.md#ExtenderFunctions)

------------------------------------------------------------------------

Dynamic Arrays
--------------

Suppose that you're writing a script that you want people to be able to
use in their games. You need to store the Health for every character in
the game, but you don't know how many characters there will be. What do
you do?

Dynamic Arrays are designed for just this purpose. You can declare an
array like this:

`int characterHealth[];`

in your script file. This special notation tells AGS that you don't yet
know how large you want the array to be. Now, before you use the array
(so probably in game\_start), you can do this:

`characterHealth = new int[Game.CharacterCount];`

If you forget to do this `new` command, you'll get a Null Pointer Error
if you try to access the array. You can change the size of an array by
simply using another `new` command with a different size; but this will
erase the contents of the array in the process.

Currently dynamic arrays are supported as global and local variables, or
members of normal (not managed) structs. Also, at present you can create
arrays of basic types (int, char, etc) and of built-in types (String,
Character, etc) but not of custom structs.
