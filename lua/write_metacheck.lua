-- invoke as Pandoc writer
-- write a report of metablock checks

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local stringify = (require 'pandoc.utils').stringify

local function get_table_size(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end

function Doc(body, metadata, variables)
  local buffer = {}
  local duplicates = {}
  local duplicates_count = 0
  local link_count = 0
  local meta = PANDOC_DOCUMENT.meta
  local script_items = {}
  local unmatched = {}
  local valid = {}

  -- read explicitly approved links
  if meta._approved_links ~= nil then
    for line in io.lines(meta._approved_links) do
      if line:len() > 0 then
        valid[line] = true
      end
    end
  end

  -- get all script items
  for k, v in pairs(meta) do
    if v.index then
      for itemtype, item in pairs(v.index) do
        if itemtype == 'script' then
          for name, _ in pairs(item) do
            script_items[name] = true
          end
        end
      end
    end
  end

  -- get all valid link targets
  for k, v in pairs(meta) do
    if v.index then
      for itemtype, item in pairs(v.index) do
        valid[k] = true

        for name, id in pairs(item) do
          valid[k .. '#' .. stringify(id)] = true

          if duplicates[name] ~= nil then
            table.insert(duplicates[name], string.format("used again in page '%s'", k))
            io.stderr:write(string.format("%s: Duplicate index item '%s'\n", script_items[name] and "ERROR" or "WARNING", name))
          else
            duplicates[name] = { string.format("first seen in page '%s'", k) }
          end
        end
      end
    end
  end

  -- check all links
  for k, v in pairs(meta) do
    if v.links then
      for link, count in pairs(v.links) do
        if valid[link] == nil then
          local desc = string.format("%s references in page '%s'", stringify(count), k)
          io.stderr:write(string.format("ERROR: unmatched link '%s'\n", link))

          if unmatched[link] ~= nil then
            table.insert(unmatched[link], desc)
          else
            unmatched[link] = { desc }
          end
        end

        link_count = link_count + stringify(count)
      end
    end
  end

  -- order ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  -- output unmatched links and where they appeared
  for link, pages in agsman.pairs_by_keys(unmatched, order) do
    table.insert(buffer, string.format("Unresolved link target: %s", link))

    for n, desc in ipairs(pages) do
      table.insert(buffer, '\t' .. desc)
    end
  end

  -- output duplicate index entries and where they used
  for name, dupinfo in agsman.pairs_by_keys(duplicates, order) do
    if #dupinfo > 1 then
      duplicates_count = duplicates_count + 1
      table.insert(buffer, string.format("Duplicate index entry: %s", name))

      for n, desc in ipairs(dupinfo) do
        table.insert(buffer, '\t' .. desc)
      end
    end
  end

  table.insert(buffer, string.format("\nTotal link count: %d", link_count))
  table.insert(buffer, string.format("Unresolved link targets: %d", get_table_size(unmatched)))
  table.insert(buffer, string.format("Duplicate index entries: %d", duplicates_count))

  return table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
