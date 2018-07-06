[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags42.md#CustomDialogOptions)
[![Next](forward.gif)](ags44.md#topic46)

------------------------------------------------------------------------

Built-in enumerated types
-------------------------

AGS has several [enumerated types](ags44.md#enum) built in. These are
used in calls to various commands, and will usually pop up automatically
in autocomplete. However, for times where autocomplete doesn't do the
job, having a manual reference is invaluable:

    enum BlockingStyle {
      eBlock,
      eNoBlock
    };

*Used by:* [Character.Animate](ags47.md#Character.Animate),
[Character.FaceCharacter](ags47.md#Character.FaceCharacter),
[Character.FaceLocation](ags47.md#Character.FaceLocation),
[Character.FaceObject](ags47.md#Character.FaceObject),
[Character.Move](ags47.md#Character.Move),
[Character.Walk](ags47.md#Character.Walk),
[Character.WalkStraight](ags47.md#Character.WalkStraight),
[Object.Animate](ags68.md#Object.Animate),
[Object.Move](ags68.md#Object.Move)

    enum CharacterDirection {
      eDirectionDown = 0,
      eDirectionLeft,
      eDirectionRight,
      eDirectionUp,
      eDirectionDownRight,
      eDirectionUpRight,
      eDirectionDownLeft,
      eDirectionUpLeft,
      eDirectionNone = SCR_NO_VALUE
    };

*Used by:* [Character.ChangeRoom](ags47.md#Character.ChangeRoom),
[Character.FaceDirection](ags47.md#Character.FaceDirection)

    enum Direction {
      eForwards,
      eBackwards
    };

*Used by:* [Character.Animate](ags47.md#Character.Animate),
[Object.Animate](ags68.md#Object.Animate)

    enum WalkWhere {
      eAnywhere,
      eWalkableAreas
    };

*Used by:* [Character.Move](ags47.md#Character.Move),
[Character.Walk](ags47.md#Character.Walk),
[Object.Move](ags68.md#Object.Move)

    enum StopMovementStyle
    {
      eKeepMoving = 0,
      eStopMoving = 1
    };

*Used by:* [Character.LockView](ags47.md#Character.LockViewAligned),
[Character.LockViewFrame](ags47.md#Character.LockViewOffset),
Object.UnlockView (REF NOT FOUND)

    enum RepeatStyle {
      eOnce,
      eRepeat
    };

*Used by:* [Button.Animate](ags57.md#Button.Animate),
[Character.Animate](ags47.md#Character.Animate),
[Object.Animate](ags68.md#Object.Animate)

    enum Alignment {
      eAlignLeft,
      eAlignCentre,
      eAlignRight
    };

*Used by:*
[Character.LockViewAligned](ags47.md#Character.LockViewAligned)

    enum eFlipDirection {
      eFlipLeftToRight,
      eFlipUpsideDown,
      eFlipBoth
    };

*Used by:* [DynamicSprite.Flip](ags52.md#DynamicSprite.Flip)

    enum TransitionStyle {
      eTransitionFade,
      eTransitionInstant,
      eTransitionDissolve,
      eTransitionBoxout,
      eTransitionCrossfade
    };

*Used by:* [SetScreenTransition](ags74.md#SetScreenTransition),
[SetNextScreenTransition](ags74.md#SetNextScreenTransition)

    enum MouseButton {
      eMouseLeft,
      eMouseRight,
      eMouseMiddle,
      eMouseLeftInv,
      eMouseMiddleInv,
      eMouseRightInv,
      eMouseWheelNorth,
      eMouseWheelSouth
    };

*Used by:* [Mouse.IsButtonDown](ags66.md#Mouse.IsButtonDown)\
*Passed into:* on\_mouse\_click

    enum EventType {
      eEventLeaveRoom,
      eEventEnterRoom,
      eEventGotScore,
      eEventGUIMouseDown,
      eEventGUIMouseUp,
      eEventAddInventory,
      eEventLoseInventory,
      eEventRestoreGame
    };

*Passed into:* on\_event

    enum RoundDirection {
      eRoundDown,
      eRoundNearest,
      eRoundUp
    };

*Used by:* [FloatToInt](ags65.md#FloatToInt)

    enum eSpeechStyle {
      eSpeechLucasarts,
      eSpeechSierra,
      eSpeechSierraWithBackground,
      eSpeechFullScreen
    };

*Used by:* [Speech.Style](ags75.md#Speech.Style)

    enum SkipSpeechStyle {
      eSkipKeyMouseTime = 0,
      eSkipKeyTime      = 1,
      eSkipTime         = 2,
      eSkipKeyMouse     = 3,
      eSkipMouseTime    = 4,
      eSkipKey          = 5,
      eSkipMouse        = 6
    };

*Used by:* [Speech.SkipStyle](ags75.md#Speech.SkipStyle)

    enum eVoiceMode {
      eSpeechTextOnly,
      eSpeechVoiceAndText,
      eSpeechVoiceOnly
    };

*Used by:* [Speech.VoiceMode](ags75.md#Speech.VoiceMode)

    enum DialogOptionState {
      eOptionOff,
      eOptionOn,
      eOptionOffForever
    };

*Used by:* [Dialog.GetOptionState](ags49.md#Dialog.GetOptionState),
[Dialog.SetOptionState](ags49.md#Dialog.SetOptionState)

    enum CutsceneSkipType {
      eSkipESCOnly,
      eSkipAnyKey,
      eSkipMouseClick,
      eSkipAnyKeyOrMouseClick,
      eSkipESCOrRightButton
    };

*Used by:* [StartCutscene](ags54.md#StartCutscene)

    enum eOperatingSystem {
      eOSDOS,
      eOSWindows,
      eOSLinux,
      eOSMacOS,
      eOSAndroid,
      eOSiOS,
      eOSPSP
    };

*Used by:* [System.OperatingSystem](ags77.md#System.OperatingSystem)

    enum eCDAudioFunction {
      eCDIsDriverPresent,
      eCDGetPlayingStatus,
      eCDPlayTrack,
      eCDPausePlayback,
      eCDResumePlayback,
      eCDGetNumTracks,
      eCDEject,
      eCDCloseTray,
      eCDGetCDDriveCount,
      eCDSelectActiveCDDrive
    };

*Used by:* [CDAudio](ags67.md#CDAudio)

    enum CursorMode {
      eModeXXXX,
      eModeXXXX,
      ...
    };

The CursorMode enumeration is generated automatically based on your
mouse cursors. The cursor mode name is taken, all its spaces are
removed, and *eMode* is added to the front.\
*Used by:* [IsInteractionAvailable](ags54.md#IsInteractionAvailable),
[Room.ProcessClick](ags73.md#Room.ProcessClick),
[Mouse.ChangeModeGraphic](ags66.md#Mouse.ChangeModeGraphic),
[Mouse.ChangeModeHotspot](ags66.md#Mouse.ChangeModeHotspot),
[Mouse.DisableMode](ags66.md#Mouse.DisableMode),
[Mouse.EnableMode](ags66.md#Mouse.EnableMode), Mouse.IsModeEnabled (REF
NOT FOUND), [Mouse.UseModeGraphic](ags66.md#Mouse.UseModeGraphic),
[Mouse.Mode](ags66.md#Mouse.Mode),
[InventoryItem.IsInteractionAvailable](ags64.md#InventoryItem.IsInteractionAvailable),
[InventoryItem.RunInteraction](ags64.md#InventoryItem.RunInteraction),
[Hotspot.IsInteractionAvailable](ags63.md#Hotspot.IsInteractionAvailable),
[Hotspot.RunInteraction](ags63.md#Hotspot.RunInteraction),
[Object.IsInteractionAvailable](ags68.md#Object.IsInteractionAvailable),
[Object.RunInteraction](ags68.md#Object.RunInteraction),
[Character.IsInteractionAvailable](ags47.md#Character.IsInteractionAvailable),
[Character.RunInteraction](ags47.md#Character.RunInteraction)

    enum FontType {
      eFontXXXX,
      eFontXXXX,
      ...
    };

The FontType enumeration is generated automatically based on your fonts.
The font name is taken, all its spaces are removed, and *eFont* is added
to the front.\
*Used by:* [Button.Font](ags57.md#Button.Font),
[DrawingSurface.DrawMessageWrapped](ags51.md#DrawingSurface.DrawMessageWrapped),
[DrawingSurface.DrawString](ags51.md#DrawingSurface.DrawString),
[DrawingSurface.DrawStringWrapped](ags51.md#DrawingSurface.DrawStringWrapped),
[Game.NormalFont](ags54.md#Game.NormalFont),
[Game.SpeechFont](ags54.md#Game.SpeechFont),
[GetTextHeight](ags54.md#GetTextHeight),
[GetTextWidth](ags54.md#GetTextWidth),
[Label.Font](ags59.md#Label.Font),
[ListBox.Font](ags60.md#ListBox.Font),
[TextBox.Font](ags62.md#TextBox.Font),
[Overlay.CreateTextual](ags69.md#Overlay.CreateTextual),
[Overlay.SetText](ags69.md#Overlay.SetText)

    enum LocationType {
      eLocationNothing,
      eLocationHotspot,
      eLocationCharacter,
      eLocationObject
    };

*Returned by:* [GetLocationType](ags54.md#GetLocationType)

    enum FileMode {
      eFileRead,
      eFileWrite,
      eFileAppend
    };

*Used by:* [File.Open](ags53.md#File.Open)

    enum FileSeek {
      eSeekBegin = 0,
      eSeekCurrent = 1,
      eSeekEnd = 2
    };

*Used by:* [File.Seek](ags53.md#File.Seek)

    enum DialogOptionSayStyle {
      eSayUseOptionSetting,
      eSayAlways,
      eSayNever
    };

*Used by:* [Dialog.DisplayOptions](ags49.md#Dialog.DisplayOptions)

    enum VideoSkipStyle {
      eVideoSkipNotAllowed,
      eVideoSkipEscKey,
      eVideoSkipAnyKey,
      eVideoSkipAnyKeyOrMouse
    };

*Used by:* [PlayVideo](ags67.md#PlayVideo)

    enum AudioFileType {
      eAudioFileOGG,
      eAudioFileMP3,
      eAudioFileWAV,
      eAudioFileVOC,
      eAudioFileMIDI,
      eAudioFileMOD
    };

*Used by:* [AudioClip.FileType](ags46.md#AudioClip.FileType)

    enum AudioPriority {
      eAudioPriorityVeryLow = 1,
      eAudioPriorityLow = 25,
      eAudioPriorityNormal = 50,
      eAudioPriorityHigh = 75,
      eAudioPriorityVeryHigh = 100
    };

*Used by:* [AudioClip.Play](ags46.md#AudioClip.Play),
[AudioClip.PlayFrom](ags46.md#AudioClip.PlayFrom),
[AudioClip.PlayQueued](ags46.md#AudioClip.PlayQueued)
