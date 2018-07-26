**Getting Started with AGS**
----------------------------

So, you've downloaded AGS. You want to make an adventure game. But where
do you start?

(**NOTE**: before we start, this tutorial was made using v3.0 of AGS.
If you have a newer version, there may be minor inconsistencies in the
screenshots where extra options have been added and so forth, but most
of what's here should still apply).

### Creating the game

Start up the AGS Editor by double-clicking the *AGSEditor.exe* file, and
you should be greeted by the following screen:

![](images/intro1.jpg)<br>
*The "Welcome to AGS" dialog*

Make sure that "Start a new game" is selected, and click Continue.
You'll be presented with the Create New Game wizard:

![](images/intro1a.jpg)<br>
*Create New Game dialog*

So, without further ado, click Next, and you'll see the Select Template
screen:

![](images/intro1b.jpg)<br>
*Select Template dialog*

Here, you need to choose which template you're going to use for your new
game. AGS comes with three, and you can find others for download on the
AGS Forums.

The "Default Game" template is what we'll be using, as it comes with
some default graphics to get you started quickly. The "Empty Game"
template is something you may want to use later on when you're familiar
with AGS - it comes with no default graphics at all.

So, select "Default Game" and click Next.

![](images/intro1c.jpg)<br>
*Game Name dialog*

Finally, you need to decide on what to call your game. In the first box
you can type the full name for your game. This is what will be displayed
in the game title bar when it's running in a window, and it's used for a
couple of other things too. For the purposes of this tutorial, I'm going
to call it the incredibly lame "Roger's Adventure", but you can use
whatever you like.

The second box asks you for the game *file name.* This is only used for
the name of the folder that your game is created in, and the name of the
final EXE file you compile.

The third box allows you to choose where AGS should put the game files
-- the default is your My Documents folder, and I'm going to stick with
that.

Click the *Finish* button, and after a short wait you should be
presented with the main AGS Editor window:

![](images/intro2.jpg)<br>
*The main editor window*

So, there's your new game, ready and waiting for you to create it!

### Starting off

The main way that you navigate around the editor is using the **project
tree** in the top-right corner, which allows you to access all the
various parts of your game. Let's start by scrolling to the top of the
tree, and double-clicking the "General Settings" node:

![](images/intro3.jpg)<br>
*The General Settings pane*

This screenshot demonstrates three of the main editor features. The
**project tree**, as we've already discussed, gives you access to the
various parts of your game. The **property grid**, in the bottom-right,
is where item-specific properties are accessed. It's not used in the
Game Settings window, but we'll see it in action soon!

Finally, the AGS editor allows you to have several windows open at once,
and they are "tabbed" across the **open windows** bar at the top so that
you can easily switch between them. Use the Close button to close a
window once you're finished with it.

Now, since we're on the Settings pane, let's briefly examine the various
options we have in front of us. Make sure these options are enabled to
begin with:

-   **Enable Debug Mode** - Since we are going to be developing the
    game, we want the assistance of the debug features in the engine.
    This allows you to do things like teleport to different rooms, give
    yourself all the inventory items, and so forth. You would un-check
    this before compiling the final version of the game when
    it's complete.
-   **Enable 'anti-glide' mode** - without it, the character movement
    can look somewhat silly.
-   **Pixel-perfect click detection** - improves the game playability by
    making sure that clicking transparent regions of objects won't
    trigger them.
-   **Characters turn before walking** - if the character is facing
    right, and you click to move him left, he'll rotate round before
    starting to move. This is what the Sierra and Lucasarts
    point-and-click games did, and looks a bit more professional.

Personally, I would always enable these four options when starting a new
game. As you get a feel for AGS, you can decide what suits you best, and
change these options again later.

### Colour choices

Now, at this stage we really need to decide whether we want to create a
palette-based (8-bit, 256-colour) game, or a hi-color (16- or 32-bit)
game. It's highly recommended that you go with 16-bit colour, or 32-bit
if you want to use alpha transparency.

256-colour games are much more complicated to make due to having to deal
with the palette, they are not supported by the Direct3D driver, and may
not run well on some modern graphics cards. Although they can give you
the authentic retro feel, unless you really need to use palette-cycling
effects, it's recommended that you stay away from making new 256-colour
games.

Still, I'll cover both methods briefly below; if you're not really sure
which to choose, go for Hi-color (16-bit) since it provides a good
balance of performance and ease-of-use. If you want to be able to use
alpha-channel image transparency, use 32-bit colour.

*(NOTE: We need to decide now because when you import graphics, they
will be set to the game's colour depth. Should you change your mind
later, you would have to re-import all the graphics).*

### Creating a 256-colour game

Double-click the "Colours" node in the project tree. You should see
this:

![](images/intro4.jpg)<br>
*The Palette Editor*

The palette display has a grid with the 256 colour slots on it. The
first 40 colours are **game-wide** colours, which means that those
palette slots have a fixed colour throughout the game, in every single
room.

The remaining slots, marked "X", are **background** colours and vary
from room to room. This allows for different types of background to use
different ranges of colours.

The default palette setup is a little badly weighted. Your GUI and main
character graphics will have to use just the game-wide colours, since
they are shown in more than one room. Therefore, unless you want a
greyscale main character, the colours displayed are probably not enough.

So, let's swap some background colours for some game-wide ones. Select
the first "X" slot, then hold shift and click on the last slot in the
row marked "80". The screen should look as follows:

![](images/intro5.jpg)<br>
*We have selected colours 42-95*

We can now see the Property Grid in action. Change the "ColourType"
setting from "Background" to "Gamewide", and you'll see the selected
"X"s turn into various colours.

If you select one of these colours you'll see its RGB colour values in
the property grid, where you can adjust the colour of that slot. If you
don't want to do this manually for every colour, you can set up slots
42-95 in another paint package, save a BMP file, and then right-click on
the selected slots and choose the "Replace selected slots from file"
option.

What colours you use is up to you, and depends on what sort of colour
scheme you're going for with your graphics.

![](images/icon_info.gif)<br>
You should set up the palette as well as you can now, because changing it later may require you to re-import some graphics.

### Creating a 16-bit or 32-bit colour game

Back on the Game Settings pane, check out the very top option in the
list. It's called "Colour depth", and all you have to do is change it to
your desired colour depth. A warning message will prompt you to make
sure. Confirm it, and you're done.

### Game Resolution

Having decided on our colour depth, the other important decision to make
at this stage is what resolution we want the game to run at. Higher
resolutions allow you to have more detailed graphics, but they need more
memory and run slower than lower resolutions.

Go back to the General Settings pane, and select your chosen resolution
from the "Resolution" drop-down list.

Go to part 2: [Creating your first room](acintro2)
