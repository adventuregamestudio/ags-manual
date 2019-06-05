-- invoke as Pandoc writer
-- write a report of metablock checks

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local meta = PANDOC_DOCUMENT.meta
local stringify = (require 'pandoc.utils').stringify
local valid = {}
local bad = {}

function Doc(body, metadata, variables)
  local buffer = {}

  -- get all valid link targets
  for k, v in pairs(meta) do
    if v.headings then
      valid[k] = true

      for name, id in pairs(v.headings) do
        valid[k .. '#' .. stringify(id)] = true
      end
    end
  end

  -- check all links
  for k, v in pairs(meta) do
    if v.links then
      for link, count in pairs(v.links) do
        if valid[link] == nil then
          local desc = string.format("%s in %s", stringify(count), k)

          if bad[link] ~= nil then
            table.insert(bad[link], desc)
          else
            bad[link] = { desc }
          end
        end
      end
    end
  end

  -- order ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  -- output unmatched links and where they appeared
  for link, pages in agsman.pairs_by_keys(bad, order) do
    table.insert(buffer, link)

    for n, desc in ipairs(pages) do
      table.insert(buffer, '\t' .. desc)
    end
  end

  return table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
