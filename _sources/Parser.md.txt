## Parser functions

### FindWordID

    static int Parser.FindWordID(string wordToFind)

Looks up *wordToFind* in the text parser dictionary, and returns the ID
number.

If the word is not found, returns -1.<br>
Otherwise, the Word Group number is returned, as seen in the Text Parser
tab in the editor.

You can determine if two words are synonyms by looking them both up and
seeing if the returned IDs are the same.

Ignore words are returned as ID 0.

This function is useful if you want to use the AGS Text Parser
dictionary, but implement some custom parsing functionality instead of
using the standard ParseText function.

Example:

     if (Parser.FindWordID("machine") > 0)
     {
       Display("machine is in the game dictionary");
     }

will display a message if the game dictionary includes "machine"

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:* [Parser.ParseText](Parser#parsetext)

---

### ParseText

    static Parser.ParseText(string text)

Stores the supplied user text string for later use by Said. You need to
call this command first with the user's input before using the Said
command. You would usually call this inside the text box's OnActivate
event handler.

Example:

     String command = txtParser.Text;
     Parser.ParseText(command);

will get the players input and store it in string "command" for use with
the said command.

*See Also:* [Parser.FindWordID](Parser#findwordid),
[Parser.Said](Parser#said)

---

### Said

    static bool Parser.Said(string text)

Checks whether the player typed in TEXT in their input passed to
ParseText. Returns *true* if it matches, *false* otherwise.

See [the text parser documentation](TextParser) for a more
detailed description.

Example:

    String input = txtParserInput.Text;
    Parser.ParseText(input);
    if (Parser.Said("load")) {
      txtParserInput.Text = "";
      RestoreGameDialog();
    }

will bring up the restore game dialogue if the player types "load" in
the text parser.

*See Also:* [Parser.ParseText](Parser#parsetext),
[Parser.SaidUnknownWord](Parser#saidunknownword)

---

### SaidUnknownWord

    static String Parser.SaidUnknownWord()

If a word not in the game dictionary was submitted to the last ParseText
call, then the word is returned by this command. This allows you to
display a message like "Sorry, this game doesn't recognise 'XXXX'."

If all the words were recognised, this returns null.

Example:

    String badWord = Parser.SaidUnknownWord();
    if (badWord != null)
       Display("You can't use '%s' in this game.", badWord);

will display the message if the player types a word that's not in the
vocabulary.

*See Also:* [Parser.ParseText](Parser#parsetext),
[Parser.Said](Parser#said)
