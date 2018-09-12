## TextBox functions and properties

### Font

*(Formerly known as SetTextBoxFont, which is now obsolete)*

    FontType TextBox.Font

Gets/sets the font used by the specified text box. This might be useful
if you need a player input text box to use a different font with foreign
language translations, for example.

Example:

    txtUserInput.Font = eFontNormal;

will change the *txtUserInput* text box to use Font "Normal".

*See Also:* [Label.Font](Label#font),
[TextBox.Text](TextBox#text)

---

### Text

*(Formerly known as GetTextBoxText, which is now obsolete)*<br>
*(Formerly known as SetTextBoxText, which is now obsolete)*<br>
*(Formerly known as TextBox.GetText, which is now obsolete)*<br>
*(Formerly known as TextBox.SetText, which is now obsolete)*

    String TextBox.Text;

Gets/sets the text box contents. This might be useful to reset the text
box to blank after the user has typed something in, or to fill in a
default value.

Example:

    txtUserInput.Text = "";

will clear the txtUserInput text box.

*See Also:* [TextBox.Font](TextBox#font),
[String.CompareTo](String#compareto),
[Label.Text](Label#text)

---

### TextColor

    int TextBox.TextColor;

Gets/sets the text colour used to draw the text box. This affects both
the text in the text box, and also the text box's border.

Example:

    txtInput.TextColor = 14;

will change text box 'txtInput' to have yellow text.

*Compatibility:* Supported by **AGS 3.1.0** and later versions.

*See Also:* [TextBox.Text](TextBox#text)

