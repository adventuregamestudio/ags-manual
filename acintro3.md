**Getting Started with AGS - Part 3** {#getting-started-with-ags---part-3 align="center"}
-------------------------------------

 

### Adding some interaction

Ok, so we now have a working room. The player can walk around it as much
as they like. However, our game so far is pretty boring - the player
can't actually do anything of value yet!

AGS provides you with three types of things that the player can interact
with - *hotspots*, *objects* and *characters*:

-   A **hotspot** is an area of the background image that the player can
    look at and interact with. Hotspots are generally used for parts of
    the screen such as a tree or the grass which won't change as the
    game progresses.
-   An **object** is an item in the room that can move around the
    screen, and be switched on and off at will. Objects must stay within
    the room that they are created in.
-   A **character** is like an object, except that it can move between
    rooms and therefore appear all over the game. Characters also have
    special properties such as talking animations and so forth, which
    means you will usually use one to represent each NPC
    (non-player character) in the game.

#### Hotspots

The easiest thing to start off with is hotspots. Make sure you've got
the room editor open, and select "Hotspots" from the drop-down list box
(the same place where we selected "Walkable areas" earlier).

Hotspots are drawn in exactly the same way as walk-behind and walkable
areas. You'll probably want to use several different Hotspots for
different areas of the screen. After drawing your first hotspot, change
the Selected Hotspot using the drop-down list above the property grid,
and you can draw in a different colour. All the other hotspots will be
greyed out.

![](images/intro3_1.jpg){width="573" height="400"}\
*I've drawn four types of hotspot onto my screen*

Once you've drawn a hotspot, there are two other fields to set:

-   *The hotspot's description*. This sets a player-friendly name for
    the hotspot, which is vital if you are going to use a
    Lucasarts-style interface where the player can move the mouse over
    the screen to see what's where. If you're using a Sierra-style
    interface then this name will never be displayed to the player, but
    it's useful to fill it in anyway for your own benefit. By default
    this is "Hotspot 1", "Hotspot 2", etc.

-   *The hotspot's Name:* This is a name by which the hotspot can be
    referred to in the room script. This name cannot have any spaces or
    special characters -- just the letters *a* to *z*. The convention in
    AGS is to start the script names for hotspots with an *h*, for
    example *hDoor*. The name must be unique within the room.

  --------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ![](images/icon_info.gif){width="32" height="32"}   In the Areas editor, all the hotspots except the currently selected one are drawn in grey. This is to emphasise which hotspot you have selected to edit. You can change this behaviour by toggling the "show non-selected masks greyed out" button at the right hand end of the toolbar.
  --------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Interactions

Right, now it's time to make something happen! Make sure the first
hotspot is selected, and click the Events button:

![](images/intro3_2.jpg){width="348" height="365"}\
*The events list*

You'll see that the property grid changes to list all the events for
this hotspot. Events occur when the player does certain things in the
game. At the moment, nothing is set to happen in response to any of the
events, so whatever the player does to the hotspot, they will get no
reply.

Right, let's start with something simple. When the player looks at my
hotspot, I want to display a message telling them what they can see.
Click on the "Look at hotspot" row, and a "..." button will appear.

![](images/intro3_3.jpg){width="256" height="142"}\
*The "..." button*

Click the "..." button. This will create an entry in the script for this
event, and you'll find yourself taken to the script editor. If instead
you get a message telling you that the hotspot needs a name, read back
up for how to set a name for the hotspot, earlier in this article.

So, you're now in the script editor. It all looks a bit bare and
intimidating, but you should have something like this:

![](images/intro3_4.jpg){width="544" height="394"}\
*Script editor after adding a hotspot event*

The "*function hDoor\_Look*" line defines that the script underneath
will be run when this event occurs. In AGS, the curly brackets { and }
are used to mark the start and end of a block of script. Anything that
you type in between them will be run as part of this event.

There's a seperate tutorial giving you an introduction to the scripting
language, so I won't attempt to explain it here. But we can start with
something very simple, using the *Display* command, which displays a
message to the player. Type in something like this:

![](images/intro3_5.jpg){width="408" height="136"}\
*A simple script*

#### <span style="font-weight: 400">Once you're done, click on the "Room 1" tab to return to the main room editor.</span> {#once-youre-done-click-on-the-room-1-tab-to-return-to-the-main-room-editor. dir="ltr"}

#### Walk-to points

Ok, since we're back editing hotspots, let me quickly explain the
"Walk-to point" option in the property grid. This allows you to set a
position for each hotspot that the character will walk to whenever the
player interacts with the hotspot - just like the way the Lucasarts
games like Monkey Island worked.

If you set a walk-to point, then whenever the player clicks interact or
talk on the hotspot, the main character will first walk to the walk-to
point before the relevant event is triggered. If you want, the character
can also walk there when the LOOK mode is used - this option is
configurable in the game General Settings pane.

To remove a walk-to point, simply set it to 0,0.

#### Edges revisited

Ok, so we've covered the basics of creating a room. However, there's one
thing that we did a while back that we need to clear up - yes, the
edges.

Select "Edges" again in the list box. Now, click the Events button in
the property grid and this time we'll see the events for the room
itself. Among the events listed, you'll see "Walks off left edge",
"Walks off right edge", and so on. These are fired when the player
character crosses the edges that we defined back in part 2. Normally,
you'll use the *player.ChangeRoom* script command for these events, to
take the player to a different room.

Now, hit F5 to try out our latest additions! Make sure that when you
look at hotspot 1 the game displays the message that you typed into the
script.

**Scripting tutorial**

Now might be a good time to check out the scripting tutorial to get a
better understanding of what your script code is doing. Alternatively,
finish off this tutorial first and then check out the scripting
tutorial.

 

**Go to part 4:** [Objects and inventory](acintro4.md)

Tutorial created 21 November 2002; updated 12 August 2007. Copyright (c)
2001-2002 Chris Jones.
