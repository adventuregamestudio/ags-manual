## Getting Started with AGS - Part 8

### Conversations

What fun would an adventure be if there were no other characters to talk
to? Probably not much!

How much you go into dialog depends of course on your game style.
Generally, Sierra games used to just have one fixed line of dialog which
the characters would talk about, possibly changing if you talked to the
same person again.

Lucasarts games (and some Sierra titles such as Quest for Glory) on the
other hand, had complete dialog trees through which you could choose
your topics to talk about.

AGS lets you do it whichever way you want. We'll start off by looking at
the complete dialog tree approach, and then see how easy it is to cut it
down to get a Sierra-style system.

Now, before we go any further, let's consider for a moment what
conversation structure we want. It's going to be a lot easier to
implement if we have this planned in advance. For this tutorial, we'll
go for a structure like this:

![Our planned dialog tree](images/intro8_1.jpg)

In other words, when we first speak to the other character, we will say
"Greetings!". After he replies, we will then be presented with three
options to choose from.

The "Tell me more about your wares" option will then lead us to be able
to ask a different set of questions.

Before we begin, we need to create a second character - we can't just
have Roger talking to himself! Go to the "Characters" node, right-click
it and choose "New Character". Double-click the new "cChar1" entry to
open him up.

In the property grid, give the new character a RealName -- I'll call him
*Merchant*. Now - and this bit is vital - you also need to set this new
character's **script name**. This is the name by which we refer to him
when creating our dialogs. I'll just use "cMerchant" as the script name.
I'd recommend you set it to something sensible like this, and don't just
leave it as "cChar1" or else your dialog scripts will get very
confusing!

Ok, all done? Expand the "Dialogs" node in the editor, and you'll see
one existing "0" entry. We'd may as well use it since it's there, so
double-click it. (If not, you can always right-click the Dialogs node
and choose "New dialog" to make a new one). You'll see this rather empty
window:

![The dialog editor](images/intro8_2.jpg)

Conversations in AGS are made up of **topics**. A topic consists of a
set of options that the player can talk about - not all of which are
necessarily available to the player at the start of the game. When the
player selects an option from a topic, the topic's **dialog script** is
run.

Each topic can contain some start-up text, which is displayed before the
options are presented to the player. Our "Greetings" line qualifies for
this, so we don't need to make a special topic for it. A **topic** is
also referred to as a **dialog** in AGS -- the two words are one and the
same thing.

Right, let's make our first dialog. Click the "Create new option" button
three times, and three new rows will appear in the window. You'll also
notice some new lines being added to the script on the right hand side.
Make sure that the "Show" checkbox is ticked for all the options -- this
determines whether the options are initially available to the player or
not.

Also, this dialog currently has no name, but we'll need to give it one
so that we can access it later. The convention in AGS is for dialogs to
start with "d", so I'm going to call this "dMerchant". Use the property
grid to set the name, as usual.

Now, type in some text to the three new text boxes:

![We've inserted three options for topic 0](images/intro8_3.jpg)

While we're at it, let's create the next set of options too. Right click
the "Dialogs" node in the project tree, and select "New Dialog". A new
blank Dialog 1 is created. Double-click on this, and again, create three
new options and type them in. In the property grid, change the Name from
"dDialog1" to "dWares".

Now, go back to the first dialog (select it in the tab bar), and let's
have a look at the script. This is **not** the same type of script that
we've used for our events like picking up the key. It's a much simpler
dialog-only scripting language.

Each of the "@" lines is an **entry point**. These define the different
places where your script can start. The "@S" entry point happens when
the topic is first started - and so this is where we want our
"Greetings" text to be displayed.

Dialog scripting is very simple. It takes the form:

    SCRIPTNAME: "Text to say"

So, in between the "@S" and the "@1" lines, insert a couple of new
lines, and type the following:

    EGO: "Greetings!"
    MERCHANT: "Hello there!"
    return

Remember, these are the **script names** of the characters (but without
the initial "c"). The "return" is essential, because it tells AGS to
stop running the script at that point and to display the options to the
player.

The numbered entry points will be run when the player selects the
appropriate option - for example, if the player clicks the "Who are
you?" option, then entry point @1 will run.

Here's a finished script for this topic:

![Our finished dialog script](images/intro8_5.jpg)

The *goto-dialog* command takes the player to another dialog - in this
case, the new "dWares" dialog we just created (with questions about the
merchant's wares).

The *stop* command tells AGS to end the conversation and return to the
game (whereas *return* returns them to the list of options to talk
about).

Now, we're not quite done ... we've got to deal with our second dialog
too! In the tab bar, click the "Dialog: dWares" tab to return to the
main topic. Fill in the script however you like. You can use the
*goto-previous* command to take the player back to the first list of
options when they get bored of talking about his wares.

Here's my completed script for dWares:

![Dialog script for dWares](images/intro8_6.jpg)

As you can see, it's done very similarly to the first one. Notice the
use of "return" in the startup entry point, to make sure that it doesn't
go on and run the next bit of script straight away.

We're almost done! All we've got to do now is add a way for the player
to initiate the conversation.

Open up the Character editor for the new *cMerchant* character. Change
his StartingRoom to room 1 (ie. the same as the player character), and
position him at let's say X:260, Y:130. You can always change this
later.

Now, still with the Merchant open, go to his Events list. Using your
skills from earlier on in this tutorial, add a command to initiate the
dialog when the player talks to the Merchant. Now, we're all set!

![Event script to launch the dialog](images/intro8_7.jpg)

Test the game, talk to the Merchant, and try out the conversation.

**More on conversations**

You may have noticed the "Show" and "Say" check-boxes in the dialog
editors. You'll have noticed that when the player selects an option, the
player character will say the option text. However, there are times when
you won't want this to happen, and if you un-tick the "Say" box for an
option, the character won't repeat the text when the player selects it.

The "Show" box determines whether the option is initially available to
the player. If you uncheck it, then that option won't appear to start
with. You can enable it later using the *option-on* dialog script
command, or the *dDialogName.SetOptionState* script command.

There is also a dialog script command called *option-off*, which you can
use to stop a particular option from appearing once the character has
found out all the vital information. See the manual reference for more.

If there is only one option enabled for a topic, then the game selects
it automatically. You can use this to make Sierra-style conversations,
because the options will never be shown to the player in this case.

Go to part 9: [Cursors and fonts](acintro9)
