## Format conventions

Our formatting adheres to GitHub Format Markdown, it uses the features supported by the Pandoc GFM parser. Below are specific conventions used in our docs.

- [Headers and indexing](#headers-and-indexing)
- [Adding notes, tips, etc](#adding-notes-tips-etc)
- [Script API Pages](#script-api-pages)
- [Editorial Pages](#editorial-pages)

### Headers and indexing

A page top title must use an h2 header using a `## ` in it. A page may include subsequent h3 headers, which should use `### ` in it. Always add a new line before and after a title.

```
## Top title

### A topic
```

They will appear in the index as

> A topic (Top title)

About the uniqueness of headings

- all headings that document the script API need to have the script syntax marked as code and have unique names
- all headings that are used for general documentation need to use a level 2 heading that doesn't collide with script syntax or level 2 headings on any other general documentation page
- within a single page all headings names need to be unique

### Adding notes, tips, etc

A topic may require some highlighting of a particular subject. The following highlights are supported

- a **NOTE** descriptive box. It's highlighted in bold, and it includes the colon.
```
**NOTE:** detail text.
```

- a **TIP** descriptive box. It's highlighted in bold, and it includes the colon.
```
**TIP:** a quick and little tip on a subject
```

- an **IMPORTANT** descriptive box. It's highlighted in bold, and it includes the colon.
```
**IMPORTANT:** warning text.
```

- You may also add at the end of a topic entry a *See also* callout. It's highlighted in italics, and it includes the colon.
  A see also callout always contains only a sequence of internal page links, separated by commas. Prefer using a new line for each entry, unless you don't expect them to change anytime soon.

```
*See also:* [APage](APage)
```

### Script API Pages

If a header in a page contains a word with backticks, it's considered a script API page.

A Script API text may be on the subject

- a struct and its properties and functions
- a global scope and its related functions or global variables
- an enum, and it goes in the enum page
- event handlers

When the title includes a struct name, the struct name must be enclosed by backticks.

```
## `Object` functions and properties

Introductory text.
```

#### A Script API entry

A script API entry is always in the following order:

1. Name of the entry, using backticks in the script words in the header format
2. A formerly known as call out if necessary
3. The entry as called with parameters, inside multiline backticks notation
4. The text that describes what the script API does
5. Encouraged, but optionally, an example of usage
6. Optionally a note
7. Optionally a tip
8. Optionally a warning, try to keep these at minimum
9. Optionally a compatibility note
10. Encouraged, but optionally, a see also callout
11. Ends using a new line followed by a horizontal line created by using a triple dash `---`

- **See also callout**: In each script API entry, try to include at least one entry in a related subject using a "See also" callout, format it as follows:
  ```
  *See also:* [`StructName`](StructName), 
  [`StructName.Function`](StructName#structnamefunction),
  [`StructName.Property`](StructName#structnameproperty),
  [NonApiPage](NonApiPage)
  ```

- **Compatibility note**: You may need to include a Compatibility note, they should specify what this restriction in compatibility applies and use bold later when referencing the AGS version.

  ```
  *Compatibility:* The ______ is supported by **AGS 3.5.0** and later versions.
  ```

- **Formerly known note**: When a script entry replaces a previous one, it can have the following note right below its header, using italics
  ```
  *(Formerly known as `PreviousCallInAPI`, which is now obsolete)*
  ```

Use the template below for a script entry. Make sure to only include the items you really need.


    ### `StructName.Method`
    
    *(Formerly known as `FunctionName`, which is now obsolete)*
    
    ```ags
    StructName.Method(int param1, optional int param2)
    ``` 
    
    Description of what the method does with the StructName instance.
    
    Example:
    
    ```ags
    instance.Method(2, 5);
    ```
    
    Will make instance do thing 2 using 5!
    
    **NOTE:** Optional specific note, don't use often.
    
    **TIP:** Optional tip, keep it short and don't use often.
    
    **IMPORTANT:** Optional warning text, only use if really necessary.
    
    *Compatibility:* Optional *param2* parameter is supported only by **AGS 3.X.Y** and later versions.
    *Compatibility:* Supported by **AGS 3.X.Y** and later versions.
    
    *See also:* [`StructName.Method2`](StructName#structnamemethod2)
    
    ---

### Editorial Pages

All pages that have no headers with backticks are editorial pages. These include

- Editor Pane Pages
- Tutorial Pages
- Other Editorial Pages

These pages adhere to the same headings constraints mentioned in "Headers and indexing", and also the callouts mentioned in "Adding notes, tips, etc".
