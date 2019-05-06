-- invoke as Pandoc writer
-- write Javascript file for website search functions and data

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local meta = PANDOC_DOCUMENT.meta
local stringify = (require 'pandoc.utils').stringify

function render_keywords(keywords)
  local buffer = {}

  order_alpha = function(a, b)
    return b:lower() > a:lower()
  end

  order_num = function(a, b)
    return a > b
  end

  -- sort the keywords table and write it
  for word, map in agsman.pairs_by_keys(keywords, order_alpha) do
    local flipped = {}

    for name, count in pairs(map) do
      flipped[count] = name
    end

    local outer = {}
    local inner = {}
    local n = 0

    table.insert(outer, string.format('    "%s": {', word))

    for count, name in agsman.pairs_by_keys(flipped, order_num) do
      table.insert(inner, string.format('      "%d": { "%s": %d }', n, name, count))
      n = n + 1
    end

    table.insert(outer, table.concat(inner, ',\n') .. '\n    }')
    table.insert(buffer, table.concat(outer, '\n'))
  end

  return '  "keywords": {\n' .. table.concat(buffer, ',\n') .. '\n  }'
end

function render_titles(titles)
  local buffer = {}

  -- sort the keywords table and write it
  for docname, title in pairs(titles) do
    table.insert(buffer, string.format('    "%s": "%s"', docname, title))
  end

  return '  "titles": {\n' .. table.concat(buffer, ',\n') .. '\n  }'
end

function Doc(body, metadata, variables)
  local titles = {}
  local keywords = {}

  for k, v in pairs(meta) do
    -- get all of the document titles
    if v.title then
      titles[k] = stringify(v.title)
    end

    -- get all of the keywords
    if v.keywords then
      for word, count in pairs(v.keywords) do
        if not keywords[word] then
          keywords[word] = {}
        end

        keywords[word][k] = tonumber(stringify(count))
      end
    end
  end

  return 'var meta = {\n' .. render_titles(titles) ..
    ',\n' .. render_keywords(keywords) .. '\n}'
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
