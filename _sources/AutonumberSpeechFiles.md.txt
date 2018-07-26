Auto-number speech files
------------------------

If you've already made your game, and then you decide you want a voice
pack to go with it, the thought of manually adding speech numbers to
every line of speech in the game is rather daunting. But never fear,
this is where the Auto-number Speech Files feature comes in.

If you select this option, then it will go through all the speech lines
in the game and add a&NUM to the start of them. A summary of the results
is written to a file called SPEECHREF.TXT in the game folder, so that
you can easily see what file is what when recording the speech.

The following types of message are auto-numbered. If one of the messages
already has a speech number, it will be overwritten:

-   room messages set to be displayed as speech
-   dialog script messages
-   dialog options (if "Say" is selected for the option)
-   Say commands in scripts

