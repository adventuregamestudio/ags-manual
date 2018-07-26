Pointers in AGS
---------------

Various commands in the new scripting language will require you to use
pointers. This section has been split into three separate topics to
introduce you to pointers depending on your previous programming
experience -- select one of the links below:

[Pointers for programming newbies](#pointers-for-programming-newbies)<br>
[Pointers for people who know Java or C#](#pointers-for-people-who-know-java-or-c)<br>
[Pointers for people who know C or C++](#pointers-for-people-who-know-c-or-c)

---

### Pointers for programming newbies

Pointers can be quite a daunting prospect, and in languages like C and
C++ they certainly are; but AGS tries to make things as simple as
possible.

Basically, a pointer is a variable that *points* to something of a
particular type. For example, a *Character* pointer would point to
characters. What's the point of all this, I hear you ask?

Well, let's look back at AGS 2.62. If you wanted to reference a
particular hotspot, you'd need to remember its number. If you wanted to
switch on an object, you'd need to remember what number it was too. And
because you could accidentally use an object number where you wanted a
hotspot number, mistakes could easily happen and it all got rather
messy.

That's where pointers step in -- basically, they allow you to do away
with identifying things by number, and in the process provide *type
checking*, so you can't accidentally use a hotspot where you meant to
use an object.

Let's look at an example. If you wanted to write a string to a file in
2.62, you'd do this:

    int handle = FileOpen("temp.txt", FILE_WRITE);
    FileWrite(handle, "Test!");
    FileClose(handle);

That's simple enough; but what if you wanted to open the file in one
place, and write to it somewhere else? You'd have to make *handle* a
global variable, and then make sure you remembered that it was a file
handle and not a hotspot number or anything else. Now, with 2.7 the same
code would be:

    File *file = File.Open("temp.txt", eFileWrite);
    file.WriteString("Test!");
    file.Close();

Looks fairly simple, doesn't it. The only slightly confusing part is
getting used to declaring the variable as `File*` rather than `int`; but
that's something you'll get used to quite quickly, and all the examples
in the manual should point you in the right direction.

Let's look at another example. Suppose you want a variable that contains
the current hotspot that the mouse is over. In 2.62, you might have
something like this:

    // top of global script
    int mouseOverHotspot;

    // repeatedly_execute
    mouseOverHotspot = GetHotspotAt(mouse.x, mouse.y);

How would you do this in 2.7? Well, quite simply:

    // top of global script
    Hotspot *mouseOverHotspot;

    // repeatedly_execute
    mouseOverHotspot = Hotspot.GetAtScreenXY(mouse.x, mouse.y);

But hold on, what if you want to know whether the mouse is over your
Door hotspot (say it's hotspot 2). In 2.62, you'd have done:

    if (mouseOverHotspot == 2) {
      Display("Mouse over the door");
    }

but that's rather messy, because what if you change the door's hotspot
number? You'd have to remember to go back and change all the 2's to 3,
or whatever. In 2.7, you now just do this (assuming you gave the hotspot
a script name of hDoor):

    if (mouseOverHotspot == hDoor) {
      Display("Mouse over the door");
    }

If you're a fan of numbers for some strange reason, you can still use
them like this:

    if (mouseOverHotspot == hotspot[2]) {
      Display("Mouse over the door");
    }

So, that concludes our introduction to pointers. Hopefully you've got an
understanding of what they are and what they do; if there's anything you
can't work out, feel free to ask on the Technical forums.

---

### Pointers for people who know Java or C#

AGS pointers work in a very similar way to object variables in Java and
C#. The main difference is that AGS pointers are declared in the
C-style manner with an asterisk t represent the pointer. So:

    Hotspot *hs;

would declare a variable *hs* which points to a Hotspot. This would be
equivalent to the following in Java or C#:

    Hotspot hs;

In AGS, pointers are used to point to various built-in types, such as
Hotspots, Inventory Items, Characters and so on. Because AGS does not
have a *new* keyword, you cannot create pointers to custom struct types.

You use pointers in the same way as you would in Java and C#. Various
built-in AGS static methods return a pointer to an instance (for
example, [File.Open](File#open),
[Hotspot.GetAtScreenXY](Hotspot#getatscreenxy), and so on).
You can save this pointer into a pointer variable, and then call its
methods as you would in Java or C#. The following examples are all
valid:

    File *theFile = File.Open("test.dat", eFileWrite);
    if (theFile == null) Display("It's null!");
    File *file2 = theFile;
    if (theFile == file2) Display("They're the same file!");
    theFile = null;
    file2.WriteInt(10);
    file2.Close();

If you attempt to call a method on a null pointer, an error will occur
(just like you'd get an exception in Java or C#).

Pointer memory management in AGS is all automatic -- the memory is freed
when there are no longer any variables pointing to the instance. Thus,
if you have global pointer variables in your global script, it's a good
idea to set them to *null* when you're no longer using them, to allow
the memory to be freed.

---

### Pointers for people who know C or C++

Pointers in AGS are based on the C/C++ syntax, so they are declared with
an asterisk. However, in AGS you can only create pointers to built-in
AGS types, and not to any custom structs declared in your script.

Pointer members are accessed with the dot operator, and not the `->`
C-style operator. Because AGS doesn't support features such as
pointers-to-pointers and so forth, there is no need for a separate
operator.

In AGS, pointer memory management is done automatically based on
reference counting (similar to the way COM works), so there is no *new*
or *delete* keyword. When an object is no longer referenced by any
pointer variables, it will be freed. For this reason, if you have any
global pointer variables it's advisable to set them to *null* if you are
done with them.

AGS pointers are strongly typed, and you cannot cast between types at
will like you can in C and C++. AGS will only allow you to compare and
assign pointers of the same type, or of the same base type. There is a
special keyword *null* which all pointers can be set to and compared
with, which indicates that they are unassigned.

Because there is no *new* keyword, you cannot create object instances;
rather, they are returned by static member functions in AGS, such as
[File.Open](File#open) and
[Hotspot.GetAtScreenXY](Hotspot#getatscreenxy). See the
examples for the functions to get an idea of how to use them.
