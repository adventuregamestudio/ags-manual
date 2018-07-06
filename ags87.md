[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags.md)
[![Previous](back.gif)](ags86.md#topic85)
[![Next](forward.gif)](ags88.md#UpgradingTo271)

------------------------------------------------------------------------

Upgrading to AGS 2.7
--------------------

The script language in AGS 2.7 has changed quite significantly from
previous versions. Many of the script commands have become
*object-based*, which has several advantages over the previous approach.
This page will attempt to introduce you to the new method and explain
its benefits.

Firstly, so that you can get an idea of the changes, here's an example
of some old-style script commands and their new equivalents:

    AnimateObjectEx(0,2,0,0,0,1);
    ListBoxAdd(3, 5, "New item");

becomes:

    oWaterfall.Animate(2, 0, eOnce, eForwards, eBlock);
    lstTest.AddItem("New item");

Just from looking at that example the advantages should be obvious; the
script is more intuitive for people to learn, much easier to read (no
guessing what all the numbers mean in the AnimateObjectEx call), and
therefore you're less likely to make mistakes when using it. GUI
controls having names brings it much more into line with Visual
Basic-style GUI development, so you don't have to remember what control
number all your buttons are.

The script editor's autocomplete functionality has been significantly
enhanced to aid in all this as well. You'll see as you start to
experiment that autocomplete pops up more often and lists only the
relevant commands thanks to object-based scripting.

**So does this mean I have to throw out all my scripts?**

No, certainly not! The new version is fully backwards compatible, so all
your existing scripts will continue to work just fine. However, for any
new scripts that you write, it's strongly recommended that you use the
new object-based commands.

**Ok, so uh... what's changed exactly?**

The script language syntax hasn't changed at all (that's the way you use
semicolons, brackets, and so on). It's still just like it was before,
but with some new additions. Most significantly, most commands are now
called **on something**. For example, the old command:

`StopMoving(EGO);`

Just from looking at that, it's not at all obvious what StopMoving does.
Does it stop a character moving, an object moving, or does it stop the
screen moving? It's not intuitive. So now, rather than supplying the
character as a parameter to the function, you actually call the function
**on** the character. So:

`character[EGO].StopMoving();`

Now it's perfectly clear that it's the character EGO that we want to
stop moving.

Suppose you're wondering what commands you can call on a character.
Previously it was hard to tell, but now if you type `character[EGO].` in
the script editor, auto-complete will pop up and list all the valid
functions and properties that you can access on the character.

**So I have to keep typing character\[EGO\] all the time? What a pain!**

Not so fast! Most of the new object-based commands can be called in two
ways -- either through the main array as we just saw, but also through
what's called the character's **Script O-Name**. This is a shorthand
that allows you to directly access things, and for characters it is the
script name in sentence case, with a "c" added to the beginning. So, in
this example it would be:

`cEgo.StopMoving();`

This line has an identical effect to the one with character\[EGO\] that
we used above.

Furthermore, the *player* variable is now kept up to date with the
current player character, so it is actually useful. In a multi-character
game, what you previously had to write like this:

`StopMoving(GetPlayerCharacter());`

can now be done like this:

`player.StopMoving();`

**Hmm, I see... so what exactly has been object-ised?**

Currently, the following object-based things are available:

  ------------------ --------------------
  **Global array**   **O-Name example**
  character\[\]      cEgo
  object\[\]         oDoor
  hotspot\[\]        hTree
  gui\[\]            gInventory
  inventory\[\]      iPinkPoster
  region\[\]         (none)
  ------------------ --------------------

GUI controls are handled slightly differently. They all have a script
name, and are directly accessed via that. For example, if you set the
script name of a list box to "lstSaves", then you would use "lstSaves."
to access it. There is no global array of GUI controls.

**How do I find out the new equivalents of old functions?**

The help file's index has been set up to automatically redirect you to
the new commands. Just open the help file, go to the index and type in
the name of an old command, and it will bring you to the new
object-based equivalent (if there is one).

**Which commands haven't been changed?**

Commands which don't operate on anything in particular (and therefore
wouldn't really benefit from being object-based) have been left alone.
For example, SaveGameSlot, QuitGame and so on have all remained
identical to how they were in previous versions.

**What's the deal with these "eBlock" type things?**

AGS now supports **enumerated types**. Basically, in situations where
you have to choose one from a list of possible options, an enumerated
type (or *enum*) now steps in. In the past, you had commands with
descriptions like this:

"Pass 1 if you want the function to block, or 0 if you don't".

This lead to lots of 1's and 0's in function calls, which are hard to
read. Now, instead of this each number is represented by an
easy-to-remember word (such as *eBlock* and *eNoBlock*). Even better,
when you call a function that uses an enum parameter, auto-complete
automatically pops up the list of options for you to choose from.

See the [enum keyword](ags44.md#enum) description for information on
how to create your own.

**So do I have to pass all these things like eBlock every time I call
the function?**

Nope! Many functions now support **optional parameters**, where the most
common options are selected automatically. If you look at the help for a
function such as the [Animate character
command](ags47.md#Character.Animate), you'll see some of the parameters
are defined as "optional". This means that you don't have to supply
them; if you don't, the default option that will be chosen is described
in the help for that command.

**So what else is new?**

Well, 2.7 introduces the *float* data type, so AGS now finally supports
floating-point arithmetic in your scripts. Also, for more advanced
scripters, you can create your own member functions (including protected
and static ones) to write cleaner script than just having a bunch of
global functions.

Also, the script editor is now much better at checking your script for
errors. You may well find that a script which compiled fine before no
longer works on 2.7. Hopefully the error message should direct you
towards fixing any problems.

**Is there anything else I should watch out for?**

Because of the new additions, the script language has more reserved
words than before. For example, words like "gui", "object" and "hotspot"
are now reserved (since they are used to access the global arrays). If
your script uses any variables with these names, it will no longer work.
You'll need to change the variable name in order to compile.

Also, the script language now supports *pointers*. Because they are a
fairly complex topic, there's a [separate page](ags31.md#Pointers)
devoted to explaining what they are.

**Blimey, that's a lot to take in. Where do I start?**

I'd recommend attempting to write your next section of script in the new
way. Each time you're about to use an old-style command, simply look it
up in the manual to find out what it's replacement is.

Once you get used to the new system, I'm sure you'll agree that it is a
significant improvement over the old scripting system and you'll start
to enjoy the benefits of faster and more intuitive coding.

As always, if there's something you really can't get your head round,
post on the AGS Forums and we'll help you out as best we can!

Have fun,\
CJ
