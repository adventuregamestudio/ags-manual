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
local title

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

    -- save first heading to use as the page title
    if not title then
      title = heading
    end

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

function get_dir(path, sep)
  sep = sep or '/'
  return path:match('(.*' .. sep .. ')')
end

function Meta(meta)
  local docname = meta.title
  local tsv =  get_dir(PANDOC_STATE.output_file) .. docname .. '.tsv'
  local f = assert(io.open(tsv, 'w'))

  if title then
    meta.title = title
  end

  for anchor, name in pairs(indices) do
    f:write(string.format("%s.html#%s\t%s\n", docname, anchor, name))
  end

  f:close()
  return meta
end
