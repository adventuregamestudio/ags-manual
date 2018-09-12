## Translations

AGS now makes it easy for you to create translations of your games.
Right-click the "Translations" node in the tree, and choose "New
translation". Once you've named it, AGS will ask if you want to populate
the file now. Say yes.

Creating the translation writes all lines of game text to the file - no
script sources, just all the displayable text from the game. The file is
generated with each line of text separated by a blank line.

You can now give this file to your translators. They should **fill in
each blank line with the corresponding translation of the English line
above it (DO NOT REPLACE THE ORIGINAL ENGLISH LINES WITH THE
TRANSLATION)**. If a line is left blank, it will simply not be
translated.

Once the translation is done, right-click the translation and choose
"Compile". It will be converted into a compiled translation (`.TRA`)
file in the Compiled folder, which can be used with the game engine.

Run the game Setup program, and select the translation from the
drop-down box. Then, run the game, and all the text should be
translated.

*NOTE: With SCI fonts, only 128 characters are available, so many of the
extended characters needed for non-english translations are not
available. You may need to use substitute characters, or consider using
TTF fonts for international applications. However, bear in mind that TTF
rendering slows down the engine.*

While most in-game text is translated automatically, there are a few
instances when this is not possible. These are when a script uses
functions like Append to build up a string, or CompareTo to check some
user input. In these cases, you can use the
[GetTranslation](Game#gettranslation) function to make it work.

You'll also have noticed a "Update" option when right-clicking a
translation. This is useful if you've got a translated version of your
game, but you want to update the game and add a few bits in. Once you've
updated your game, run the Update Translation option and the translation
file you select will get any new bits of text added to it at the bottom
-- then you can just ask your translator to additionally translate these
lines.
