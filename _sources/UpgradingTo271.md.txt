Upgrading to AGS 2.71
---------------------

AGS 2.71 adds new simple string support to the scripting language.
Strings have long been a pain to use in AGS, but this is finally
addressed by v2.71.

There's a new String type (that's a capital 'S'). These new strings
behave like Java/`C#` strings in that you can easily assign to and
manipulate them.

For example, in 2.7 and previous versions, you had to do this:

    string text;
    StrCopy(text, "This is my text");

in 2.71, you can now do:

    String text = "This is my text";

Furthermore, the == and != operators can be used to compare strings for
equality (equivalent to using StrComp but much more intuitive). An
additional benefit is that there is no longer a need for GetText() and
SetText() methods -- instead, we can now just have Text properties.

All the old-style functions that took a "string buffer" parameter have
now been replaced with new ones that return a string instead. Where
properties have been created, you should be able to use them like any
other property, so:

    lblLabel.Text = "Hello";
    String buttonValue = btnOK.Text;

and so on.

**NOTE:** Some of the new functions are provided on the Game object --
for example, the new GetSaveSlotDescription function needs to be called
like this:<br>
`String description = Game.GetSaveSlotDescription(10);`<br>
This is part of a move towards all built-in functions being
object-based, but watch out for it as it could well cause some
confusion. The manual will show you which functions require this.

Rather than using old functions like StrCat and StrContains, you now
call the functions directly on the strings:

    String text = "Hello";
    text = text.Append("World");

will mean that *text* now contains "HelloWorld".<br>
Note the **text =** in that expression. Functions like Append will
return a modified version of the string, they won't actually change the
original. Therefore, to update the *text* variable you need to assign
the result to it.

**Backwards compatibility**

In order to maintain backwards compatibility, a new "const" keyword has
been added. This applies only to old-style strings, and allows them to
interoperate with the new ones. A new-style String can be passed to a
function that expects a "const string" (which means that it will not be
allowed to change the string's contents), but cannot be passed to a
function that expects a "string" (since it could overwrite the string
data and mess things up).

So, you may find that any custom functions you have that take a string
parameter stop working. If this is the case, change the parameter from
"string" to "const string" and that should fix it.

Apologies for the inconvenience, but this is the only way to allow new
Strings to interoperate safely with old-style strings.
