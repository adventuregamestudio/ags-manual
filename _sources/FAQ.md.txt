## Frequently Asked Questions

This section of the manual is very rarely updated. Please consult the
AGS Forums on the website -- in particular, the Beginners Technical
Forum has an excellent Beginners FAQ (the "BFAQ") which is much more
extensive and is updated regularly with all sorts of Q&A's.

**Q. What's the deal with the license?**

A. The software is provided under [Artistic License 2.0](https://opensource.org/licenses/artistic-license-2.0.php).

**Q. On my screen, I can't move the main character. Wherever I click to
move him, he just stands there.**

A. If the main character isn't on a walkable area, he will not be able
to move. Load the room in the editor, and check that the location where
the character starts is on a walkable area.

**Q. When I enter a certain room, I just get a black screen.**

A. Make sure that you haven't used a Display Message command in the
"Enters room before fade-in" event for that room. Remember that this
event happens BEFORE the screen fades in.

To make sure, when you get the black screen, try pressing enter, or
clicking the left mouse button. If nothing happens then something more
serious may have happened. If this is the case, press Alt+X, which
should exit the program and allow you to trace which line of script it
has stopped on.

**Q. The character isn't drawn behind my walk-behind areas!**

A. You need to define the base line for the area, or he will always be
drawn in front. See the tutorial for more information.

**Q. My game EXE file seems to have disappeared.**

A. Because this file is your entire game, including the room files, when
you save a room in the Room Editor it will delete the exe file (because
the room contained in the exe is out of date). To get it back, simply
build the game again by using the "Build EXE" command on the Build menu.

