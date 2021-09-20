-- invoke as Pandoc writer
-- write an index file for the CHM compiler

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')

function Doc(body, metadata, variables)
  local buffer = {}
  local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>]]
  local pagemeta = {}
  local toplevel = {}
  local sections = {}

  for file in metadata._metafiles:gmatch('%S+') do
    pagemeta[file:match('([^/]+)%.lua$')] = dofile(file)
  end

  -- get all of the heading info into a table
  for k, v in pairs(pagemeta) do
    if v.index then
      local title = v.title

      for _, item in ipairs(v.index) do
        local pagelink = k .. '.htm#' .. item["id"]
        local name = item["header"]

        if item["itemtype"] == 'script' or name == title then
          -- if this is a script item or a page title then add the link at the root level
          toplevel[name] = pagelink
        else
          -- if this is not a script item and not the title, add as a subitem under the title
          if sections[title] == nil then
            sections[title] = {}
          end

          table.insert(sections[title], { [name] = pagelink })
        end

      end
    end
  end

  -- sort the table and write it
  for name, pagelink in agsman.pairs_by_keys(toplevel, agsman.order_alpha) do
    -- add script object or page header
    table.insert(buffer, string.format(format, name, pagelink))

    -- add page subsections as a child list
    if sections[name] ~= nil then
      table.insert(buffer, '<UL>')

      for _, section in ipairs(sections[name]) do
        for sectionname, sectionlink in pairs(section) do
          table.insert(buffer, string.format(format, sectionname, sectionlink))
        end
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
