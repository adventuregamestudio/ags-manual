--invoke as custom writer

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local meta = PANDOC_DOCUMENT.meta
local stringify = (require 'pandoc.utils').stringify
local indices = {}

function Doc(body, metadata, variables)
  local buffer = {}
  local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>]]

  -- get all of the heading info into a table
  for k, v in pairs(meta) do
    if v.headings then
      for name, id in pairs(v.headings) do
        indices[name] = k .. '.html#' .. stringify(id)
      end
    end
  end

  order = function(a, b)
    return b:lower() > a:lower()
  end

  -- sort the table and write it
  for name, id in agsman.pairs_by_keys(indices, order) do
    table.insert(buffer, string.format(format, name, id))
  end

  return table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
