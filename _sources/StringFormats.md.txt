String formatting
-----------------

You will find many times in your game when you need to create a string
based on the values of variables, and functions like
[Display](DisplayAt#display) and
[String.Format](String#format) allow you to do so.

AGS uses printf-style argument formatting (used by the C language). This
means that you intersperse your text with special codes to insert a
variable's value. These special codes begin with a percent sign, and
then specify the variable type. The actual variables that you want to
display are then listed afterwards.

The special codes you can use are as follows:

Code | Description
--- | ---
%d | Integer (use to display value of int and short variables)
%0Xd | Integer left-padded with up to X zeros
%s | String (use to display string variables)
%c | Character (displays the ASCII character of the supplied value)
%f | Float (displays a float variable)
%.Xf | Float to X decimal places
%% | Display the percent character (ie. no variable)
[ | Inserts a new line into the message

Some examples:

    int life = 42;
    float twoPi = Maths.Pi * 2.0;
    String message = "A string variable";

    Display("A normal string with no variables.");
    Display("The meaning of life is %d.", life);
    Display("The meaning of life in 3 digits is %03d.", life);
    Display("2 times Pi is %f.", twoPi);
    Display("The message says: %s.", message);

would display:

    A normal string with no variables.
    The meaning of life is 42.
    The meaning of life in 3 digits is 042.
    2 times Pi is 6.283186.
    The message says: A string variable.

You can display as many variables as you like in one line:

    int life = 42;
    float twoPi = Maths.Pi * 2.0;

    Display("Life is %d, 2 x Pi = %f, and my dinner is %s.", life, twoPi, "awful");

but, **be very careful** that you supply the right number of variables
to correspond with the tags you use in the text. If you don't supply
enough variables, your game could crash.
