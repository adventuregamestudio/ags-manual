## System limits

This section tells you the maximums for various parts of the system. If
you have been wondering "How many rooms can I have?" or something
similar, chances are this section will answer it.

There are maximum...

- 40 objects per room
- 299 state-saving rooms per game
- 300 inventory items
- 30000 imported sprites
- 30 options per dialog topic
- 20 screen overlays at a time
- 5 background frames per room
- 20 mouse cursors
- 8 audio channels
- 100 local messages per room (excluding script)
- 30 fonts
- 150 lines of text in a listbox
- unlimited words in the text parser dictionary
- unlimited characters
- unlimited dialog topics
- unlimited views
- unlimited GUIs
- unlimited controls on each GUI
- unlimited loops per view
- unlimited frames per loop
- unlimited custom properties

Some additional limits

- You should be able to have up to 15 parameters to a function. 

- To ensure the pathfinder always works, your walkable areas should always be at least 3 pixels wide.

- You'll get an error if you define over 4 KB's worth of variables inside a function.

- AGS currently allows the call stack to be 50 levels deep, so if you have a recursive function that calls itself more often you'll get the "call stack overflow" error. Additionally, the stack size is set at 4 KB so if the recursive function declares a lot of local variables you could reach the limit that way, too.

- There is a total overall limit on the number of functions that can be exported by all plugins added together, which in theory it would be possible for a single plugin to exceed. It's in the region of a couple of hundred though, so it shouldn't be an issue. It wouldn't be too difficult to increase, if the need arose. 

We are working on removing existing limitations in the AGS, so some of
the remaining restrictions might be loosened or eliminated in the
following updates.
