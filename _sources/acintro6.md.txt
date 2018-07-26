**Getting Started with AGS - Part 6**
-------------------------------------

### Using your own graphics

When you were choosing the graphics for the object earlier in this
tutorial, you probably noticed that the images available didn't look up
to much. This is no problem, because you can import your own graphics
using the Sprite Manager.

Double-click *"Sprites"* near the top of the project tree. This opens up
the Sprite Manager, where you can see the complete sprite set for the
game.

AGS uses these sprites for all game graphics, except room backgrounds.
The Sprite Manager is the central place where you do all your graphics
importing. Whenever you want to use images in the game (for mouse
cursors, views, objects, etc), you select an image to use from here.

There are two ways to import your graphics - either overwrite an
existing sprite with your graphic, or create a new slot for it. To
overwrite an existing sprite, right-click the sprite and select
*"Replace sprite from file"*. To import a new slot, right-click on the
background of the window and choose *"Import new sprite from file"*. If
your game is hi-colour, you'll also have options to paste from the
clipboard.

Note that the sprite graphics you import must be the same colour depth
as your backgrounds - ie. if you have a 256-colour game, you must import
256-colour sprites.

![](images/intro6_1.jpg)<br>
*Right-clicking to replace existing sprite*

So, let's replace the default key image with something of our own.
Right-click on it and choose "*Replace sprite from file*". Select the
file that you want in the dialog, and then you'll be presented with
this:

![](images/intro6_2.jpg)<br>
*The "Import Sprite" window*

This is the Import Sprite window. You'll see the image from the file
that you chose, along with various options. The Zoom slider on the left
allows you to zoom in on the image (very useful for 320x200-resolution
graphics), and the "Transparent colour" option allows you to choose how
AGS decides which colour is the image's transparent colour.

Now, you have two choices. If you want to import the whole image, just
click the "Import Whole Image" button, and you're done. If on the other
hand you only want to import a portion of the image, then you need to
right-drag the mouse within the image to select the area that you want
to import. Once you've got it right, left-click to confirm and the
selected area of the image will be imported.

**NOTE:** For character graphics, make sure you import graphics that are
a suitable size for the game backgrounds. For example, don't import a
320x200-sized image for your character, since it will take up the whole
screen. A good size would be about 20x50 pixels. This will look really
small in the Import window, but your game runs at a much lower
resolution so it'll look much larger.

![](images/icon_info.gif)<br>
NOTE (256-colour only): You may well find that the colours on your graphic look slightly strange once you've imported the image. This is because by default only the first 41 of the palette colours are allocated to sprites, so your graphic will be remapped to this much smaller palette. If you find that many of your imported sprites look strange, you can increase the number of colours assigned to sprites, at the expense of background colours (see the earlier part of the tutorial for palette setup).

#### Tiled sprite import

This feature allows you to import a grid of sprites into separate slots
- for example, if you have several frames of a character animation side
by side in the source bitmap. To do this, simply check the "Tiled sprite
import" box, and align your rectangle on the top left sprite. When you
click the left mouse button, you will get an extra step which allows you
to size the grid:

Click the left button again once you are happy with the grid. Each of
the cells will be imported as a separate sprite.

![](images/icon_info.gif)<br>
NOTE: Tiled sprite import only works if you selected "Import new sprite from file". If you used the "Replace sprite" option, only the first tile will be imported.

Go to part 7: [Animations](acintro7)
