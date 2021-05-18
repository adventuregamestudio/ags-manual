-- invoke as Pandoc writer
-- write Javascript file for website search functions and data

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')

function render_keywords(keywords)
  local buffer = {}
  local entry = {}

  -- sort the keywords table and write it
  for word, map in agsman.pairs_by_keys(keywords, function(a,b) return a < b end) do
    local outer = {}
    local inner = {}
    table.insert(outer, string.format('    "%s": {', word))

    if entry[word] == nil then
      entry[word] = 0
    end

    for name, count in agsman.pairs_by_keys(map, agsman.order_alpha) do
      table.insert(inner, string.format('      "%d": { "%s": %d }', entry[word], name, count))
      entry[word] = entry[word] + 1
    end

    table.insert(outer, table.concat(inner, ',\n') .. '\n    }')
    table.insert(buffer, table.concat(outer, '\n'))
  end

  return '  "keywords": {\n' .. table.concat(buffer, ',\n') .. '\n  }'
end

function render_titles(titles)
  local buffer = {}

  -- sort the titles table and write it
  for docname, title in agsman.pairs_by_keys(titles, agsman.order_alpha) do
    table.insert(buffer, string.format('    "%s": "%s"', docname, title))
  end

  return '  "titles": {\n' .. table.concat(buffer, ',\n') .. '\n  }'
end

function Doc(body, metadata, variables)
  local titles = {}
  local keywords = {}
  local pagemeta = {}

  for file in metadata._metafiles:gmatch('%S+') do
    pagemeta[file:match('([^/]+)%.lua$')] = dofile(file)
  end

  for k, v in pairs(pagemeta) do
    -- get all of the document titles
    if v.title then
      titles[k] = v.title
    end

    -- get all of the keywords
    if v.keywords then
      for word, count in pairs(v.keywords) do
        if not keywords[word] then
          keywords[word] = {}
        end

        keywords[word][k] = count
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
