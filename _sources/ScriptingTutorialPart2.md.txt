## Text Scripting Tutorial - Part 2

### Recap

In the first tutorial, we covered the basics of scripting - how to write
a simple script, use variables and conditional statements. You now know
how to call all the built-in functions and write a fairly decent script.
So, what's next?

### Loops

You may find it useful to have a sequence of commands that are executed
more than once. AGS supports this, using the `while` keyword. Its format
is virtually identical to `if`:

    int counter = 1;
    while (counter < 10) {
      counter ++;
    }

This means that the body of the `while` statement is repeatedly
processed, as long as the condition is true. So, in this case, since
counter starts as 1, the loop will be run 9 times, since on the tenth
time counter will be 10 and therefore it will stop.

NOTE: be careful with while loops - it is possible to crash your game by
using a badly written one. Consider this:

    int counter = 1;
    while (counter > 0) {
      counter ++;
    }

Here, *counter* starts off as 1, so the loop will run. Then, it will
increase to 2. Since it is still greater than 0, the loop will run
again. This particular loop will run forever, since *counter* can never
become less than 1, and your game will grind to a halt.

### Multiple conditions

On several occasions, you don't just want to decide what to do based on
one variable - there may be a combination of things you want to
consider.

For example, suppose that you want to display a message if the player
has **two** specific inventory items. You could do this, and put **two**
*if* statements inside each other:

    if (player.HasInventory(iFirstItem))
    {
      if (player.HasInventory(iSecondItem))
      {
        Display ("You have both the items!");
      }
    }

However, this is quite unwieldy and if you have a lot of conditions it
will look rather messy. So, AGS lets you do it this way:

    if ((player.HasInventory(iFirstItem)) &&
        (player.HasInventory(iSecondItem)) )
    {
      Display ("You have both the items!");
    }

This makes use of the `&&` operator. Note that you need an extra pair
of outer parenthesis, to contain the whole expression. Each part of the
expression goes inside parenthesis, as normal, and they are joined with
the `&&` symbol.

You can extend this to as many checks as you like. For example, this
will display the message if the *openedDoor* variable is currently set
to true, and the variable *timer* is between 5 and 10.

    if ((openedDoor == true) && (timer > 5) && (timer < 10))
    {
      Display ("It's all working out fine.");
    }

*'OR' expressions*

Sometimes you will want to do some processing if one **or** another
condition is true. For example, you might want to let the player open a
door if he has either the door key or a chainsaw.

    if ((player.HasInventory(iDoorKey)) ||
        (player.HasInventory(iChainsaw)) )
    {
      player.ChangeRoom(10);
    }

The operator here is the double-vertical-bar `||` operator. It works
similarly to the `&&` operator, but it will process the commands inside it
if either one expression, or the other, or both, are true.

### Doing one thing or another

Sometimes, you want the script to take one course of action if a
variable is set, and another course of action if it isn't. Initially,
you might think you would do this:

    if (timer == 5) {
     // do something
    }
    if (timer != 5) {
     // do something else
    }

That would work -- however, there is a neater way, using the `else`
keyword:

    if (timer == 5) {
     // do something
    }
    else {
     // do something else
    }

This also allows you to modify the variable inside the first block of
code, without affecting whether the second block gets run or not.

You can do as many tests as you like, using the `else if` keyword. So,
a complete piece of code could look like this:

    if (timer == 5) {
     // do something
    }
    else if (timer == 6) {
     // do something different
    }
    else {
     // do this if it's not 5 or 6
    }

### Your Own Functions

You've probably noticed in the manual, it mentioning functions such as
`repeatedly_execute`, and `on_event`, and how you can add them to your
global script to do cool stuff. But you may be wondering, how exactly to
go about it.

Remember in tutorial 1, we learnt about function **parameters** and how
they could be *int*, *string*, etc. Well, you write your own functions
like this:

    function dialog_request(int param)
    {
     // contents of function go here
    }

You start with the keyword `function`, then follow it by the function
name, and then parenthesis listing the parameter types and names. For
each parameter that you want, you need to write its type (*int* or
*string*), followed by the name it will be known by inside the function.
This name can be anything you like - it is similar to naming a variable.

There are some **fixed** functions, such as dialog_request and
on_event, which are part of AGS and therefore you **MUST** use the
correct number and type of parameters.  However, you may also add your
own functions by naming them however you like, and having as many
parameters as you need.

Functions are useful if you have a block of script code that you need to
use in two different places - putting it in a function instead means you
don't have to copy & paste, and that if you modify it, all other script
that relies on it gets updated too.

To call your function from elsewhere in the script, just do it exactly
like you call a built-in function - ie. just write its name, parameters
then a semicolon.

I think a couple of examples are in order. First of all, let's show a
fixed function, on_event:

    function on_event (EventType event, int data)
    {
     if (event == eEventGotScore)
     {
       if (data == 5)
       {
         aSpecialScoreSound.Play();
       }
       Display("You just got %d points!", data);
     }
    }

With this script, whenever the player scores points, they will get a
message telling them so. Also, if they happen to get 5 points at once,
it will play audio clip *aSpecialScoreSound*.

As you can see, you use the function parameters just like any other
script variables.

**Our own function**

Now, suppose we have a special animation of the player doing a dance,
and we want to be able to play it from various points in the script. By
far the easiest way to do this would be to put it in a function:

    function do_dance()
    {
     cEgo.LockView(10);
     cEgo.Animate(2, 5);
     cEgo.UnlockView();
    }

This function runs view 10, loop 2, as the character's animation, waits
until it finishes and then reverts to the default view.

TIP: if you're wondering where to place your custom functions, just
open up the global script (Game menu, Edit Global Script) and write them
in there. The function must be outside all other functions.

Now, elsewhere in your script, when you want the player to dance, just
do:

    do_dance();

**Returning a value**

You may have noticed that some of the built-in functions, such as
IsGamePaused, return a value to the script. You can do this from your
own functions, using the `return` keyword. So:

    function add(int a, int b)
    {
     int result;
     result = a + b;
     return result;
    }

This function adds the two numbers together and returns the result (a
useless function in practice since the + operator does the same thing,
but it demonstrates the point).

Another part of your script could then do:

    total = add(5, 10);

**Using functions from room scripts**

You may notice that when you add your own function to your global
script, you can call it fine from other places in the global script but
attempting to use it in a room script gives a parse error. The manual
explains how to solve this using the script header.

### Conclusions

We've covered some of the more advanced topics of scripting. I'm sure
there's a lot of stuff I've forgotten to mention, so feel free to
comment on it on the forums.
