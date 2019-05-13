-- invoke as Pandoc writer
-- write YAML metadata file for later processing

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local meta = PANDOC_DOCUMENT.meta

local namespace_map = {
  Dialog = {
    'StopDialog'
  },
  Display = {
    'Display',
    'DisplayAt',
    'DisplayAtY',
    'DisplayMessage',
    'DisplayMessageAtY',
    'DisplayTopBar'
  },
  Game = {
    'AbortGame',
    'CallRoomScript',
    'ClaimEvent',
    'Debug',
    'DeleteSaveSlot',
    'DisableInterface',
    'EnableInterface',
    'EndCutscene',
    'GetGameOption',
    'GetGameParameter',
    'GetGameSpeed',
    'GetGlobalInt',
    'GetGraphicalVariable',
    'GetLocationType',
    'GetTextHeight',
    'GetTextWidth',
    'GetTranslation',
    'GiveScore',
    'GetFontHeight',
    'GetFontLineSpacing',
    'InventoryScreen',
    'IsGamePaused',
    'IsInterfaceEnabled',
    'IsInteractionAvailable',
    'IsKeyPressed',
    'IsTimerExpired',
    'IsTranslationAvailable',
    'MoveCharacterToHotspot',
    'MoveCharacterToObject',
    'PauseGame',
    'QuitGame',
    'Random',
    'RestartGame',
    'RestoreGameDialog',
    'RestoreGameSlot',
    'RunAGSGame',
    'SaveGameDialog',
    'SaveGameSlot',
    'SaveScreenShot',
    'SetAmbientLightLevel',
    'SetAmbientTint',
    'SetGameOption',
    'SetGameSpeed',
    'SetGlobalInt',
    'SetGraphicalVariable',
    'SetMultitaskingMode',
    'SetRestartPoint',
    'SetTextWindowGUI',
    'SetTimer',
    'SkipUntilCharacterStops',
    'StartCutscene',
    'UpdateInventory',
    'UnPauseGame',
    'Wait',
    'WaitKey',
    'WaitMouseKey'
  },
  Maths = {
    'FloatToInt',
    'IntToFloat'
  },
  Multimedia = {
    'CDAudio',
    ['IsAudioPlaying'] = 'Game',
    'IsSpeechVoxAvailable',
    'PlayFlic',
    'PlaySilentMIDI',
    'PlayVideo',
    ['SetAudioTypeSpeechVolumeDrop'] = 'Game',
    ['SetAudioTypeVolume'] = 'Game',
    'SetSpeechVolume',
    ['StopAudio'] = 'Game'
  },
  Palette = {
    'CyclePalette',
    'SetPalRGB',
    'UpdatePalette'
  },
  Room = {
    'AreThingsOverlapping',
    'DisableGroundLevelAreas',
    'EnableGroundLevelAreas',
    'GetBackgroundFrame',
    'GetPlayerCharacter',
    'GetScalingAt',
    'GetViewportX',
    'GetViewportY',
    'GetWalkableAreaAt',
    'HasPlayerBeenInRoom',
    'ReleaseViewport',
    'RemoveWalkableArea',
    'ResetRoom',
    'RestoreWalkableArea',
    'SetAreaScaling',
    'SetBackgroundFrame',
    'SetViewport',
    'SetWalkBehindBase'
  },
  Screen = {
    'FadeIn',
    'FadeOut',
    'FlipScreen',
    'SetFadeColor',
    'SetNextScreenTransition',
    'SetScreenTransition',
    'ShakeScreen',
    'ShakeScreenBackground',
    'TintScreen'
  }
}

local keywords = {
  ['a'] = false,
  ['and'] = false,
  ['are'] = false,
  ['as'] = false,
  ['at'] = false,
  ['be'] = false,
  ['but'] = false,
  ['by'] = false,
  ['for'] = false,
  ['if'] = false,
  ['in'] = false,
  ['into'] = false,
  ['is'] = false,
  ['it'] = false,
  ['near'] = false,
  ['no'] = false,
  ['not'] = false,
  ['of'] = false,
  ['on'] = false,
  ['or'] = false,
  ['such'] = false,
  ['that'] = false,
  ['the'] = false,
  ['their'] = false,
  ['then'] = false,
  ['there'] = false,
  ['these'] = false,
  ['they'] = false,
  ['this'] = false,
  ['to'] = false,
  ['was'] = false,
  ['will'] = false,
  ['with'] = false
}

local indices = {}
local script_object

function force_namespace(value, key)
  if not namespace_map[key] then
    return false
  end

  for k, v in ipairs(namespace_map[key]) do
    if v == value then
      return true
    end
  end

  return namespace_map[key][value] or false
end

function get_script_object(heading)
  local capture
  capture = string.match(heading, '^(%a+) [Pp]roperties')

  if not capture then
    capture = string.match(heading, '^(%a+) [Ff]unctions')
  end

  return capture
end

function Header(lev, s, attr)
  local id = attr.id
  local name = s

  if lev == 2 then
    script_object = get_script_object(name)

    if script_object then
      indices[id] = script_object
    else
      indices[id] = name
    end
  elseif lev == 3 then
    if not script_object then
      indices[id] = name
    else
      local namespace = force_namespace(name, script_object)

      if namespace == true then
        indices[id] = name
      elseif type(namespace) == 'string' then
        indices[id] = namespace .. '.' .. name
      else
        indices[id] = script_object .. '.' .. name
      end
    end
  end

  return ''
end

function Space()
  return ' '
end

function Str(s)
  add_word(s)
  return s
end

function Code(s, attr)
  for word in s:gmatch('%S+') do
    add_word(word)
  end
  return s
end

function CodeBlock(s, attr)
  for word in s:gmatch('%S+') do
    add_word(word)
  end
  return s
end

function add_word(word)
  local chars = '%w'
  local first = word:sub(1, 1)
  local last = word:sub(-1)

  -- preserve ' in the middle of the word
  if first ~= "'" and last ~= "'" then
    chars = chars .. "'"
  end

   -- preserve - in the middle of the word
  if first ~= '-' and last ~= '-' then
    chars = chars .. '-'
  end

  -- split on non-word characters
  for w in word:gmatch('[' .. chars .. ']+') do
    if w:len() > 1 and not w:match('%d') then
      if keywords[w:lower()] ~= false then
        keywords[w] = (keywords[w] or 0) + 1
      end
    end
  end
end

function Doc(body, metadata, variables)
  local buffer = {}

  table.insert(buffer, '  title: >')
  table.insert(buffer, '    ' .. (meta.title or meta.docname) .. '\n')
  table.insert(buffer, '  headings:')

  for id, name in pairs(indices) do
    table.insert(buffer, string.format("    %s: %s", name, id))
  end

  table.insert(buffer, '\n  keywords:')

  -- order the keyword list ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  for word, count in agsman.pairs_by_keys(keywords, order) do
    if count ~= false then
      table.insert(buffer, string.format("    %s: %d", word, count))
    end
  end

  return '---\n' .. meta.docname .. ':\n' .. table.concat(buffer, '\n') .. '\n---\n'
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
