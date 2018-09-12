## Getting Started with AGS - Part 4

### Objects

Objects are items on the screen which, unlike hotspots, can move, change
and disappear. You use objects for things in the room that the player
can take (since they can disappear), and for things which need to
animate.

So, let's revisit the age-old "key" inventory item. Let's say we've got
a locked door, and the player can pick up a key from another room to
open it with. Please don't use this puzzle when you're making a proper
game, it's been done far too many times ;-)

From the same list as we chose "Walkable areas" and "Hotspots" earlier,
let's return there and select "Objects". Now, to add an object to the
room, simply right-click on the background where you want to add it, and
choose "New object here" from the menu which appears.

As if by magic, a blue cup appears! This is the default sprite in AGS,
and will appear anywhere that you haven't selected a proper image yet.
Notice that the property grid has changed to display the details of this
new object -- one of which is a property called Image. Select this
property, and a "..." button appears.

![Adding an object to the room](images/intro4_1.jpg)

Click the "..." button, and you'll be presented with the *Sprite
Manager*. We'll explain this in more detail later, but basically it is
the focal point in AGS where you import and export all your graphics
except for room backgrounds. You should see a small key picture as
sprite number 2. Double-click that for now, we'll import our own
graphics later.

You should now see that the blue cup has changed into a key. You can
move it around by left-clicking and dragging the sprite within the
background image. Place it somewhere sensible on your screen.

The next thing we should do is give the object a name. Similar to what
we did with hotspots, since the object will be referred to in the script
it'll need a name that we can call it by. Scroll down the property grid
and find the "Name" property, and set it to something sensible. The
convention in AGS is to have object names start with an "o", for example
*oKey*.

![I've placed the key cunningly in the middle of the walkway ;-)](images/intro4_2.jpg)

Before we enable the key to be taken by the player, let me quickly go
over a couple of propertes in the property grid:

-   **Baseline** - normally, the baseline for an object is set to the
    bottom of the object graphic (baselines are used to calculate which
    items on the screen are drawn in front and which are drawn at
    the back). However, in some cases you might want to override this.<br>
    What you'll notice with our key is that if the player walks just
    behind it, the key will appear in front of his feet. This is not
    what we want, since the key is supposed to be lying flat on
    the ground. To correct this, change the Baseline property to 5 (this
    means that it will be drawn behind everything that has a baseline
    lower down the screen than Y=5). This will make sure that the player
    is always drawn in front of the key.
-   **Visible** - this toggles whether the object is switched on at the
    beginning of the game or not. For our key we want it to be True, but
    sometimes you'll have objects which you don't want the player to see
    until they've done something else in the game.

![](images/icon_info.gif)

The game speed is directly related to the number and size of objects on-screen.
AGS imposes a limit of 20 objects per room, but even if you use all of these
and have them visible at the same time, the game speed could suffer.

Right, now back to the pressing matter at hand - letting the player pick
up the key.

### Inventory

Now wait, there's one more step we need to do first. At the moment we
could let the player pick up the key, but then what would happen to it?
Where would it go? We need to define the player's *inventory*.

Select the *"Inventory Items"* node in the project tree. You'll see that
there are already two items defined - "Key" and "Pink poster". These are
just defaults to help you get started. Double click "1: iKey", and you
should see a window open with the key image in it. But that picture's a
bit small for an inventory item, I'm sure I saw something better in the
sprite list earlier.

Find the "Image" property in the property grid, select it, and then
click the "..." button. The sprite manager re-appears, so find sprite
number 5, and you should see that it's a much larger picture of a key.
Let's use that as our inventory icon. Double-click the sprite to select
it.

![Yay, we've got a big inventory icon for the key](images/intro4_3.jpg)

Ok, there are a few other settings on this screen, but let's return to
our objective - letting the player pick up the key. Remember that the
script name is *iKey*, as we'll need it later.

#### Back to the events

Go back to the *Objects* pane of the Room Editor, and click on, yes
you've guessed it, the *Events* button. The events here are very similar
to the ones we had for the hotspot:

![The events list for the object](images/intro4_4.jpg)

Notice there are two obvious possibilities here: "Interact object" and
"Pick up object". We actually want to use the "Interact object" event,
because we are using the default Sierra-style interface which doesn't
have a specific Pick Up mode. The "Pick up", "Usermode1" and "Usermode2"
events are useful if you go for a lucasarts-style interface which has
more verb types available to the player.

So, select "Interact object" and click the "..." button. When the player
picks up the key we want two things to happen - firstly, the object
on-screen needs to disappear, and secondly, the inventory item needs to
be added to the player's inventory.

Here's my script solution. As an added bonus, I've also given the player
5 points for their trouble, but you don't need to have that third
command:

![Script for taking the key](images/intro4_5.jpg)

Note that our solution is not perfect - the player can click the hand
icon on the key from anywhere in the room and it will disappear. We are
also not displaying a message informing the player of what happened.
But, the functionality is there, and this will do fine for now.

Okey, so we now have a fully-working first room. Test the game as
before, and try it out. Once the player has taken the key, call up his
inventory and you should see the large key picture there.

### Room Settings

Finally, let's just quickly go over the available properties for the
room itself (available when in Nothing mode):

-   **PlayMusicOnRoomLoad** - you can type a music number in the box and
    that background music will start playing when the player enters
    the room. For more about music and sound, see later in the manual.
-   **SaveLoadEnabled** - if disabled, then if the player tries to save
    or load the game while in this room, a message ("Sorry, not now") is
    displayed instead. .
-   **ShowPlayerCharacter** - if checked, the player character will not
    be visible in this room, and the Walk mode will be disabled. Useful
    for close-up displays of control panels and so forth.
-   **PlayerCharacterView** - you can type a number in here to override
    the player character's graphic for this room. For example, if you
    have an overhead map screen, you will probably want a different
    image of the character from an overhead perspective.
-   **MusicVolumeAdjustment** - this allows you to modify the background
    music volume for this screen.

Go to part 5: [Managing Inventory](acintro5)
