[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags12.md#topic20)
[![Previous](back.gif)](ags21.md#topic32)
[![Next](forward.gif)](ags23.md#topic38)

------------------------------------------------------------------------

Lip sync
--------

Lip sync is a way to animate character talking in connection with
particular letters and their combinations (phonemes).

Normally when a character is talking, AGS simply cycles through the
speech animation from start to finish, and then loops back round.
However, lip syncing allows you to be cleverer by specifying a
particular frame to go with various letters and sounds. Then, as the
character talks, AGS plays appropriate frames to simulate the character
actually saying those words.

Lip sync is being configured on corresponding 'Lip Sync' pane in the
editor.

[Text-based lip syncing](#topic34)\
[Voice-based lip sync](#topic35)\
[PAMELA](#topic36)\
[Papagayo](#topic37)\

------------------------------------------------------------------------

[]()

### Text-based lip syncing

In the Lip Sync Editor, you have 20 text boxes, one for each possible
frame of the talking loop. In each box, you can enter all the letters
which will cause that frame of the loop to be played. Letter
combinations such as 'th' and 'ch' can be used too - AGS will match each
part of the spoken text to the longest possible phrase in the lip sync
editor.

separate the letters by forward slashes. For example,

    3  R/S/Th/G

will mean that frame 3 of the character's talking animation is shown
whenever the letter R, S, Th or G is spoken.

The "Default frame for unlisted characters" box allows you to set which
frame is used when a character not listed in any of the text boxes is
encountered.

------------------------------------------------------------------------

[]()

### Voice-based lip sync

AGS supports lip syncing voice speech to the talking animation. If you
enable this feature, you cannot use the standard lip-sync for non-voice
lines.

**NOTE: This is an unofficial feature and is not currently supported.
Use at your own risk**

**NOTE:** The voice sync feature only supports Sierra-style speech.

In order to do this, you need to download one of the third-party
applications that produce lip sync data based on voice clips. AGS
supports two such data formats: **PAMELA** and **Papagayo**.

------------------------------------------------------------------------

[]()

### PAMELA

Download PAMELA application by the following link:
`http://www-personal.monash.edu.au/~myless/catnap/pamela/`

Set up the phenomes in Pamela so that there are only 10 (or as many
talking frames as you have) available choices. Then, in the Lip Sync
pane of AGS, change the Type property to "Voice". Enter the Pamela
phenomes into the text boxes to create the association between the
pamela phenome code and the AGS frame number.

For example, enter "AY0" into frame 0's box, "E" into frame 1, and so
forth - corresponding to how it is set up in Pamela. For multiple
phenomes to share the same frame, seperate them with forward slashes --
for example, "AY0/AY1" allows both of those phenomes to correspond to
the specified frame.

Use the Pamela application on each of your speech lines, and save a
Pamela project file (.pam file) for each speech file, naming it the same
as the speech.

For example, the pamela project for EGO46.OGG would be called EGO46.PAM,
placed in your game's Speech folder.

When you build the game, this pam file is compiled into the speech.vox
and will be used to sync the animation of the talking frames during the
game.

**NOTE:** Voice lip sync does not work well with MP3 files. It is
strongly recommended that you use OGG or WAV for speech.

------------------------------------------------------------------------

[]()

### Papagayo

Download Papagayo application by the following link:
`http://www.lostmarble.com/papagayo/`

First you would need to set up your 10 or so phonemes associations (as
described above for PAMELA).

Then start up the Papagayo program and open a speech file in .WAV
format. The waveform will appear on-screen, represented by a blue,
horizontal bar. You can press the triangular 'Play' button at the top of
the screen to listen to the speech audio.

In the "Spoken Text" field at the bottom of the screen, type in the
exact text words heard in the speech file. As you type, you will notice
that each word appears as a horizontal orange bar above the blue
waveform. At the same time, individual pink phonemes start appearing
below the blue waveform bar. (These pink phonemes at the bottom should
correspond to the fields in AGS editor's "Lip Sync" tab).

If you play the speech audio at this point, you'll see that the mouth
image at the upper right corner of the screen changes as each pink
phoneme is reached during playback. However, the result will not be
perfect. To remedy this, you need to drag the orange words at the top of
the screen so that their length matches up with the timing of each
spoken word in the audio. Double-clicking an orange word will make that
portion of the audio play, so you can test if it's accurate.

Sometimes an orange word will contain too many, too few, or inaccurate
phonemes. You can edit these by right-clicking an orange word and
adding, editing, or deleting the desired phonemes. Each one should be
separated by a space.

For even further accuracy, individual pink phonemes can be dragged left
or right to position them more precisely.

When you're happy with the results, you can save the project as a .pgo
file, which will allow you to open and re-edit this line later. But to
use it in AGS, click the "Export" button at the bottom right side of the
screen, and save it as a .dat file.

Use the Papagayo application on each of your speech lines, and export a
Papagayo file (.dat file) for each speech file, naming it the same as
the speech.

For example, the Papagayo project for EGO46.OGG would be called
EGO46.DAT, placed in your game's Speech folder.

When you build the game, this dat file is compiled into the speech.vox
and will be used to sync the animation of the talking frames during the
game.
