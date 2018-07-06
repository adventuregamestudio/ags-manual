[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags61.md#topic57)
[![Next](forward.gif)](ags63.md#topic59)

------------------------------------------------------------------------

GUI Text Box functions and properties
-------------------------------------

[BringToFront (inherited)](ags56.md#GUIControl.BringToFront)\
[Clickable property (inherited)](ags56.md#GUIControl.Clickable)\
[Enabled property (inherited)](ags56.md#GUIControl.Enabled)\
[Height property (inherited)](ags56.md#GUIControl.Height)\
[ID property (inherited)](ags56.md#GUIControl.ID)\
[OwningGUI property (inherited)](ags56.md#GUIControl.OwningGUI)\
[SendToBack (inherited)](ags56.md#GUIControl.SendToBack)\
[SetPosition (inherited)](ags56.md#GUIControl.SetPosition)\
[SetSize (inherited)](ags56.md#GUIControl.SetSize)\
[Visible property (inherited)](ags56.md#GUIControl.Visible)\
[Width property (inherited)](ags56.md#GUIControl.Width)\
[X property (inherited)](ags56.md#GUIControl.X)\
[Y property (inherited)](ags56.md#GUIControl.Y)\
[ZOrder property (inherited)](ags56.md#GUIControl.ZOrder)

[Font property (text box)](#TextBox.Font)\
[Text property (text box)](#TextBox.Text)\
[TextColor property (text box)](#TextBox.TextColor)\

------------------------------------------------------------------------

[]()

### Font property (text box)

*(Formerly known as SetTextBoxFont, which is now obsolete)*

    FontType TextBox.Font

Gets/sets the font used by the specified text box. This might be useful
if you need a player input text box to use a different font with foreign
language translations, for example.

Example:

    txtUserInput.Font = eFontNormal;

will change the *txtUserInput* text box to use Font "Normal".

*See Also:* [Label.Font](ags59.md#Label.Font),
[TextBox.Text](ags62.md#TextBox.Text)

------------------------------------------------------------------------

[]()

### Text property (text box)

*(Formerly known as GetTextBoxText, which is now obsolete)*\
*(Formerly known as SetTextBoxText, which is now obsolete)*\
*(Formerly known as TextBox.GetText, which is now obsolete)*\
*(Formerly known as TextBox.SetText, which is now obsolete)*

    String TextBox.Text;

Gets/sets the text box contents. This might be useful to reset the text
box to blank after the user has typed something in, or to fill in a
default value.

Example:

    txtUserInput.Text = "";

will clear the txtUserInput text box.

*See Also:* [TextBox.Font](ags62.md#TextBox.Font),
[String.CompareTo](ags76.md#String.CompareTo),
[Label.Text](ags59.md#Label.Text)

------------------------------------------------------------------------

[]()

### TextColor property (text box)

    int TextBox.TextColor;

Gets/sets the text colour used to draw the text box. This affects both
the text in the text box, and also the text box's border.

Example:

    txtInput.TextColor = 14;

will change text box 'txtInput' to have yellow text.

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:* [TextBox.Text](ags62.md#TextBox.Text)


