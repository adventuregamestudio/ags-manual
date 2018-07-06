[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags66.md#topic62)
[![Next](forward.gif)](ags68.md#topic64)

------------------------------------------------------------------------

Multimedia functions
--------------------

[CDAudio](#CDAudio)\
[IsAudioPlaying](#Game.IsAudioPlaying)\
[IsSpeechVoxAvailable](#IsSpeechVoxAvailable)\
[PlayFlic](#PlayFlic)\
[PlaySilentMIDI](#PlaySilentMIDI)\
[PlayVideo](#PlayVideo)\
[SetAudioTypeSpeechVolumeDrop](#Game.SetAudioTypeSpeechVolumeDrop)\
[SetAudioTypeVolume](#Game.SetAudioTypeVolume)\
[SetSpeechVolume](#SetSpeechVolume)\
[StopAudio](#Game.StopAudio)\

------------------------------------------------------------------------

[]()

### CDAudio

    CDAudio (eCDAudioFunction, int param)

This function allows you to play and control an audio CD in your game.
Different tasks are performed, depending on the value of the
AudioFunction parameter. If there is no CD-ROM drive on the system, the
function does nothing.

The PARAM parameter is used by some of the functions for various
reasons; if it is not needed for the particular function you are
calling, pass zero instead.

The tasks performed are as follows depending on the COMMAND parameter:

    eCDIsDriverPresent - checks if there is a CD-ROM driver available on
       the system. Returns 1 if there is, and 0 if there is not.
    eCDGetPlayingStatus - checks whether the CD drive is currently playing
       an audio track. Returns 1 if it is, and 0 if it is not.
    eCDPlayTrack - starts playback from track PARAM on the CD. If the track
       does not exist, or if it is a data track, nothing happens.
    eCDPausePlayback - pauses the currently playing audio track.
    eCDResumePlayback - continues from where the track was paused.
    eCDGetNumTracks - returns the number of tracks on the CD
       currently in the drive. If the drive is empty, returns 0.
    eCDEject - ejects the drive tray if the drive has the ability. This is
       a feature you'll play with to start off because it's neat, and then
       realize that it has no real use in your game.
       Your script does not continue until the drive is fully ejected.
    eCDCloseTray - the reverse of Eject. This will pull the drive tray back
       in again. Your script does not continue until the drive has been
       fully closed.
    eCDGetCDDriveCount - returns the number of CD drives in the
       system, normally 1.
    eCDSelectActiveCDDrive - changes the current CD drive to PARAM,
       where PARAM ranges from 1 to (number of CD drives). All the other
       CD Audio functions operate on the current CD drive.

NOTE: These CD Audio functions are slow compared to all the other script
functions. This will not be noticeable if you call them from most
scripts, but using CDAudio in a repeatedly\_execute script will
noticeably slow down the game.

**Cross-Platform Support**

Windows: **Yes, but supports 1 CD-ROM drive only**\
MS-DOS: **Yes, if CD-ROM device driver loaded**\
Linux: **Yes, but supports 1 CD-ROM drive only**\
MacOS: **No**

Example:

    CDAudio(eCDPlayTrack, 3);

will play track 3 of the CD that's in the CD ROM drive.

------------------------------------------------------------------------

[]()

### IsAudioPlaying

*(Formerly known as IsMusicPlaying, which is now obsolete)*\
*(Formerly known as IsSoundPlaying, which is now obsolete)*

    static bool Game.IsAudioPlaying(optional AudioType)

Returns *true* if there is currently audio playing of the specified
type. If you don't supply an audio type, then *true* will be returned if
there is any audio at all playing in the game.

If no audio of the specified type is playing, returns *false*. You can
use this to wait for some music to finish playing, for example.

Example:

    while (Game.IsAudioPlaying(eAudioTypeMusic))
    {
      Wait(1);
    }

waits for any currently playing music to finish.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Game.StopAudio](ags67.md#Game.StopAudio)

------------------------------------------------------------------------

[]()

### IsSpeechVoxAvailable

    IsSpeechVoxAvailable()

Returns whether the SPEECH.VOX file is being used by the game. This
could be useful if you have an optional speech download pack, and you
want to know whether the player has it or not.

Returns 1 if the speech files are available, 0 if not.

Example:

    if (IsSpeechVoxAvailable()==0)
        Display ("You don't have the voice pack");

will display a message if the voice pack is not available.

**NOTE:** This function used to be called IsVoxAvailable, but has now
been renamed to avoid confusion.

*See Also:* [AudioClip.IsAvailable](ags46.md#AudioClip.IsAvailable)

------------------------------------------------------------------------

[]()

### PlayFlic

    PlayFlic (int flic_number, int options)

Plays a FLI or FLC animation. The game checks for FLICx.FLC and
FLICx.FLI (where X is FLIC\_NUMBER) and if it finds one, plays it.

OPTIONS has these meanings:

    0  player can't skip animation
    1  player can press ESC to skip animation
    2  player can press any key or click mouse to skip animation
    +10 (ie.10,11,12) do not stretch to full-screen, just play at flc size
    +100 do not clear the screen before starting playback

The game is paused while the animation plays.

Example:

    PlayFlic(2, 1);

will play flic2 and the player will be able to skip the flic by pressing
the ESC key.

*See Also:* [PlayVideo](ags67.md#PlayVideo)

------------------------------------------------------------------------

[]()

### PlaySilentMIDI

    PlaySilentMIDI (int music_number)

This command is obsolete.

Use the AudioClip.Play command and set its Volume property to 0 to
simulate this effect.

*See Also:* [AudioClip.Play](ags46.md#AudioClip.Play),
[AudioChannel.Volume](ags45.md#AudioChannel.Volume)

------------------------------------------------------------------------

[]()

### PlayVideo

    PlayVideo (string filename, VideoSkipStyle, int flags)

Plays an AVI, MPG or OGG Theora file, or any other file type supported
by Media Player. The game is paused while the video plays.

*VideoSkipStyle* defines how the player can skip the video:

    eVideoSkipNotAllowed     player can't skip video
    eVideoSkipEscKey         player can press ESC to skip video
    eVideoSkipAnyKey         player can press any key to skip video
    eVideoSkipAnyKeyOrMouse  player can press any key or click mouse to skip

FLAGS can be one of the following:

    0: the video will be played at original size, with AVI audio
    1: the video will be stretched to full screen, with appropriate
       black borders to maintain its aspect ratio and AVI audio.
    10: original size, with game audio continuing (AVI audio muted)
    11: stretched to full screen, with game audio continuing (AVI audio muted)

There are two distinct type of videos that the PlayVideo function can
play.

The first is OGG Theora, which is a recently introduced video file
format. AGS has built-in support for playing these videos, so everyone
who plays your game will be able to see the video. OGG Theora videos are
also built into the game EXE file when you compile the game (just make
sure the file has a .OGV extension and is placed in your main game
folder).

The second type of files that AGS can play is anything supported by
Windows Media Player. This includes AVI, MPG and more. However, in order
for these to work on the player's system, they will need to have the
correct codecs installed. For example, if you create your video with the
XVid codec, the player will need to have XVid installed to be able to
view it. These types of video cannot be included into the game EXE, so
you will have to place them separately in the Compiled folder for them
to work.

**NOTE:** In 256-colour games, PlayVideo is not supported. Please use a
FLC/FLI video with the [PlayFlic](ags67.md#PlayFlic) command instead.

**Cross-Platform Support**

Windows: **Yes**\
MS-DOS: **No**\
Linux: **No**\
MacOS: **Yes**

Example:

    PlayVideo("intro.mpg", eVideoSkipEscKey, 1);

will play the video Intro.mpg, allowing the player to skip with ESC if
they've seen it before.

*Compatibility:* OGG Theora supported by **AGS 3.1.1** and later
versions.

*See Also:* [PlayFlic](ags67.md#PlayFlic)

------------------------------------------------------------------------

[]()

### SetAudioTypeSpeechVolumeDrop

*(Formerly known as game.speech\_music\_drop, which is now obsolete)*

    static Game.SetAudioTypeSpeechVolumeDrop(AudioType, int volumeReduction)

Changes the VolumeReductionWhileSpeechPlaying of the specified
*AudioType*. This changes the setting, initially set in the Audio Types
part of the editor. It specifies how much the volume of clips of this
type will be reduced by while speech is playing.

Specify 0 for no volume adjustment, up to 100 which will completely
silence these audio clips while speech is playing.

Example:

    Game.SetAudioTypeSpeechVolumeDrop(eAudioTypeMusic, 25);

will reduce the volume of Music audio clips by 25 percentage points
while speech is playing.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Game.SetAudioTypeVolume](ags67.md#Game.SetAudioTypeVolume)

------------------------------------------------------------------------

[]()

### SetAudioTypeVolume

*(Formerly known as SetSoundVolume, which is now obsolete)*

    static Game.SetAudioTypeVolume(AudioType, int volume, ChangeVolumeType)

Changes the default volume of the specified *AudioType*. This allows you
to change the volume of all audio clips of a particular type, so that
you can easily control sound and music volume separately, for example.

VOLUME ranges from 0-100, where 100 is the loudest, and 0 will mute
sound of that type completely.

Possible values for *ChangeVolumeType* are:

    eVolChangeExisting      change the volume of currently playing audio clips
    eVolSetFutureDefault    change the default volume for clips of this type
    eVolExistingAndFuture   change both currently playing and future audio

Initially general AudioType volume is not set, meaning that all future
audio will be playing using their own custom volumes. If you use the
*eVolSetFutureDefault* or *eVolExistingAndFuture*, then the
DefaultVolume property for all audio clips of this type will be
overridden. This means that any DefaultVolume set up in the editor will
be lost.

Example:

    Game.SetAudioTypeVolume(eAudioTypeMusic, 20, eVolExistingAndFuture);

will change the volume of all currently playing and future music to
`20%`.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [SetSpeechVolume](ags67.md#SetSpeechVolume),
[AudioClip.Play](ags46.md#AudioClip.Play),
[System.Volume](ags77.md#System.Volume)

------------------------------------------------------------------------

[]()

### SetSpeechVolume

    SetSpeechVolume (int volume)

Sets the volume for in-game speech. VOLUME ranges from 0-255, where 255
is the loudest. The default speech volume is 255 so this function can
only be used to reduce the volume.

Example:

    SetSpeechVolume(200);

will set the speech volume to 200.

*See Also:* [Game.SetAudioTypeVolume](ags67.md#Game.SetAudioTypeVolume)

------------------------------------------------------------------------

[]()

### StopAudio

*(Formerly known as Game.StopSound, which is now obsolete)*\
*(Formerly known as StopMusic, which is now obsolete)*

    static Game.StopAudio(optional AudioType)

Stops all currently playing audio. If you pass no parameters, then all
audio will be stopped. Alternatively, you can pass one of the AudioTypes
which will only stop audio clips of that type.

If there are any audio clips queued up with PlayQueued, they will also
be cancelled.

Example:

    Game.StopAudio();

will stop all currently playing audio.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Game.IsAudioPlaying](ags67.md#Game.IsAudioPlaying),
[AudioClip.Play](ags46.md#AudioClip.Play),
[AudioChannel.Stop](ags45.md#AudioChannel.Stop)
