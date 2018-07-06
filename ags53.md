[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags52.md#topic51)
[![Next](forward.gif)](ags54.md#GlobalCommands)

------------------------------------------------------------------------

File functions and properties
-----------------------------

[Open](#File.Open)\
[Close](#File.Close)\
[Delete (file)](#File.Delete)\
[Exists](#File.Exists)\
[ReadInt](#File.ReadInt)\
[ReadRawChar](#File.ReadRawChar)\
[ReadRawInt](#File.ReadRawInt)\
[ReadRawLineBack](#File.ReadRawLineBack)\
[ReadStringBack](#File.ReadStringBack)\
[Seek (file)](#File.Seek)\
[WriteInt](#File.WriteInt)\
[WriteRawChar](#File.WriteRawChar)\
[WriteRawLine](#File.WriteRawLine)\
[WriteString](#File.WriteString)\
[EOF property](#File.EOF)\
[Error property](#File.Error)\
[Position property (file)](#File.Position)\

------------------------------------------------------------------------

[]()

### Open

*(Formerly known as FileOpen, which is now obsolete)*

    static File* File.Open(string filename, FileMode)

Opens a disk file for reading or writing. These disk I/O functions are
only intended for simple tasks like the way the QFG series export the
character when you complete it.

MODE is either eFileRead, eFileWrite or eFileAppend, depending on
whether you want to write to or read from the file. If you pass
eFileWrite and a file called FILENAME already exists, it will be
overwritten.

eFileAppend opens an existing file for writing and starts adding
information at the end (ie. the existing contents are not deleted).

This function returns a File object, which you use to perform operations
on the file. *null* is returned if there was a problem (eg. file not
existing when MODE is eFileRead).

When specifying file path you may use special location tags:\
`$INSTALLDIR$`, which allows you to explicitly read files in the game
installation directory.\
`$SAVEGAMEDIR$`, which allows you to write/read files in the save game
directory.\
`$APPDATADIR$`, which allows you to write/read files to a folder on the
system which is accessible by and shared by all users. The example of
their use is below.

**IMPORTANT**: For security reasons, if you open the file for writing,
then you can ONLY work with files in either `$SAVEGAMEDIR$` or
`$APPDATADIR$` locations. An attempt to write file in `$INSTALLDIR$`
will result in failure, and *null* is returned. An attempt to write file
into relative path without specifying any location tag will make AGS to
automatically remap such path into `$APPDATADIR$`. This is done for
backwards-compatibility. On other hand, if you open file for writing
using an absolute path, or relative path that points to location outside
of game directory, it will automatically be rejected, and *null* is
returned.

**NOTE:** You **MUST** close the file with the Close function when you
have finished using it. There are only a limited number of file handles,
and forgetting to close the file can lead to problems later on.

**NOTE:** Open file pointers are not persisted across save games. That
is, if you open a file, then save the game; then when you restore the
game, the File will not be usable and you'll have to open it again to
continue any I/O. The safest practice is not to declare any global File
variables.

Example:

    File *output = File.Open("$SAVEGAMEDIR$/temp.tmp", eFileWrite);
    if (output == null)
      Display("Error opening file.");
    else {
      output.WriteString("test string");
      output.Close();
    }

will open the file temp.tmp in the save game folder for writing. An
error message is displayed if the file could not be created. Otherwise,
it will write the string "test string" to the file and close it.

*See Also:* [File.Close](ags53.md#File.Close),
[File.Exists](ags53.md#File.Exists),
[File.ReadStringBack](ags53.md#File.ReadStringBack),
[File.WriteString](ags53.md#File.WriteString)

------------------------------------------------------------------------

[]()

### Close

*(Formerly known as FileClose, which is now obsolete)*

    File.Close()

Closes the file, and commits all changes to disk. You **must** call this
function when you have finished reading/writing the file.

Example:

    File *output = File.Open("test.dat", eFileWrite);
    output.WriteString("test string");
    output.Close();

will open the file test.dat, write the string "test string", and close
it.

*See Also:* [File.Open](ags53.md#File.Open)

------------------------------------------------------------------------

[]()

### Delete (file)

    static File.Delete(string filename)

Deletes the specified file from the disk.

For security reasons this command only works with files in the
`$SAVEGAMEDIR$` and `$APPDATADIR$` directories.

**NOTE:** This is a static function, therefore you don't need an open
File pointer to use it. See the example below.

Example:

    File.Delete("$APPDATADIR$/temp.tmp");

will delete the file "temp.tmp" from the app data directory, if it
exists.

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [File.Exists](ags53.md#File.Exists),
[File.Open](ags53.md#File.Open)

------------------------------------------------------------------------

[]()

### Exists

    static bool File.Exists(string filename)

Checks if the specified file exists on the file system.

When specifying file path you may use special location tags:\
`$INSTALLDIR$`, which allows you to explicitly read files in the game
installation directory.\
`$SAVEGAMEDIR$`, which allows you to access files in the save game
directory.\
`$APPDATADIR$`, which allows you to write/read files to a folder on the
system which is accessible by and shared by all users.

**NOTE:** This is a static function, therefore you don't need an open
File pointer to use it. See the example below.

Example:

    if (!File.Exists("temp.tmp"))
    {
      File *output = File.Open("temp.tmp", eFileWrite);
      output.WriteString("some text");
      output.Close();
    }

will create the file "temp.tmp" if it doesn't exist

*Compatibility:* Supported by **AGS 3.0.1** and later versions.

*See Also:* [File.Delete](ags53.md#File.Delete),
[File.Open](ags53.md#File.Open)

------------------------------------------------------------------------

[]()

### ReadInt

*(Formerly known as FileReadInt, which is now obsolete)*

    File.ReadInt()

Reads an integer from the file, and returns it to the script. Only
integers written with File.WriteInt can be read back.

Example:

    int number;
    File *input = File.Open("stats.dat", eFileRead);
    number = input.ReadInt();
    input.Close();

will open the file stats.dat, read an integer into number and then close
the file.

*See Also:* [File.ReadStringBack](ags53.md#File.ReadStringBack),
[File.WriteInt](ags53.md#File.WriteInt)

------------------------------------------------------------------------

[]()

### ReadRawChar

*(Formerly known as FileReadRawChar, which is now obsolete)*

    File.ReadRawChar()

Reads a raw character from the input file and returns it. This function
allows you to read from files that weren't created by your game, however
it is recommended for expert users only.

Example:

    File *input = File.Open("stats.txt", eFileRead);
    String buffer = String.Format("%c", input.ReadRawChar());
    input.Close();

will read a raw character from file stats.txt and writes it to the
string 'buffer'.

*See Also:* [File.ReadStringBack](ags53.md#File.ReadStringBack),
[File.ReadRawInt](ags53.md#File.ReadRawInt),
[File.WriteRawChar](ags53.md#File.WriteRawChar)

------------------------------------------------------------------------

[]()

### ReadRawInt

*(Formerly known as FileReadRawInt, which is now obsolete)*

    File.ReadRawInt()

Reads a raw 32-bit integer from the input file and returns it to the
script. This allows you to read from files created by other programs -
however, it should only be used by experts as no error-checking is
performed.

Example:

    int number;
    File *input = File.Open("stats.txt", eFileRead);
    number = input.ReadRawInt();
    input.Close();

will read a raw integer from file stats.txt and put it into the integer
number.

*See Also:* [File.ReadStringBack](ags53.md#File.ReadStringBack),
[File.ReadRawChar](ags53.md#File.ReadRawChar)

------------------------------------------------------------------------

[]()

### ReadRawLineBack

*(Formerly known as File.ReadRawLine, which is now obsolete)*

    String File.ReadRawLineBack()

Reads a line of text back in from the file and returns it. This enables
you to read in lines from text files and use them in your game.

**NOTE:** this command can only read back plain text lines from text
files. If you attempt to use it with binary files or files written with
commands like WriteString, WriteInt, etc then the results are
unpredictable.

Example:

    File *input = File.Open("error.log", eFileRead);
    if (input != null) {
      while (!input.EOF) {
        String line = input.ReadRawLineBack();
        Display("%s", line);
      }
      input.Close();
    }

will display the contents of the 'error.log' file, if it exists

*See Also:* [File.WriteRawLine](ags53.md#File.WriteRawLine)

------------------------------------------------------------------------

[]()

### ReadStringBack

*(Formerly known as FileRead, which is now obsolete)*\
*(Formerly known as File.ReadString, which is now obsolete)*

    String File.ReadStringBack()

Reads a string back in from a file previously opened with File.Open, and
returns it. You should only use this with files which you previously
wrote out with File.WriteString. Do NOT use this function with any other
files, even text files.

Example:

    File *input = File.Open("test.dat", eFileRead);
    String buffer = input.ReadStringBack();
    input.Close();

will open the file test.dat (which you have previously written with
File.WriteString) and read a string into the buffer. Then close the
file.

*See Also:* [File.Open](ags53.md#File.Open),
[File.WriteString](ags53.md#File.WriteString)

------------------------------------------------------------------------

[]()

### Seek (file)

    int Seek(int offset, optional FileSeek origin);

Moves read/write position by *offset* bytes related to *origin*. Returns
new read/write position. This is usually used when you are reading file
and want to skip over some data, or writing a file and want to move back
and overwrite a piece of data in the previous section for some reason.

The *origin* is determined by one of the FileSeek types: eSeekBegin -
counts *offset* bytes starting from the file's beginning; *offset* must
be positive.\
eSeekCurrent - counts *offset* bytes starting from the current position;
*offset* may be either positive or negative.\
eSeekEnd - counts *offset* bytes starting from the file's end, going
backwards; *offset* must be positive.

If optional *origin* parameter is not specified, eSeekCurrent type is
used by default.

**IMPORTANT:** Do not use Seek on files which you have written with safe
data writing functions, such as WriteInt and WriteString. These
functions add additional data for the purpose of protection against
incorrect reading, and Seek ignores that protection. If you use Seek and
then try to ReadIntBack, for example, most probably you will receive a
reading error. Only use it on files that contain "raw" data, or when you
know written format precisely.

Example:

    File *input = File.Open("test.dat", eFileRead);
    int first_value = input.ReadRawInt();
    input.Seek(256);
    int second_value = input.ReadRawInt();
    input.Close();

will open the file test.dat, read `first_value`, skip 256 bytes, read
`second_value`, and close the file.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [File.Position](ags53.md#File.Position)

------------------------------------------------------------------------

[]()

### WriteInt

*(Formerly known as FileWriteInt, which is now obsolete)*

    File.WriteInt(int value)

Writes VALUE to the file. This allows you to save the contents of
variables to disk. The file must have been previously opened with
File.Open, and you can read the value back later with File.ReadInt.

Example:

    int number = 6;
    File *output = File.Open("stats.dat", eFileWrite);
    output.WriteInt(number);
    output.Close();

will open the file stats.dat and write the integer number in it.

*See Also:* [File.ReadInt](ags53.md#File.ReadInt),
[File.WriteString](ags53.md#File.WriteString)

------------------------------------------------------------------------

[]()

### WriteRawChar

*(Formerly known as FileWriteRawChar, which is now obsolete)*

    File.WriteRawChar(int value)

Writes a single character to the specified file, in raw mode so that
other applications can read it back. If you are just creating a file for
your game to read back in, use File.WriteInt instead because it offers
additional protection. Only use this function if you need other
applications to be able to read the file in.

This command writes a single byte to the output file - therefore, VALUE
can contain any value from 0 to 255.

Example:

    File *output = File.Open("output.txt", eFileWrite);
    output.WriteRawChar('A');
    output.WriteRawChar('B');
    output.WriteRawChar(13);
    output.Close();

will write the text "AB", followed by a carriage return character, to
the file.

*See Also:* [File.ReadRawChar](ags53.md#File.ReadRawChar),
[File.WriteInt](ags53.md#File.WriteInt)

------------------------------------------------------------------------

[]()

### WriteRawLine

*(Formerly known as FileWriteRawLine, which is now obsolete)*

    File.WriteRawLine(string text)

Writes a string of text to the file in plain text format. This enables
you to read it back in Notepad or any text editor. This is useful for
generating logs and such like.

The TEXT will be printed to the file, followed by the standard newline
characters.

Example:

    File *output = File.Open("error.log", eFileAppend);
    output.WriteRawLine("There was an error playing sound1.wav");
    output.Close();

will write an error line in the file error.log.

*See Also:* [File.ReadRawLineBack](ags53.md#File.ReadRawLineBack),
[File.WriteString](ags53.md#File.WriteString)

------------------------------------------------------------------------

[]()

### WriteString

*(Formerly known as FileWrite, which is now obsolete)*

    File.WriteString(string text)

Writes TEXT to the file, which must have been previously opened with
File.Open for writing. The string is written using a custom format to
the file, which can only be read back by using File.ReadStringBack.

Example:

    File *output = File.Open("temp.tmp", eFileWrite);
    if (output == null) Display("Error opening file.");
    else {
      output.WriteString("test string");
      output.Close();
    }

will open the file temp.tmp for writing. If it cannot create the file,
it will display an error message. Otherwise, it will write the string
"test string" and close it.

*See Also:* [File.ReadStringBack](ags53.md#File.ReadStringBack),
[File.Open](ags53.md#File.Open),
[File.WriteRawLine](ags53.md#File.WriteRawLine)

------------------------------------------------------------------------

[]()

### EOF property

*(Formerly known as FileIsEOF, which is now obsolete)*

    readonly bool File.EOF

Checks whether the specified file has had all its data read. This is
only useful with files opened for **reading**. It returns 1 if the
entire contents of the file has now been read, or 0 if not.

Example:

    File *output = File.Open("test.dat", eFileRead);
    while (!output.EOF) {
      int temp = output.ReadRawChar();
      Display("%c", temp);
    }
    output.Close();

will display every character in the file test.dat, one by one, to the
screen.

*See Also:* [File.Error](ags53.md#File.Error),
[File.Open](ags53.md#File.Open),
[File.ReadStringBack](ags53.md#File.ReadStringBack)

------------------------------------------------------------------------

[]()

### Error property

*(Formerly known as FileIsError, which is now obsolete)*

    readonly bool File.Error

Checks whether an error has occurred reading from or writing to the
specified file.

An error can occur if, for example, you run out of disk space or the
user removes the disk that is being read from.

This function only checks for errors while actually reading/writing
data. The File.Open function will return null if there was an error
actually opening or creating the file.

To find out whether all data has been read from a file, use
[EOF](ags53.md#File.EOF) instead.

Example:

    File *output = File.Open("test.dat", eFileWrite);
    output.WriteInt(51);
    if (output.Error) {
      Display("Error writing the data!");
    }
    output.Close();

will write a number to the file 'test.dat', and display a message if
there was a problem.

*See Also:* [File.EOF](ags53.md#File.EOF),
[File.ReadStringBack](ags53.md#File.ReadStringBack)

------------------------------------------------------------------------

[]()

### Position property (file)

    readonly int File.Position

Gets current File's reading or writing position. This value means number
of bytes between file's beginning and current place you are reading from
or writing to.

This may be useful, for example, if you are passing the file pointer to
another script module function and want to know how much data that
function has read or written.

Example:

    File *output = File.Open("test.dat", eFileWrite);
    int old_pos = output.Position;
    WriteCustomModuleData(output);
    int new_pos = output.Position;
    Display("Custom module has written %d bytes", new_pos - old_pos);
    output.Close();

will open file, pass the file pointer to some custom function, then
display amount of data that function wrote.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

*See Also:* [File.Seek](ags53.md#File.Seek)


