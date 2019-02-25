## Preprocessor

Before the AGS Script compiler is ran, an AGS Preprocessor runs, which will modify the script file before it's passed on for the compiler.

### `define` Macro

`#define <macro> <value>`

Define is a Macro, you can think of a way to tell the processor that, whenever the defined name is encountered, it should be replaced by the value or content that follows. It's similar to a variable with a set initial value, but this variable has no type and accepts anything. You can check if a Macro is defined using `#ifdef` preprocessor keyword.


### `ifdef` Macro test 

```
#ifdef <macro>
  //content
#endif
```

```
#ifndef <macro>
  //content
#endif
```


Test if macro is defined or undefined and only pass the content for the compiler if the test is true.


### `ifver` Version Checking 

If you are writing a script module, you may need to check which version of AGS the user of your module is using.
For this purpose there are two directives:

```
#ifver <version>
  // this code will be passed if user's AGS version is above or equal to <version>
#endif
```

```
#ifnver <version>
  // code will be passed if user's AGS version is below <version>
#endif
```

Note that this ability was only added in 2.72, so you cannot use the #ifver checks if you want your module to work with earlier versions than this. Example:

```
#ifver 2.72
// do stuff for 2.72 and above
#endif
#ifnver 2.72
// do stuff for 2.71 and below
#endif
```

_See also:_ [Version Checking Keyword](ScriptKeywords#version-checking)


### `region` code folding

```
#region
  // some code
#endregion
```

You can wrap a code between lines containing `#region` and `#endregion` to create a section used for code folding. In the AGS Editor you can use this to hide sections of your code you don't need to see by using the `+` button at the left side of the script editor.


### `error` throw compile error

`#error`

User defined compile-time error (with message).

### legacy commands
```
#sectionstart
```
```
#sectionend
```
These two preprocessor commands do nothing, they are ignored legacy commands from pre-3 era. 
They are valid keywords so there you have it.

 
_See:_ [Scripting Languange](ScriptingLanguage)
