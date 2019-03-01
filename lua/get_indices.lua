local force_global = {
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
  }
}

local indices = {}
local script_object

function get_script_object(heading)
  local capture
  capture = string.match(heading, '^(%a+) [Pp]roperties')

  if not capture then
    capture = string.match(heading, '^(%a+) [Ff]unctions')
  end

  return capture
end

function get_force_global(key, value)
  if not force_global[key] then
    return false
  end

  for k, v in pairs(force_global[key]) do
    if v == value then
      return true
    end
  end

  return false
end

function Header(elem)
  local heading, id

  if elem.level == 2 then
    id = elem.attr.identifier
    heading = pandoc.utils.stringify(elem)
    script_object = get_script_object(heading)

    if script_object then
      indices[id] = script_object
    else
      indices[id] = heading
    end
  elseif elem.level == 3 then
    id = elem.attr.identifier
    heading = pandoc.utils.stringify(elem)

    if script_object then
      if get_force_global(script_object, heading) then
        indices[id] = heading
      else
        indices[id] = script_object .. '.' .. heading
      end
    else
      indices[id] =  heading
    end
  end
end

function Meta(meta)
  local docname = PANDOC_STATE.output_file:gsub('.*/(%w+)%.%w+$', '%1')
  assert(string.len(docname) > 0)
  local filename = PANDOC_STATE.output_file:gsub('%.%w+$', '.map')
  local format = '%s.html#%s\t%s\n'
  local f = assert(io.open(filename, 'w'))

  for anchor, name in pairs(indices) do
    f:write(string.format(format, docname, anchor, name))
  end

  f:close()
end
