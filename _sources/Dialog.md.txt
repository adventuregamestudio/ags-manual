## Dialog functions and properties

### DisplayOptions

    int Dialog.DisplayOptions(optional DialogOptionSayStyle)

Presents the options for this dialog to the user and waits until they
select one of them. The selected option number is returned.

**NOTE:** This command does not run any dialog scripts, it simply
displays the options and waits for the player to choose one. To run the
dialog normally, use the [Dialog.Start](Dialog#start) command
instead.

This command is useful if you want to implement your own dialog system,
but still use the standard AGS dialog option selection screens.

The optional *DialogOptionSayStyle* parameter determines whether the
chosen option is automatically spoken by the player character. The
default is *eSayUseOptionSetting*, which will use the option's "Say"
setting from the dialog editor. You can alternatively use *eSayAlways*,
which will speak the chosen option regardless of its setting in the
editor; or *eSayNever*, which will not speak the chosen option.

If the text parser is enabled for this dialog and the player types
something into it rather than selecting an option, the special value
`DIALOG_PARSER_SELECTED` will be returned, and AGS will have
automatically called [Parser.ParseText](Parser#parsetext) with
the player's text. Therefore, you can call
[Parser.Said](Parser#said) to process it.

Example:

    int result = dOldMan.DisplayOptions();
    if (result == DIALOG_PARSER_SELECTED)
    {
      Display("They typed something into the parser!!");
    }
    else
    {
      Display("They chose dialog option %d.", result);
    }

will show the options for dialog *dOldMan* and display a message
depending on what the player selected.

*Compatibility:* Supported by **AGS 3.0.2** and later versions.

*See Also:* [Dialog.Start](Dialog#start),
[Parser.ParseText](Parser#parsetext)

---

### GetOptionState

*(Formerly known as global function GetDialogOption, which is now
obsolete)*

    Dialog.GetOptionState(int option)

Finds out whether an option in a conversation is available to the player
or not.

OPTION is the option number within the dialog, from 1 to whatever the
highest option is for that topic.

The return value can have the following values:

    eOptionOff
      The option is disabled - the player will not see it
    eOptionOn
      The option is enabled - the player can now see and use it
    eOptionOffForever
      The option is permanently disabled - no other command can ever turn
      it back on again.

These are the same as the options passed to Dialog.SetOptionState.

Example:

    if (dJoeExcited.GetOptionState(2) != eOptionOn)
      Display("It's turned off");

Will display a message if option 2 of dialog dJoeExcited is not
currently switched on.

*See Also:*
[Dialog.HasOptionBeenChosen](Dialog#hasoptionbeenchosen),
[Dialog.SetHasOptionBeenChosen](Dialog#sethasoptionbeenchosen),
[Dialog.SetOptionState](Dialog#setoptionstate)

---

### GetOptionText

    String Dialog.GetOptionText(int option)

Returns the text for the specified dialog option.

OPTION is the option number within the dialog, from 1 to whatever the
highest option is for that topic.

Example:

    String optionText = dJoeBloggs.GetOptionText(3);
    Display("Option 3 of dialog dJoeBloggs is %s!", optionText);

will display the text for the third option of the dJoeBloggs dialog.

*Compatibility:* Supported by **AGS 3.0.2** and later versions.

*See Also:* [Dialog.OptionCount](Dialog#optioncount),
[Dialog.GetOptionState](Dialog#getoptionstate)

---

### HasOptionBeenChosen

    bool Dialog.HasOptionBeenChosen(int option)

Finds out whether the player has already chosen the specified option in
this dialog. This is mainly useful when drawing your own custom dialog
options display, since it allows you to differentiate options that have
already been chosen.

OPTION is the option number within the dialog, from 1 to whatever the
highest option is for that topic.

Example:

    if (dJoeExcited.HasOptionBeenChosen(2))
      Display("The player has chosen option 2 in dialog dJoeExcited!");

will display a message if the player has used option 2 of the dialog
before.

*Compatibility:* Supported by **AGS 3.1.1** and later versions.

*See Also:* [Dialog.GetOptionState](Dialog#getoptionstate),
[Dialog.SetHasOptionBeenChosen](Dialog#sethasoptionbeenchosen),

---

### ID

    readonly int Dialog.ID;

Gets the dialog ID number from the editor.

This might be useful if you need to interoperate with legacy scripts
that work with dialog ID numbers.

Example:

    Display("dFisherman is Dialog %d!", dFisherman.ID);

will display the ID number of the dFisherman dialog

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

---

### OptionCount

    readonly int Dialog.OptionCount;

Gets the number of options that this dialog has.

This might be useful in a script module if you want to iterate through
all the possible choices in the dialog.

Example:

    Display("dFisherman has %d options!", dFisherman.OptionCount);

will display the number of options in the dFisherman dialog.

*Compatibility:* Supported by **AGS 3.0.2** and later versions.

*See Also:* [Dialog.GetOptionText](Dialog#getoptiontext),
[Dialog.GetOptionState](Dialog#getoptionstate)

---

### SetHasOptionBeenChosen

    Dialog.SetHasOptionBeenChosen(int option, bool chosen)

Changes whether an option in a conversation is marked as previously
chosen by the player. The option is marked as chosen whenever player
selects it during the conversation, and is usually highlighted with
different text colour. This function lets you to reset the option state,
or force it change at any random moment.

OPTION is the option number within the dialog, from 1 to whatever the
highest option is for that topic.

Example:

    if (dDialog1.HasOptionBeenChosen(1))
        dDialog1.SetHasOptionBeenChosen(1, false); // reset the option state

will mark option 1 of dialog dDialog1 as "not chosen yet".

*Compatibility:* Supported by **AGS 3.3.0** and later versions.

*See Also:* [Dialog.GetOptionState](Dialog#getoptionstate),
[Dialog.HasOptionBeenChosen](Dialog#hasoptionbeenchosen)

---

### SetOptionState

*(Formerly known as global function SetDialogOption, which is now
obsolete)*

    Dialog.SetOptionState(int option, DialogOptionState)

Changes whether an option in a conversation is available to the player
or not. This allows you to add extra options to a conversation once the
player has done certain things.

OPTION is the option number within the topic, from 1 to whatever the
highest option is for that topic.

The DialogOptionState controls what happens to this option. It can have
the following values:

    eOptionOff
      The option is disabled - the player will not see it
    eOptionOn
      The option is enabled - the player can now see and use it
    eOptionOffForever
      The option is permanently disabled - no other command can ever turn
      it back on again.

These are equivalent to the option-off, option-on, and
option-off-forever dialog commands.

Example:

    if (GetGlobalInt(10)==1)
        dialog[4].SetOptionState(2, eOptionOn);

will enable option 2 of topic number 4 if the Global Integer 10 is 1.

*See Also:* [Dialog.GetOptionState](Dialog#getoptionstate),
[Dialog.Start](Dialog#start),
[StopDialog](Dialog#stopdialog)

---

### ShowTextParser

    readonly bool Dialog.ShowTextParser;

Gets whether this dialog shows a text box allowing the player to type in
text.

This property is initially set in the Dialog Editor.

Example:

    if (dFisherman.ShowTextParser)
    {
      Display("dFisherman has a text box!");
    }

will display a message if dFisherman has the option enabled

*Compatibility:* Supported by **AGS 3.2.1** and later versions.

---

### Start

*(Formerly known as global function RunDialog, which is now obsolete)*

    Dialog.Start()

Starts a conversation from the specified topic.

NOTE: The conversation will not start immediately; instead, it will be
run when the current script function finishes executing.

If you use this command from within the dialog_request function, it
will specify that the game should return to this new topic when the
script finishes.

Example:

    dMerchant.Start();

will start the conversation topic named dMerchant.

*See Also:* [Dialog.DisplayOptions](Dialog#displayoptions),
[Dialog.SetOptionState](Dialog#setoptionstate)

---

### StopDialog

    StopDialog ()

This command can only be used from within the dialog_request function.
It tells AGS that when dialog_request finishes, the whole conversation
should stop rather than continuing with the dialog script.

You can use this function to end the conversation depending on whether
the player has/does a certain thing.

Example:

     function dialog_request (int dr) {
     if (dr==1) {
       cEgo.AddInventory(iPoster);
       StopDialog();
     }

will give the player the inventory item 3 and then end the conversation.

*See Also:* [Dialog.SetOptionState](Dialog#setoptionstate)

