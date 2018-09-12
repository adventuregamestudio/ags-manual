## The script header

This allows you to include the same information into all your scripts.
For example, if you have a global function you want all the room scripts
to use, you can add its import definition to the header file.

Do NOT place any actual functions or variables in this header, because
if you do you will need to re-compile ALL the scripts whenever you
modify the function. Instead, place your functions in your global script
and just place an import line in the header file to allow the other
scripts to access it.
