-- invoke as Pandoc writer
-- write an a-z index as an HTML document

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')

function Doc(body, metadata, variables)
  local buffer = {}
  local header_format = '<h3 id="%s">%s</h3>'
  local indices = {}
  local link_format = '<a href="%s">%s</a>'
  local menu = {}
  local section
  local pagemeta = {}

  for file in metadata._metafiles:gmatch('%S+') do
    pagemeta[file:match('([^/]+)%.lua$')] = dofile(file)
  end

  -- get all of the heading info into a table
  for k, v in pairs(pagemeta) do
    if v.index then
      local title = v.title

      for _, item in ipairs(v.index) do
        local pagelink = k .. '.html#' .. item["id"]
        local name = item["header"]

        if item["itemtype"] == 'script' or name == title then
          indices[name] = pagelink
        else
          indices[string.format('%s (%s)', name, title)] = pagelink
        end
      end
    end
  end

  -- sort the table and write it
  for name, id in agsman.pairs_by_keys(indices, agsman.order_alpha) do
    local letter = name:sub(1, 1):lower()

    if letter ~= section then
      table.insert(menu, string.format(link_format, '#' .. letter, letter:upper()))
      table.insert(buffer, string.format(header_format, letter, letter:upper()))
      section = letter
    end

    table.insert(buffer, string.format(link_format, id, name) .. '<br>')
  end

  return table.concat(menu, '&nbsp;\n') .. '\n' .. table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
