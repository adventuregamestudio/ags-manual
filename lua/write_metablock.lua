-- invoke as Pandoc writer
-- write YAML metadata file for later processing

package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')
local stringify = (require 'pandoc.utils').stringify

local keywords = {
  ['a'] = false,
  ['and'] = false,
  ['are'] = false,
  ['as'] = false,
  ['at'] = false,
  ['be'] = false,
  ['but'] = false,
  ['by'] = false,
  ['for'] = false,
  ['if'] = false,
  ['in'] = false,
  ['into'] = false,
  ['is'] = false,
  ['it'] = false,
  ['near'] = false,
  ['no'] = false,
  ['not'] = false,
  ['of'] = false,
  ['on'] = false,
  ['or'] = false,
  ['such'] = false,
  ['that'] = false,
  ['the'] = false,
  ['their'] = false,
  ['then'] = false,
  ['there'] = false,
  ['these'] = false,
  ['they'] = false,
  ['this'] = false,
  ['to'] = false,
  ['was'] = false,
  ['will'] = false,
  ['with'] = false
}

local links = {}

function Link(s, src, title)
  -- track all link targets
  links[src] = (links[src] or 0) + 1
  return ''
end

function Space()
  return ' '
end

function Str(s)
  add_word(s)
  return s
end

function Code(s, attr)
  for word in s:gmatch('%S+') do
    add_word(word)
  end
  return s
end

function CodeBlock(s, attr)
  for word in s:gmatch('%S+') do
    add_word(word)
  end
  return s
end

function add_word(word)
  local chars = '%w'
  local first = word:sub(1, 1)
  local last = word:sub(-1)

  -- preserve ' in the middle of the word
  if first ~= "'" and last ~= "'" then
    chars = chars .. "'"
  end

   -- preserve - in the middle of the word
  if first ~= '-' and last ~= '-' then
    chars = chars .. '-'
  end

  -- split on non-word characters
  for w in word:gmatch('[' .. chars .. ']+') do
    if w:len() > 1 and not w:match('%d') then
      if keywords[w:lower()] ~= false then
        keywords[w] = (keywords[w] or 0) + 1
      end
    end
  end
end

function Doc(body, metadata, variables)
  local blocks = PANDOC_DOCUMENT.blocks
  local meta = PANDOC_DOCUMENT.meta
  local buffer = {}
  local index = {
    editorial = {},
    script = {}
  }

  -- order ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  table.insert(buffer, '  title: >')
  table.insert(buffer, '    ' .. (meta.title or meta.docname))

  for i, block in ipairs(blocks) do
    -- check each header for inline code
    if block.t == "Header" then
      local header = nil
      local itemtype = nil

      for i, child in ipairs(block.content) do
        -- take the first match and stop checking
        if child.t == "Code" then
          header = child.text
          break
        end
      end

      if header then
        -- heading was describing some code
        itemtype = 'script'
      else
        -- if no code matched just convert to a string
        itemtype = 'editorial'
        header = stringify(block)
      end

      assert(itemtype == 'editorial' or itemtype == 'script')

      -- emit warnings for heading collisions within this page
      -- (since storing data with keys will mask later checks)
      for k, v in pairs(index) do
        if v[header] ~= nil then
          io.stderr:write(string.format("WARNING: duplicate header %s\n", header))
        end
      end

      index[itemtype][header] = block.attr.identifier
    end
  end

  table.insert(buffer, '\n  index:')

  for itemtype, item in agsman.pairs_by_keys(index, order) do
    table.insert(buffer, string.format("    %s:", itemtype))

    for name, id in agsman.pairs_by_keys(item, order) do
      table.insert(buffer, string.format("      %s: %s", name, id))
    end
  end

  table.insert(buffer, '\n  links:')

  for link, count in agsman.pairs_by_keys(links, order) do
    table.insert(buffer, string.format("    %s: %d", link, count))
  end

  table.insert(buffer, '\n  keywords:')

  for word, count in agsman.pairs_by_keys(keywords, order) do
    if count ~= false then
      table.insert(buffer, string.format("    %s: %d", word, count))
    end
  end

  return '---\n' .. meta.docname .. ':\n' .. table.concat(buffer, '\n') .. '\n---\n'
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
