--invoke as custom writer

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local indices = {}

function Doc(body, metadata, variables)
  local buffer = {}
  local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>]]

  order = function(a, b)
    return b:lower() > a:lower()
  end

  for name, id in agsman.pairs_by_keys(indices, order) do
    table.insert(buffer, string.format(format, name, id))
  end

  return table.concat(buffer, '\n')
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
