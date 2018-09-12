## AudioChannel functions and properties

The AudioChannel instance represents a currently playing audio file. You
can use this instance to check the status of playing sounds, and adjust
them.


---

### Seek

*(Formerly known as SeekMIDIPosition, which is now obsolete)*<br>
*(Formerly known as SeekMODPattern, which is now obsolete)*<br>
*(Formerly known as SeekMP3PosMillis, which is now obsolete)*

    AudioChannel.Seek(int position)

Seeks the audio clip that is currently playing on this channel to
*position*.

What *position* represents depends on the FileType of the audio clip:

-   **MIDI** - the beat number
-   **MOD/XM/S3M** - the pattern number
-   **WAV/VOC** - the sample number (eg. in a 22050 Hz sound, 22050 =
    1 second)
-   **OGG/MP3** - milliseconds offset

Example:

    AudioChannel *channel = aExplosion.Play();
    Wait(40);
    channel.Seek(0);

will start playing the *aExplosion* audio clip, wait for a second, then
seek it back to the start.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel.Position](AudioChannel#position)

---

### SetRoomLocation

*(Formerly part of PlayAmbientSound, which is now obsolete)*

    AudioChannel.SetRoomLocation(int x, int y)

Sets the currently playing audio to be a directional sound, eminating
from (x,y).

The volume of the channel will be dynamically adjusted depending on how
close the player character is to the co-ordinates. Therefore, as the
player walks closer the volume will increase, and as they walk away the
volume will decrease.

The channel's Volume setting sets the maximum possible volume when the
player is standing on the specified co-ordinates.

Pass the co-ordinates as (0,0) to remove the directional effect and
return this channel to playing at its normal volume.

Example:

    AudioChannel *channel = aMachine.Play();
    channel.SetRoomLocation(oMachine.X, oMachine.Y);

will start playing the *aMachine* audio clip, and set it at the location
of the *oMachine* room object.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel.Volume](AudioChannel#volume)

---

### Speed

    int AudioChannel.Speed

Gets/sets the playing audio clip's playback speed. The value is defined
in clip's milliseconds per second: 1000 is default, meaning 1000 of
clip's ms in 1 real second (scale 1:1). Set < 1000 for slower play
and > 1000 for faster play. **NOTE:** currently works for MP3 and OGG
audio clips only.

Example:

    AudioChannel *channel = aFunnyTalk.Play();
    channel.Speed = 2000;

plays *aFunnyTalk* clip at the double speed.

*Compatibility:* Supported by **AGS 3.4.0** and later versions.

---

### Stop

*(Formerly known as StopAmbientSound, which is now obsolete)*<br>
*(Formerly known as StopChannel, which is now obsolete)*

    AudioChannel.Stop()

Stops the sound that is currently playing on this audio channel.

Example:

    AudioChannel *channel = aExplosion.Play();
    Wait(40);
    channel.Stop();

will start playing the *aExplosion* audio clip, wait for a second, then
stop it.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Game.StopAudio](Multimedia#stopaudio)

---

### ID

    readonly int AudioChannel.ID

Gets the Channel ID of this audio channel. You will not normally need to
use this, but it can be used for inter-operating with legacy commands
such as StopChannel.

Example:

    AudioChannel *channel = aExplosion.Play();
    Display("Explosion playing on channel %d", channel.ID);

will start playing the *aExplosion* audio clip, and display which
channel it is playing on.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

---

### IsPlaying

*(Formerly known as IsChannelPlaying, which is now obsolete)*

    readonly bool AudioChannel.IsPlaying

Gets whether this audio channel is currently playing a sound. Returns
*true* if it is, or *false* if it is not.

Example:

    AudioChannel *channel = aExplosion.Play();
    while (channel.IsPlaying) Wait(1);
    Display("Finished playing the explosion");

will start playing the *aExplosion* audio clip, and wait until it
finishes.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](AudioClip#play)

---

### LengthMs

    readonly int AudioChannel.LengthMs

Gets the length of the audio playing on this channel, in milliseconds.

This is supported by all file types, but with MIDI music it is only
accurate to the nearest second.

If this channel is not currently playing any audio, returns 0.

Example:

    AudioChannel *channel = aExplosion.Play();
    Display("The Explosion sound is %d ms long.", channel.LengthMs);

will start playing the *aExplosion* audio clip, then display its length.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioChannel.PositionMs](AudioChannel#positionms)

---

### Panning

    int AudioChannel.Panning

Gets/sets the panning of this audio channel.

Panning allows you to adjust the stereo balance of the audio. The
default is 0, which is centred and will play at the same volume on both
speakers. However you can adjust this between -100 (fully left) to 100
(fully right) to adjust the balance between the speakers.

**NOTE:** MIDI music files do not support panning.

Example:

    AudioChannel *channel = aExplosion.Play();
    channel.Panning = -100;

will start playing the *aExplosion* audio clip on the left speaker only.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](AudioClip#play)

---

### PlayingClip

*(Formerly known as GetCurrentMusic, which is now obsolete)*

    readonly AudioClip* AudioChannel.PlayingClip

Gets the audio clip that is playing on this channel. This allows you to
find out the type of the clip, and other information.

Returns *null* if there is no sound currently playing on this channel.

Example:

    AudioChannel *channel = System.AudioChannels[2];
    if (channel.PlayingClip == null)
    {
      Display("Nothing is playing on channel 2");
    }
    else
    {
      Display("Channel 2 is playing a clip of type %d", channel.PlayingClip.Type);
    }

will display what is currently playing on audio channel 2.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [AudioClip.Play](AudioClip#play),
[System.AudioChannels](System#audiochannels)

---

### Position

*(Formerly known as GetMIDIPosition, which is now obsolete)*<br>
*(Formerly known as GetMODPattern, which is now obsolete)*<br>
*(Formerly known as GetMP3PosMillis, which is now obsolete)*

    readonly int AudioChannel.Position

Gets the current position of the audio playing on this channel.

What *position* represents depends on the FileType of the audio clip:

-   **MIDI** - the beat number
-   **MOD/XM/S3M** - the pattern number
-   **WAV/VOC** - the sample number (eg. in a 22050 Hz sound, 22050 =
    1 second)
-   **OGG/MP3** - milliseconds offset

This property is read-only. If you want to change the current playback
position within the audio file, use the
[AudioChannel.Seek](AudioChannel#seek) function.

Example:

    AudioChannel *channel = aExplosion.Play();
    Wait(40);
    channel.Seek(channel.Position + 1000);

will start playing the *aExplosion* audio clip, wait for a second, then
seek it ahead one second (if it is OGG/MP3/WAV).

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:*
[AudioChannel.PositionMs](AudioChannel#positionms),
[AudioChannel.Seek](AudioChannel#seek)

---

### PositionMs

    readonly int AudioChannel.PositionMs

Gets the current position of the audio playing on this channel, in
milliseconds.

This is supported by all file types except MIDI, and returns the current
offset into the sound in milliseconds. MIDI files will always return 0.

This property is read-only. If you want to change the current playback
position within the audio file, use the
[AudioChannel.Seek](AudioChannel#seek) function.

Example:

    AudioChannel *channel = aExplosion.Play();
    Wait(40);
    Display("After 1 second, offset is %d ms.", channel.PositionMs);

will start playing the *aExplosion* audio clip, wait for a second, then
display its position.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* *See Also:*
[AudioChannel.LengthMs](AudioChannel#lengthms),
[AudioChannel.Position](AudioChannel#position)

---

### Volume

*(Formerly known as SetChannelVolume, which is now obsolete)*<br>
*(Formerly known as SetMusicVolume, which is now obsolete)*

    int AudioChannel.Volume

Gets/sets the volume of this audio channel, from 0 to 100. This allows
you to dynamically adjust the volume of a playing sound.

This command adjusts the volume of this channel relative to the other
channels. It is still constrained within the overall volume, set by the
System.Volume property.

**NOTE:** This command only affects the current sound being played on
the channel. When a new audio clip starts playing on this channel, the
volume will be set to the DefaultVolume of the new audio clip.

**NOTE:** The volume returned by this property is the channel's base
volume, ie. it does not include the effects of any directional audio set
with SetRoomLocation, or any temporary volume drop while speech is
playing.

Example:

    AudioChannel *channel = aExplosion.Play();
    Wait(40);
    channel.Volume = 20;

will start playing the *aExplosion* audio clip, wait for a second, then
reduce its volume.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:*
[AudioChannel.SetRoomLocation](AudioChannel#setroomlocation),
[Game.SetAudioTypeVolume](Multimedia#setaudiotypevolume),
[System.Volume](System#volume)
