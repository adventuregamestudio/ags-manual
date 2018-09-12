## Script language keywords

### Arrays

*data_type* *name* `[` *size* `];`

Arrays allow you to easily create several variables of the same type.
For example, suppose you wanted to store a health variable for all the
different characters in the game. One way would be to declare several
different variables like this:

    int egoHealth;
    int badGuyHealth;
    int swordsmanHealth;

but that quickly gets messy and difficult to keep up to date, since you
need to use different script code to update each one. So instead, you
can do this:

    int health[50];

This example declares 50 int variables, all called *health*.<br>
You access each seperate variable via its **index** (the number in the
brackets). Indexes start from 0, so in this case the *health* array can
be accessed by indexes 0 to 49. If you attempt to access an invalid
index, your game will exit with an error.

Here's an example of using the array:

    health[3] = 50;
    health[4] = 100;
    health[player.ID] = 10;

this sets Health 3 to 50, Health 4 to 100, and the Health index that
corresponds to the player character's ID number to 10.

See Also: [Dynamic arrays](DynamicArrays)

---

### Data types

Type | Description
--- | ---
char | Single byte data type, can store a single character or number 0 to 255
short| 16-bit integer, can store numbers from -32,768 to 32,767
int | 32-bit integer, can store from -2,147,483,648 to 2,147,483,647
String | Stores a string of characters
float | 32-bit floating point number. Accuracy normally about 6 decimal places, but varies depending on the size of the number being stored.
bool | a variable that stores either 'true' or 'false'

You will normally only need to use the **int** and **String** data
types. The smaller types are only useful for conserving memory if you
are creating a very large number of variables.

To declare a variable, write the type followed by the variable name,
then a semicolon. For example:

`int my_variable;`

declares a new 32-bit integer called my_variable

**WARNING:** When using the *float* data type, you may find that the ==
and != operators don't seem to work properly. For example:

    float result = 2.0 * 3.0;
    if (result == 6.0) {
      Display("Result is 6!");
    }

may not always work. This is due to the nature of floating point
variables, and the solution is to code like this:

    float result = 2.0 * 3.0;
    if ((result > 5.99) && (result < 6.01)) {
      Display("Result is 6!");
    }

The way floating point numbers are stored means that 6 might actually be
stored as 6.000001 or 5.999999; this is a common gotcha to all
programming languages so just be aware of it if you use any floating
point arithmetic.

---

### Operators

The AGS scripting engine supports the following operators in
expressions. They are listed in order of precedence, with the most
tightly bound at the top of the list.

**WARNING:** When using operators of equal precedence, AGS by default
evaluates them right-to-left. So, the expression `a = 5 - 4 - 2;`
evaluates as `a = 5 - (4 - 2);` which is not what you might expect.
Always use parenthesis to make it clear what you want.<br>
The "Left-to-right operator precedence" option on the General Settings
pane allows you to control this behaviour.

Operator | Description | Example
--- | --- | ---
`!` | NOT | `if (!a)`
`*` | Multiply | `a = b * c;`
`/` | Divide | `a = b / c;`
`%` | Remainder | `a = b % c;`
`+` | Add | `a = b + c;`
`-` | Subtract | `a = b - c;`
`<<` | Bitwise Left Shift | `a = b << c;`
`>>` | Bitwise Right Shift | `a = b >> c;`
`&` | Bitwise AND | `a = b & c;`
<code>&#124;</code> | Bitwise OR | <code>a = b &#124; c;</code>
`^` | Bitwise XOR | `a = b ^ c;`
`==` | Is equal to | `if (a == b)`
`!=` | Is not equal to | `if (a != b)`
`>` | Is greater than | `if (a > b)`
`<` | Is less than | `if (a < b)`
`>=` | Is greater than or equal | `if (a >= b)`
`<=` | Is less than or equal | `if (a <= b)`
`&&` | Logical AND | `if (a && b)`
<code>&#124;&#124;</code> | Logical OR | <code>if (a &#124;&#124; b)</code>

This order of precedence allows expressions such as the following to
evaluate as expected:

`if (!a && b < 4)`

which will execute the 'if' block if **a** is 0 and **b** is less than
4.

However, it is always good practice to use parenthesis to group
expressions. It's much more readable to script the above expression like
this:

`if ((!a) && (b < 4))`

---

### Constants

The following predefined macros are available in your scripts:

Name | Description
--- | ---
DEBUG | Defined if the game is being compiled in debug mode, not defined otherwise
SCRIPT_API_vXXX | Defined if corresponding version of script API is enabled (e.g. SCRIPT_API_v340)
SCRIPT_COMPAT_vXXX | Defined if certain compatibility level is enabled (e.g. SCRIPT_COMPAT_v321)
STRICT | Defined if "Enforce Object Based Scripting" is enabled, not defined otherwise
STRICT_STRINGS | Defined if "Enforce new-style strings" is enabled, not defined otherwise
STRICT_AUDIO | Defined if "Enforce new-style audio scripting" is enabled, not defined otherwise
LRPRECEDENCE | Defined if "Left-to-right operator precedence" is enabled, not defined otherwise
AGS_NEW_STRINGS | Defined if AGS 2.71 or later (with new-String support), not defined otherwise
NEW_DIALOGOPTS_API | Defined if "Use old-style dialog options rendering API" is disabled
AGS_SUPPORTS_IFVER | Defined if AGS 2.72 or later (with `#ifver` support), not defined otherwise
AGS_MAX_INV_ITEMS | The maximum number of inventory items
AGS_MAX_OBJECTS | The maximum objects per room
AGS_MAX_HOTSPOTS | The maximum hotspots per room
AGS_MAX_REGIONS | The maximum regions per room

You can check for whether a macro is defined or not by using the
`#ifdef` and `#ifndef` keywords:

    #ifndef STRICT
      // only compile the MoveCharacter command if not using object-based scripting
      MoveCharacter(EGO, 30, 40);
    #endif
    #ifdef DEBUG
      // only display this when the game is compiled in debug mode
      Display("Debugging information");
    #endif

There is also an `#error` directive you can use to stop the script
compiling:

    #ifndef AGS_NEW_STRINGS
    #error This script requires at least AGS 2.71
    #endif

The other constants `AGS_MAX_*` are useful if you are writing some
script code that you want to be portable to different versions of AGS,
and to pick up the limits from the user's AGS version. For example, if
you wanted to store some extra information on all the inventory items,
you could do:

    int invWeights[AGS_MAX_INV_ITEMS];

To get the actual number of things in the game rather than the AGS
limit, use the
[Game.CharacterCount](Game#charactercount)-style properties.

---

### Version checking

If you are writing a script module, you may need to check which version
of AGS the user of your module is using.

For this purpose there are two directives:

    #ifver 2.72
    // do stuff for 2.72 and above
    #endif
    #ifnver 2.72
    // do stuff for 2.71 and below
    #endif

Note that this ability was only added in 2.72, so you cannot use the
`#ifver` checks if you want your module to work with earlier versions
than this.

---

### if, else statements

**if (** *expression* **)** `{`<br>
*statements1*<br>
`}`<br>
\[ **else** `{`<br>
*statements2*<br>
`}` \]

If *expression* is true, then *statements1* are run.

If *expression* is not true, and there is an **else** clause present,
then *statements2* are run instead.

For example:

    if (GetGlobalInt(5) == 10) {
      Display("Globalint 5 is 10.");
    }
    else {
      Display("Globalint 5 is not 10.");
    }

In this example, the first message will be displayed if the return value
from `GetGlobalInt(5)` is 10, and the second message will be displayed
if it is not.

**if** statements can be nested inside **else** statements to produce an
"else if" effect. For example:

    if (GetGlobalInt(5) == 1) {
      Display("Globalint 5 is 1.");
    }
    else if (GetGlobalInt(5) == 2) {
      Display("Globalint 5 is 2.");
    }
    else {
      Display("Globalint 5 is not 1 or 2.");
    }

---

### switch, case statements

**switch (** *control_expression* **)** `{`<br>
\[ **case** *match_expression*:<br>
*statements*<br>
\[ **break**; \] \]<br>
\[ **default:**<br>
*statements*<br>
\[ **break**; \] \]<br>
`}`

Compares the result of *control_expression* against the result of
*match_expression* for each **case** label in order. If a match is found,
statements following that label are executed. If there is no matching
label and a **default:** label is present, statements following the
**default:** label are executed.

If a **break** statement is encountered, any statements following it
are skipped and execution continues after the **switch** block.

Unlike many programming languages, AGS allows expression results of any
type (integer, boolean, string, pointers). It also does not require
that *match_expression*s be constant or literal values.

A switch statement is useful if you need to compare one value or
expression against a series of values. The *control_expression*
represents the value you want to compare and each **case** label is
one value in a series to compare it against.

Example:

    switch (player)
    {
        case cEgo:
            Display("Hello, my name is Ego.");
            break;
        case cJohn:
            Display("Greetings, I am John.");
            break;
        case cMary:
            Display("Hi there, I am Mary.");
            break;
        default:
            Display("This might be a bug!");
            break;
    }

In the above example, if the player is cEgo, the game will display "Hello, my
name is Ego." If the player is cJohn, the game will display "Greetings, I am
John." If the player is cMary, the game will display "Hi there, I am Mary." If
the player is none of these characters, the message "This might be a bug!" will
be displayed.

One of the features of a **switch** statement is fall-through. Labels are
ignored once a match is found and indeed execution will continue until the
end of the **switch** block or a **break** statement is encountered.

A **switch** statement that demonstrates this:

    switch (player)
    {
        case cJohn:
        case cMary:
            player.Say("I like oranges.")
            break;
        case cEgo:
            player.Say("I like apples.");
        default:
            player.Say("I would like some berries.");
    }

In the above example, if the player is either cJohn or cMary, s/he will
say "I like oranges.". If the player is cEgo, he will say "I like
apples." and then also "I would like some berries." If the player is any
other character, only the default "I would like some berries." will be
displayed.

A *match_expression* can be any valid AGS expression, including a
function call. The following construction can be useful when implementing
responses to parser values:

    switch (true)
    {
        case Parser.Said("take ball"):
            player.AddInventory(iBall);
            break;
        case Parser.Said("drop ball"):
            player.LoseInventory(iBall);
            break;
    }

In this situation, the *match_expression*s are the results of Parser.Said(). If
*Player.Said("take ball")* is *true*, the ball is added to the player's
inventory. If *Player.Said("drop ball")* is *true*, the ball is removed from the
player's inventory.

---

### while

**while (** *expression* **)** `{`<br>
*statements*<br>
`}`

Runs *statements* continuously, while *expression* is true.

For example:

    while (cEgo.Moving) {
      Wait(1);
    }

will run the script `Wait(1);` repeatedly, as long as `cEgo.Moving` is
not zero. Once it is zero, the **while** statement will exit at the end
of the loop.

---

### do..while

**do** `{`<br>
*statements*<br>
`}` **while (** *expression* **);**

Similarily to [while](ScriptKeywords#while) runs *statements*
continuously, so long as *expression* is true, but unlike **while** it
checks the expression AFTER executing statements, not before. This also
means that the statements will be executed at least once.

For example:

    do
    {
      cEgo.Move(cEgo.x + 1, cEgo.y);
    }
    while (IsKeyPressed(eKeyRightArrow));

will run the script `cEgo.Move(cEgo.x + 1, cEgo.y);` once, and then
continue run it repeatedly, as long as the right arrow key is pressed by
player.

---

### for

**for (** \[*initialization*\]**;** \[*expression*\]**;**
\[*iteration*\] **)** `{`<br>
*statements*<br>
`}`

This loop command first performs *initialization* statements, then runs
*statements* inside curved brackets continuously. Each time before
executing these statements it checks whether *expression* is true, and
if not - ends the loop. Each time after statements were executed it
additionally runs *iteration* statements.

*Initialization* is commonly used to declare variables or setting up
existing variable values. If a new variable is declared in
*initialization* - such variable will exist and may be used only inside
the loop. *Iteration* step is usually meant to "move" to the next step,
by changing some variable value. Every part of the command header -
*initialization*, *expression* and *iteration* - is optional: there may
be **for** command without initialization, or without iteration, or even
without conditional expression (in which case loop should be ended with
either [break](ScriptKeywords#break) or [return](ScriptKeywords#return).

For example:

    for (int i = 0; i < Game.CharacterCount; i++)
    {
      Display("My name is %s", character[i].Name);
    }

will look over every character in game and display their names.

Another example (note missing initialization and iteration):

    for (; cEgo.x < 100;)
    {
      Wait(1);
    }

This will repeat `Wait(1);` until cEgo character does not move beyond
coordinate x = 100.

---

### break

**break**;

`break` statement ends the execution of most inner loop or
[switch](ScriptKeywords#switch-case-statements) immediately. After this script
continues running from the next line after loop or switch.

For example:

    while (cEgo.Moving) {
      if (IsKeyPressed(eKeyEscape))
        break;

      Wait(1);
    }

will run the script `Wait(1);` repeatedly, as long as `cEgo.Moving` is
not zero. If player presses Escape key, the loop is terminated
immediately.

---

### continue

**continue**;

`continue` statement makes the loop skip remaining statements in current
iteration and proceed to the next end-condition check, followed by the
loop restart, if condition is still met, or loop end. If in [for](ScriptKeywords#for)
kind of loop, the *iteration* statement is executed right before that.

For example:

    for (int i = 0; i < 100; i++)
    {
      // multiple statements here

      if (i > 50)
        continue;

      // more statements following
    }

will run first part of the loop statements always, and second part only
when `i <= 50`.

---

### function

**function** *name* `(` \[*type1 param1*, *type2 param2*, ... \] `)`

Declares a custom function in your script. A function is a way in which
you can separate out commonly used code into its own place, and thus
avoid duplicating code.

For example, suppose that you quite often want to play a sound and add
an inventory item at the same time. You could write both commands each
time, or you could define a custom function:

    function AddInvAndPlaySound(InventoryItem* item) {
      player.AddInventory(item);
      aInventorySound.Play();
    }

then, elsewhere in your code you can simply call:

    AddInvAndPlaySound(iKey);

to add inventory item *iKey* and play the sound.

Generally, you place your functions in your global script. You then need
to add an [import](ScriptKeywords#import) line to your script header to allow the
function to be called from room scripts.

**Optional parameters**

You can make *int* parameters optional if there is a default value that
the user doesn't need to supply. To do this, change the script header
*import* declaration like this:

    import function TestFunction(int stuff, int things = 5);

that declares a function with a mandatory *stuff* parameter, and an
optional *things* parameter. If the caller does not supply the second
parameter, it will default to 5.

**NOTE:** To use optional parameters, you need to have an "import"
declaration for the function in the script header. The default values
cannot be specified in the actual function declaration itself.

---

### return

**return**;

Immediately quits currently run function and returns to the previous
script function current one was called from, if there was any, otherwise
passes execution to engine. **return** can be put in any place in the
the function, no matter if it is inside the if/else statement group,
loop or switch - it will still work as immediate function exit.

If the function is declared with return type other than **void** (or
simply like `function`), then the **return** statement **has** to
specify **return value**.

    int GetHowManyTradeGoodsShopkeeperHas() {
      return 2;
    }

Alternatively, when function is not supposed to have any return value,
sometimes you may want to break out of current function before it ends
naturally:

    function DoThisAndOptionallyThat(bool do_all) {
      // multiple statements here

      if (!do_all)
        return; // quit the function prematurely

      // more statements following
    }

---

### struct

**struct** *name* `{`

Declares a custom struct type in your script.<br>
Structs allow you to group together related variables in order to make
your script more structured and readable. For example, suppose that
wanted to store some information on weapons that the player could carry.
You could declare the variables like this:

    int swordDamage;
    int swordPrice;
    String swordName;

but that quickly gets out of hand and leaves you with tons of variables
to keep track of. This is where structs come in:

    struct Weapon {
      int damage;
      int price;
      String name;
    };

Now, you can declare a struct in one go, like so:

    Weapon sword;
    sword.damage = 10;
    sword.price = 50;
    sword.name = "Fine sword";

Much neater and better organised. You can also combine structs with
[arrays](ScriptKeywords#arrays):

    // at top of script
    Weapon weapons[10];
    // inside script function
    weapons[0].damage = 10;
    weapons[0].price = 50;
    weapons[0].name = "Fine sword";
    weapons[1].damage = 20;
    weapons[1].price = 80;
    weapons[1].name = "Poison dagger";

structs are essential if you have complex data that you need to store in
your scripts.

---

### managed

**managed struct** *name* `{`

**Managed** is a modifier that can be applied to **struct** declaration
to make them managed structs.

Managed structs are special in the way that objects of their types are
created in dynamic pool as opposed to global variables, that exist from
the game start to when the game is shut down, and local variables, that
exist only when their function is run. You cannot declare a variable of
managed struct, but only a pointer variable.

The advantage of such managed (or dynamic) objects is that they are
created only when needed and disposed of when no longer needed. Also,
since you work with pointer to object instead of object itself, you may
assign them to another variable without copying object itself, pass them
to function as parameter, or return from the function.

**IMPORTANT:** there is a big limitation for user-defined managed
structs now, it is that they themselves cannot have members of pointer
types (or dynamic arrays).

Example:

    managed struct Apple {
      int color;
      int freshness;
    };

This declares managed struct. To declare a pointer to such struct you
do:

    Apple* my_apple;

This creates a pointer variable `my_apple` of managed type `Apple`.

However, this does **not** create an object itself yet, and `my_apple`
is assigned **null** value now. If you try to access struct members
using `my_apple` now, you will get errors. To create an actual object
you need to use a [new](ScriptKeywords#new) keyword:

    my_apple = new Apple;

The object is now created in the dynamic memory pool, and variable
`my_apple` **points** to it. This lets us access object contents:

    my_apple.color = Game.GetColorFromRGB(255, 0, 0);
    my_apple.freshness = 100;

You may copy pointer to another variable of same type:

    Apple* apple2 = my_apple;

This does **not** copy object itself, only its address in dynamic pool,
meaning both variables - `my_apple` and `appl2` - point to same object!

You may write a function that take such pointer as parameter:

    function DisplayAppleDescription(Apple* apple) {
      String s = String.Format("Apple has color %d and freshness %d", apple.color, apple.freshness);
      Display(s);
    }

and then call it like:

    DisplayAppleDescription(my_apple);

You may write a function that returns pointer to apple:

    Apple* CreateYellowApple(int fresh) {
      Apple* apple = new Apple;
      apple.color = Game.GetColorFromRGB(255, 0, 255);
      apple.freshness = fresh;
      return apple;
    }

and then use such function just like:

    Apple *my_apple = CreateYellowApple(50);

**When does the dynamic object gets destroyed?** After you created
dynamic object as described above, it will exist in memory as long as
*there is at least one pointer variable pointing to it*. As soon as the
last pointer gets destroyed itself (for example, if it was local
function variable, and function ended), or is assigned another object,
or simply assigned `null`, then the dynamic object is removed from your
game forever.

See Also: [new](ScriptKeywords#new), [Pointers in AGS](Pointers)

---

### new

*pointer_variable* = **new** *managed_type*;

Creates a new dynamic (managed) object of *managed_type* and assigns it
to *pointer_variable*.

Example:

    // Here we declare a managed struct for Apple
    managed struct Apple {
      int color;
      int freshness;
    };

    // ...and declare a global pointer to Apple
    Apple* SomeApple;

    // At the game start we create a new dynamic object of Apple type
    // and assign its address to the pointer variable
    function game_start()
    {
      SomeApple = new Apple;
    }

See Also: [managed](ScriptKeywords#managed), [Pointers in AGS](Pointers)

---

### enum

**Recommended for advanced users only**

**enum** *name* `{`<br>
*option1* \[ = *value1* \],<br>
*option2* \[ = *value2* \],<br>
...<br>
`};`

Declares an enumeration type. An enumeration allows you to group
together a set of related options, where only one will be true at any
one time -- a bit like the contents of a list box.

For example, if you have a script function, *doStuff*, that can perform
3 different operations, you could do this:

    function doStuff(int param) {
      if (param == 1) {
        // do something
      }
      else if (param == 2) {
        // do something else
      }
      // etc
    }

but it's hard to read, and when calling the function from elsewhere in
your script, it's not clear what 1 or 2 means. That's where enums come
in:

    enum DoStuffOption {
      BakeCake,
      DoLaundry
    };

    function doStuff(DoStuffOption param) {
      if (param == BakeCake) {
        // do something
      }
      else if (param == DoLaundry) {
        // do something else
      }
      // etc
    }

and then the calling code looks like:<br>
`doStuff(BakeCake);`<br>
thus making it perfectly clear what the command will do.

Normally, you would put the enum definition into the script header.

In summary, enums are not an essential part of scripting and you can get
away perfectly well without using them, but in some specific situations
they're very handy.

---

### this

There are two uses for the `this` keyword.

**1. Accessing members of the current struct**

When you are creating custom [structs](ScriptKeywords#struct), you use the "this" keyword
inside member functions to refer to the current struct. For example:

Suppose you had this in your script header:

    struct MyStruct {
      int myValue;

      import function MyMethod();
    };

Then, in your main script, you could put this:

    function MyStruct::MyMethod()
    {
      this.myValue = 5;
    }

The `MyStruct::MyMethod` tells AGS that you are defining the function
*MyMethod* which belongs to the struct *MyStruct* (the `::` operator
means "belongs to").

The code above will mean that when the MyMethod function is called, it
sets the `myValue` variable to 5.

**2. Declaring extender functions**

Please see the [Extender functions](ExtenderFunctions) page
for details.

---

### import

**import** *declaration* ;

Declares *declaration* as a variable or function which is external to
the current script, but that the script needs access to it. You use this
to provide your room scripts with access to parts of your global script.

For example:

    import int counter;
    import function add_numbers (int, int);

This imports an integer variable `counter` and the function
`add_numbers` from the global script to enable the current script to
call them. You normally place import statements into the script header
so that all rooms can benefit from them.

In order to import the variable, it must have been exported from the
global script with the [export keyword](ScriptKeywords#export).

**NOTE:** You **MUST** import external variables with the correct type.
If `counter` was declared as a **short** in the global script, you MUST
import it as a short, otherwise your game may crash.

**NOTE:** You cannot import old-style `string` variables (this does not
apply to new-style `String` variables).

---

### export

**export** *variable* \[, *variable* ... \] ;

Declares that *variable* can be exported and accessed by other scripts.
You must place this at the **end** of your global script. You can export
many variables with one export line.

For example:

    export my_variable;
    export counter, strength;

This exports three variables - my_variable, counter and strength.

---

### noloopcheck

function **noloopcheck** *function_name* ( *parameters ...* ) `{`

The noloopcheck keyword disables the script loop checking for the
current function.

Normally, if a [while](ScriptKeywords#dowhile) loop runs for more than
150,000 loops, AGS will assume that the script has hung and abort the
game. This is to assist scripting since otherwise the game would lock up
if you scripted a loop wrongly.

However, there are some rare situations in which you need a loop to run
several thousand times (for example, when initialising a very large
array). In this case, the *noloopcheck* keyword can be used to stop AGS
aborting your script.

**NOTE:** The *noloopcheck* keyword must be placed between "function"
and the function's name.<br>
If you import the function into the script header, you **do not**
include the "noloopcheck" keyword in the import declaration -- it is
only included in the actual function body.

**NOTE:** If AGS gives you a script iterations error, **DO NOT** just
automatically add this keyword as a way to fix the problem -- more often
than not, it is a fault in your scripting and using this keyword will
mean that the game will hang rather than abort.

For example:

    function noloopcheck initialize_array() {
      char bigarray[200000];
      int a = 0;
      while (a < 200000) {
        bigarray[a] = 1;
        a++;
      }
    }

without the "noloopcheck" keyword here, AGS would abort that script.
