## The text parser

You can now use a text parser in your games if you wish to, much as the
older Sierra games did. Go to the "Text parser" pane in the editor.
There, you will see a short list of words which are provided for you.
Each word has a number beside it.

Basically, you add words you want to use by right-clicking the list, and
selecting "Add word". However, the real beauty of the parser is its
ability to recognise synonyms - that is, two words that mean the same
thing. So, for example, if you wanted the player to type "look at
fence", they might well type "look at wall" instead, if that's how they
see the drawing. Or, a British person might type "colour" whereas an
American might type "color", both of which should have the same effect.

To add a synonym for an existing word, highlight the current word,
right-click it and choose "Add synonym". You'll notice that the new word
is given the same number as the old one. All words with the same number
are considered identical by the parser.

You will notice that the provided list has a lot of words with number 0.
This is a special number, that indicates that the parser should ignore
the word completely. In our previous example, the player might type
"look at the fence", "look at fence", or just "look fence". By adding
words like "at" and "the" to the ignore list, they get stripped out of
the user's input automatically. To add new ignore words, just select an
existing one and add a synonym.

So, how do you use the text parser? Well, you'll need a text box GUI
control somewhere in order for the user to type in their input, or you
could just use the InputBox command (but it has quite a short line
length).

When the user has typed in their text (you'll probably know this by the
text box's event being activated), you call the Parser.ParseText script
function which tells AGS what input string to use in subsequent
commands. You then simply use the Said command to test what the player
typed in.

You type the whole sentence (but NOT including any ignore words), and
AGS will compare it to the user's string, considering all synonyms
identical. For example (assuming our text box is called "txtUserInput"):

      String input = txtUserInput.Text;
      Parser.ParseText(input);
      if (Parser.Said("look fence")) {
        Display("It's an old wooden fence.");
      }
      if (Parser.Said("eat apple")) {
        Display("You'd love to, but you don't have one.");
      }

There are a couple of special words you can use with the Said command.
"anyword" will match any word that the user types in. For example,
Said("throw anyword away") will match if they type "throw dagger away",
or "throw trash away". "rol" (short for Rest-of-Line) will match the
rest of the user's input. So, you might want to do:

    if (Parser.Said("kill rol")) {
      Display("You're not a violent person.");
    }

This way if they try to kill anything they will get the generic
response.

Sometimes, you want to accept two different words that are not synonyms
as the same thing. For example, the words "take" and "eat" normally have
totally different meanings, so you wouldn't make them synonyms of each
other. However, if the player has a headache tablet, for instance, then
"take tablet" and "eat tablet" would both be valid. This is where the
comma "," comes in - if you include a comma in your input, all synonyms
of all words separated by the comma will match. So:

    if (Parser.Said("eat,take tablet"))

will match eat or take and all their synonyms, then tablet and its
synonyms.

Another fairly common task with a parser is to check for optional words
- for example, if there is a brick wall on the screen, you want the
player to be able to type "look wall" and "look brick wall". Although
this can be done with two OR'ed Said commands, AGS makes it easier. You
can use \[brackets\] to signify an optional word. So:

    if (Parser.Said("look [brick] wall"))

will match "look wall" and "look brick wall".

Now this is all very well, but in different rooms you have different
items to interact with - for example, in one room there might be a tree
that the player should be able to type "look at tree" to look at, and so
on. Putting all this in your global script would make a big mess. So,
enter the [CallRoomScript](Game#callroomscript) function. Using
this, you can do:

      Parser.ParseText(input);
      String badWord = Parser.SaidUnknownWord();
      if (badWord != null)
        Display("You can't use '%s' in this game.", badWord);
      else if (Parser.Said("eat apple")) {
        Display("You'd love to, but you don't have one.");
      }
      ... // other game-wide commands
      else
        CallRoomScript (1);

Then, the room script can check for things that the player can do in the
current room. See the [CallRoomScript](Game#callroomscript)
description for more information.
