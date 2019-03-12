--invoke as custom writer

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local indices = {}

function Doc(body, metadata, variables)
  local menu = {}
  local buffer = {}
  local header_format = '<h3 id="%s">%s</h3>'
  local link_format = '<a href="%s">%s</a>'
  local section

  order = function(a, b)
    return b:lower() > a:lower()
  end

  for name, id in agsman.pairs_by_keys(indices, order) do
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

function Blocksep()
  return ''
end

function Para(s)
  return s
end

function Space()
  return ' '
end

function Str(s)
  return agsman.escape(s)
end

function Link(s, src, tit, attr)
  -- sanity check, header links will always use an anchor
  assert(string.find(src, '#', 1, true))
  indices[s] = agsman.escape(src)
  return ''
end
