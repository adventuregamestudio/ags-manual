package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')

local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>
]]

local indices = {}

function Meta(meta)
  local mapfiles = meta.mapfiles

  for map in mapfiles:gmatch('%S+') do
    assert(agsman.file_exists(map))
    for line in io.lines(map) do
      local id, name = agsman.split_tsv(line)
      indices[name] = id
    end
  end

  -- sort alphabetically ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  local f = assert(io.open(meta.output, 'w'))

  for name, id in agsman.pairs_by_keys(indices, order) do
    f:write(string.format(format, name, id))
  end

  f:close()
end
