package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local List = require 'pandoc.List'

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

local indices = List:new{}
local script_object

function get_script_object(heading)
  local capture
  capture = string.match(heading, '^(%a+) [Pp]roperties')

  if not capture then
    capture = string.match(heading, '^(%a+) [Ff]unctions')
  end

  return capture
end

function Header(elem)
  local heading, pagename, target, link
  heading = pandoc.utils.stringify(elem)
  local pagename = PANDOC_STATE.output_file:gsub('.*/(%w+)%.%w+$', '%1.html')
  target = (pagename or '') .. '#' .. (elem.attr.identifier or '')

  if elem.level == 2 then
    script_object = get_script_object(heading)

    if script_object then
      link = pandoc.Link(pandoc.Str(script_object), target)
    else
      link = pandoc.Link(pandoc.Str(heading), target)
    end
  elseif elem.level == 3 then
    if script_object then
      if agsman.table_has_value(force_global, heading, script_object) then
        link = pandoc.Link(pandoc.Str(heading), target)
      else
        link = pandoc.Link(pandoc.Str(script_object .. '.' .. heading), target)
      end
    else
      link = pandoc.Link(pandoc.Str(heading), target)
    end
  end

  if link then
    table.insert(indices, link)
  end
end

function Pandoc(doc)
  local blocks = List:new{ pandoc.Plain(indices) }
  return pandoc.Pandoc(blocks, doc.meta)
end
