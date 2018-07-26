ASCII code table
----------------

This section lists the key codes which can be passed to on_key_press
and which keys they represent:

AGS KeyCode | Key | ASCII code
--- | --- | ---
eKeyNone | none | 0
eKeyCtrlA | Ctrl+A | 1
eKeyCtrlB | Ctrl+B | 2
eKeyCtrlC | Ctrl+C | 3
eKeyCtrlD | Ctrl+D | 4
eKeyCtrlE | Ctrl+E | 5
eKeyCtrlF | Ctrl+F | 6
eKeyCtrlG | Ctrl+G | 7
eKeyCtrlH | Ctrl+H | 8
eKeyCtrlI | Ctrl+I | 9
eKeyCtrlJ | Ctrl+J | 10
eKeyCtrlK | Ctrl+K | 11
eKeyCtrlL | Ctrl+L | 12
eKeyCtrlM | Ctrl+M | 13
eKeyCtrlN | Ctrl+N | 14
eKeyCtrlO | Ctrl+O | 15
eKeyCtrlP | Ctrl+P | 16
eKeyCtrlQ | Ctrl+Q | 17
eKeyCtrlR | Ctrl+R | 18
eKeyCtrlS | Ctrl+S | 19
eKeyCtrlT | Ctrl+T | 20
eKeyCtrlU | Ctrl+U | 21
eKeyCtrlV | Ctrl+V | 22
eKeyCtrlW | Ctrl+W | 23
eKeyCtrlX | Ctrl+X | 24
eKeyCtrlY | Ctrl+Y | 25
eKeyCtrlZ | Ctrl+Z | 26
eKey0 | 0 | 48
eKey1 | 1 | 49
eKey2 | 2 | 50
eKey3 | 3 | 51
eKey4 | 4 | 52
eKey5 | 5 | 53
eKey6 | 6 | 54
eKey7 | 7 | 55
eKey8 | 8 | 56
eKey9 | 9 | 57
eKeyA | A | 65
eKeyB | B | 66
eKeyC | C | 67
eKeyD | D | 68
eKeyE | E | 69
eKeyF | F | 70
eKeyG | G | 71
eKeyH | H | 72
eKeyI | I | 73
eKeyJ | J | 74
eKeyK | K | 75
eKeyL | L | 76
eKeyM | M | 77
eKeyN | N | 78
eKeyO | O | 79
eKeyP | P | 80
eKeyQ | Q | 81
eKeyR | R | 82
eKeyS | S | 83
eKeyT | T | 84
eKeyU | U | 85
eKeyV | V | 86
eKeyW | W | 87
eKeyX | X | 88
eKeyY | Y | 89
eKeyZ | Z | 90
eKeyAmpersand | & | 38
eKeyAsterisk | * | 42
eKeyAt | @ | 64
eKeyBackSlash | \ | 92
eKeyBackspace | Backspace | 8
eKeyCloseBracket | ] | 93
eKeyCloseParenthesis | ) | 41
eKeyColon | : | 58
eKeyComma | , | 44
eKeyDelete | Delete | 383
eKeyDollar | $ | 36
eKeyDoubleQuote | " | 34
eKeyEquals | = | 61
eKeyEscape | ESC | 27
eKeyExclamationMark | ! | 33
eKeyForwardSlash | / | 47
eKeyGreaterThan | > | 62
eKeyHash | # | 35
eKeyHyphen | - | 45
eKeyInsert | Insert | 382
eKeyLessThan | < | 60
eKeyOpenBracket | [ | 91
eKeyOpenParenthesis | ( | 40
eKeyPercent | % | 37
eKeyPeriod | . | 46
eKeyPlus | + | 43
eKeyQuestionMark | ? | 63
eKeyReturn | RETURN | 13
eKeySemiColon | ; | 59
eKeySingleQuote | ' | 39
eKeySpace | SPACE | 32
eKeyTab | TAB | 9
eKeyUnderscore | _ | 95
eKeyF1 | F1 | 359
eKeyF2 | F2 | 360
eKeyF3 | F3 | 361
eKeyF4 | F4 | 362
eKeyF5 | F5 | 363
eKeyF6 | F6 | 364
eKeyF7 | F7 | 365
eKeyF8 | F8 | 366
eKeyF9 | F9 | 367
eKeyF10 | F10 | 368
eKeyF11 | F11 | 433
eKeyF12 | F12 | 434
eKeyHome | Home | 371
eKeyUpArrow | UpArrow | 372
eKeyPageUp | PageUp | 373
eKeyLeftArrow | LeftArrow | 375
eKeyNumPad5 | NumPad 5 | 376
eKeyRightArrow | RightArrow | 377
eKeyEnd | End | 379
eKeyDownArrow | DownArrow | 380
eKeyPageDown | PageDown | 381

Use these key codes in your on_key_press function to process player
input. For example:

    if (keycode == eKeyA) Display("You pressed A");
    if (keycode == eKeyPlus) Display("You pressed the Plus key");

The following extra codes can only be used with IsKeyPressed (ie.
on_key_press is never called with these codes):

Key | ASCII code
--- | ---
Left shift | 403
Right shift | 404
Left ctrl | 405
Right ctrl | 406
Alt | 407
