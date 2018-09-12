## Music and sound

Sound and music are an essential part of any gameplay experience, and
AGS 3.2 and higher provides a re-written audio system giving you full
control over your game audio.

**File formats**

AGS is able to play the following types of audio file: OGG, MP3, MIDI,
WAV (uncompressed), MOD, XM, IT, S3M and VOC.

The only limitation to this is that AGS is only able to play one MIDI
file at a time. If you attempt to play two simulataneous MIDI music
files, the first one will be cut off when the second one starts playing.

If you haven't heard of OGG before, it's a digital music format, similar
to MP3, but achieving better compression and higher quality. More
importantly, it is a totally free format so no royalty payments or
licenses are required to use it. For more information and programs to
encode your music to OGG, see http://www.vorbis.org/

**Audio in the Editor**

Look under the "Audio" branch in the project tree. Here you'll find
sub-nodes called "Speech", "Types" and two default folders called
"Music" and "Sounds".

**Speech**

At the moment, voice speech files are not setup within the editor. See
the [Speech](MusAndSound#voice-speech) help page to find out more about
adding speech to your game.

**Audio Types**

Audio Types allow you to group together similar types of audio files.
The standard distinction here is between Sound and Music, whereby you
usually only want one Music file to be playing at any one time; whereas
you might have several simultaneous sound effects.

Double-click on an Audio Type and it will open up; you can see its
properties in the Property Grid. Here, the "MaxChannels" setting allows
you to specify how many audio clips of this type are allowed to play at
the same time. The "VolumeReductionWhenSpeechPlaying" setting allows you
to have AGS automatically reduce the volume of these audio clips while
speech is playing, to make it easier for the player to hear the speech
over the background music.

You'll probably find that the default settings here are fine, and in
many games you won't need to change them.

**Importing audio files**

Now let's get on to the important question -- how do you add sound and
music to your game? Well, if you right-click on the "Sound" or "Music"
folders (or any other folders that you create yourself), you'll see an
option called "Add Audio Files".

Select this option, and you'll be given a dialog box to find the audio
files that you want to import. Once imported, they'll be assigned script
names automatically.

Double-click an audio file in the project tree to open a window where
you can preview it, as well as change its properties in the Property
Grid.

**Playing audio in the game**

The script to play an audio clip in the game is very simple. For
example:

    aExplosion.Play();

plays the audio clip called *aExplosion*.

**Priorities and channels**

AGS currently has an 8-channel audio system, which means that up to 8
sounds can be playing at the same time. With the default Audio Types
settings, one channel is reserved for speech, one for music and one for
ambient sounds; thus leaving 5 available for sound effects.

If you try to play an audio clip and there are no channels available,
then an existing one will be stopped and the new one will take its
place. However, this will only happen if the new audio clip has an
**equal or higher** priority than one of the currently playing sounds.

Thus, the priority allows you to decide which audio clips are more
important than others. For example, you might set a footstep sound as
low priority, and a door opening as high priority. This can be
configured at the folder level in the editor, and also by changing the
properties of an individual audio clip (by default they will inherit
from their containing folder).

Sometimes you might not want the priority of the sound to be fixed in
the editor -- you might want to decide it at run-time in the script. For
this reason the *Play* command has an optional parameter which allows
you to explicity specify the priority when you play it, for example:

    aExplosion.Play(eAudioPriorityLow);

**Seeking and changing volume**

So, how do you change a sound once it is playing? Well, there are no
methods on the Audio Clip to do this, because you might be playing two
copies of the same sound at once, and then AGS wouldn't know which one
you wanted to access. That's where **Audio Channels** come to the
rescue.

When you use the Play() command, AGS returns to you an AudioChannel\*
instance representing the channel on which the sound is playing. You can
store this to a global variable and access it later on. For example:

    AudioChannel* chan = aExplosion.Play();
    chan.Volume = 20;

This will start the *aExplosion* audio clip playing, and then change its
volume to `20%`.

**Using Audio Channels**

Supposing you want to start playing a sound now, and then change its
volume or panning later on. How would you do that? Well, you'd need to
keep the AudioChannel around, so that you can access it later. The
easiest way to do that is to make it a Global Variable; if you open the
Global Variables editor, you can create a new AudioChannel\* variable
(let's call it *longWindedSound*). Then when you play the sound you set
it like this:

`longWindedSound = aExplosion.Play();`

later on, elsewhere in the script, you can change the volume by doing:

    if (longWindedSound != null)
    {
      longWindedSound.Volume = 20;
    }

Note the check for null here -- this makes sure that your game won't
crash if the sound isn't playing (it might have finished, or not have
been started yet).

**Overall system volume**

There is a property called [System.Volume](System#volume) that
controls the overall game volume, which you can use with some sort of
volume control slider for the player. All individual sound volumes work
within the overall system volume.

**Conclusion**

The new audio system in AGS gives you much more control over your game
audio. Please see the following sections for a complete list of the
supported commands:

[AudioClip reference](AudioClip),
[AudioChannel reference](AudioChannel)


---

### Voice speech

With AGS you can link a line of dialog to a speech file, to enable
"talkie"- style games. Suppose you have a dialog script with the
following:

    ego: "Hi! How are you?"
    michael: "I'm fine."

Normally this would display the words in the speech text above the
characters heads. However, you can add the special character '&' to
symbolise that a voice file should also be played.

The file name has format XXXXY.EXT, where XXXX is made of up to **first
four letters** of the character's script name (except the leading 'c'),
the Y is the speech file number (with no leading or trailing zeroes or
padding of any kind), and EXT is the file extension.

For example, if you have dialog script:

    ego: &10 "Hi! How are you?"
    michael: &7 "I'm fine."

or common script using Say script function:

    cEgo.Say("&10 Hi! How are you?");
    cMichael.Say("&7 I'm fine.");

Both of those examples would play EGO10.WAV with the first line, and
MICH7.WAV with the second. When a line of text has a voice linked to it,
the text on the screen will not be removed until the voice file has
finished playing. If the player interrupts it by clicking the mouse or
pressing a key, the text and voice will be stopped. Voice files must be
placed in the "Speech" sub-directory of the game folder.

**NOTE:** WAV, OGG and MP3 format files can be used for speech.

**NOTE:** You cannot use speech file numbers above 9999. That is, you
can have EGO1.OGG all the way up to EGO9999.OGG, but not EGO10000.OGG or
higher.

Speech is compiled into a file called SPEECH.VOX and is separate from
the rest of your game data so that you can offer it as an optional extra
download to the player. The game will function correctly if the file is
not present.

*SeeAlso:* [Speech.VoiceMode](Speech#voicemode)

---

### The AudioCache folder

When you import audio files into AGS, you'll probably notice that a
folder inside your game folder, called AudioCache, starts to fill up
with files. What is it and why is it there?

Well, when you import audio into AGS, you might be importing it from
anywhere -- it could be off your hard drive, but it might also be off a
USB stick or a CD. AGS can't rely on the audio files always being there
because you might remove the USB stick or delete the files on it.

Therefore, when you import audio into AGS it makes a copy of the file in
the AudioCache folder. AGS also remembers where the file came from, and
when you compile your game it will check if the file has been updated in
its original location -- if so it will copy the latest version to the
AudioCache.

But if the source file no longer exists, your game will continue to
build just fine because AGS has its own copy of the file.

This allows AGS to stick to one of its core principles, that all the
files you need to build your game are within the game's folder. That
way, you have complete security in knowing that by backing up your game
folder, your game will be safe if the worst happens.
