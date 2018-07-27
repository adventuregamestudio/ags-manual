AudioClip functions and properties
----------------------------------

AudioClips are created when you import files in the AGS Editor. The
commands in this section allow to play them.

[Play](#play)<br>
[PlayFrom](#playfrom)<br>
[PlayQueued](#playqueued)<br>
[Stop](#stop)<br>
[FileType property](#filetype)<br>
[IsAvailable property](#isavailable)<br>
[Type property](#type)

---

### Play

*(Formerly known as PlayAmbientSound, which is now obsolete)*<br>
*(Formerly known as PlayMP3File, which is now obsolete)*<br>
*(Formerly known as PlayMusic, which is now obsolete)*<br>
*(Formerly known as PlaySound, which is now obsolete)*<br>
*(Formerly known as PlaySoundEx, which is now obsolete)*<br>
*(Formerly known as SetMusicRepeat, which is now obsolete)*

    AudioChannel* AudioClip.Play(optional AudioPriority, optional RepeatStyle)

Plays the audio clip.

Optionally you can supply a priority and Repeat setting; if you do not
supply these, the defaults set for the audio clip in the editor will be
used.

This command searches through all the available audio channels to find
one that is available for this type of audio. If no spare channels are
found, it will try to find one that is playing a clip with a lower or
equal priority, and interrupt it to replace it with this new sound.

If all audio channels are busy playing higher priority sounds, then this
new audio clip will not be played.

This command returns the AudioChannel instance that the new sound is
playing on, or *null* if it did not play for any reason.

**NOTE:** AGS can only play one MIDI file at a time.

Example:

    aExplosion.Play();

plays the *aExplosion* audio clip.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.PlayFrom](#playfrom),
[AudioClip.PlayQueued](#playqueued),
[AudioClip.Stop](#stop)

---

### PlayFrom

    AudioChannel* AudioClip.PlayFrom(int position, optional AudioPriority,
                                     optional RepeatStyle)

Plays the audio clip, starting from *position*. For the meaning of the
position, see the [AudioChannel.Seek](AudioChannel#seek) help
page.

Otherwise, this command behaves identially to
[AudioClip.Play](#play). Please see that help page
for more information.

Example:

    aExplosion.PlayFrom(1000);

plays the *aExplosion* audio clip, starting from a 1 second offset (if
it is OGG/MP3).

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](#play)

---

### PlayQueued

*(Formerly known as PlayMusicQueued, which is now obsolete)*

    AudioChannel* AudioClip.PlayQueued(optional AudioPriority, optional RepeatStyle)

Plays the audio clip, or queues it to be played later if it cannot be
played now.

This command behaves identially to
[AudioClip.Play](#play), except that if there are no
available audio channels, it will queue this audio clip to be played
when a channel becomes available.

Additionally, unlike the Play command, using PlayQueued will not
interrupt an existing audio clip with an equal priority; it will only
interrupt clips with a lower priority.

You can queue up to 10 tracks in the audio queue. Note that if you queue
audio clips to be played after a repeating audio clip, they will never
be played.

Example:

    aExplosion.Play();
    aAftermath.PlayQueued();

plays the *aExplosion* audio clip, and queues the *aAftermath* sound to
be played afterwards.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](#play)

---

### Stop

    AudioClip.Stop()

Stops all currently playing instances of this audio clip.

Example:

    aExplosion.Play();
    Wait(40);
    aExplosion.Stop();

plays the *aExplosion* audio clip, waits 1 second and then stops it
again.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](#play)

---

### FileType

    readonly AudioFileType AudioClip.FileType;

Gets the file type of this audio clip. This is useful in conjunction
with the PlayFrom and Seek commands to determine what the position
offset represents.

Example:

    if (aExplosion.FileType == eAudioFileMIDI)
    {
      Display("Explosion is a MIDI file!");
    }

displays a message if aExplosion is a MIDI file

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel.Seek](AudioChannel#seek),
[AudioChannel.Position](AudioChannel#position),
[AudioClip.PlayFrom](#playfrom)

---

### IsAvailable

*(Formerly known as IsMusicVoxAvailable, which is now obsolete)*

    readonly bool AudioClip.IsAvailable;

Gets whether this audio clip is available on the player's system.

This will normally be *true*, unless the clip was bundled in the
external AUDIO.VOX file and the player does not have the file on their
system.

You do not normally need to check this property, since the Play command
will silently fail if it cannot find the audio clip to play.

Example:

    if (aExplosion.IsAvailable)
    {
      aExplosion.Play();
    }

checks if the aExplosion audio clip is available, and if so plays it.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](#play)

---

### Type

    readonly AudioType AudioClip.Type;

Gets the type of this audio clip, as initially set in the editor.

The AudioType allows you to group audio clips into areas such as Sound
and Music.

Example:

    if (aExplosion.Type == eAudioTypeMusic)
    {
      Display("Explosion is music!");
    }

displays a message if the *aExplosion* clip is music.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](#play),
[Game.IsAudioPlaying](Multimedia#isaudioplaying)
