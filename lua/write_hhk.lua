-- invoke as Pandoc writer
-- write an index file for the CHM compiler

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')

function Doc(body, metadata, variables)
  local buffer = {}
  local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>]]
  local indices = {}
  local sections = {}
  local pagemeta = {}

  for file in metadata._metafiles:gmatch('%S+') do
    pagemeta[file:match('([^/]+)%.lua$')] = dofile(file)
  end

  -- get all of the heading info into a table
  for k, v in pairs(pagemeta) do
    local title = v.title
    if v.index then
      for itemtype, item in pairs(v.index) do
        for name, id in pairs(item) do
          local pagelink = k .. '.html#' .. id

          if itemtype == 'script' or name == title then
            -- if this is a script item or a page title then add the link at the root level
            indices[name] = pagelink
          else
            -- if this is not a script item and not the title, add as a subitem under the title
            if sections[title] == nil then
              sections[title] = {}
            end
            sections[title][name] = pagelink
          end
        end
      end
    end
  end

  -- sort the table and write it
  for name, pagelink in agsman.pairs_by_keys(indices, agsman.order_alpha) do
    -- add script object or page header
    table.insert(buffer, string.format(format, name, pagelink))

    -- add page subsections as a child list
    if sections[name] ~= nil then
      table.insert(buffer, '<UL>')

      for sectionname, sectionlink in agsman.pairs_by_keys(sections[name], agsman.order_alpha) do
        table.insert(buffer, string.format(format, sectionname, sectionlink))
      end

      table.insert(buffer, '</UL>')
    end
  end

  return '<UL>' .. table.concat(buffer, '\n') .. '</UL>'
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
