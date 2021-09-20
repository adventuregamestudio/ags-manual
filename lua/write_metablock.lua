-- invoke as Pandoc writer
-- write lua metadata file for later processing

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')
local serialize = agsman.serialize
local stringify = (require 'pandoc.utils').stringify

local skipwords = {
  ['a'] = true,
  ['and'] = true,
  ['are'] = true,
  ['as'] = true,
  ['at'] = true,
  ['be'] = true,
  ['but'] = true,
  ['by'] = true,
  ['for'] = true,
  ['if'] = true,
  ['in'] = true,
  ['into'] = true,
  ['is'] = true,
  ['it'] = true,
  ['near'] = true,
  ['no'] = true,
  ['not'] = true,
  ['of'] = true,
  ['on'] = true,
  ['or'] = true,
  ['such'] = true,
  ['that'] = true,
  ['the'] = true,
  ['their'] = true,
  ['then'] = true,
  ['there'] = true,
  ['these'] = true,
  ['they'] = true,
  ['this'] = true,
  ['to'] = true,
  ['was'] = true,
  ['will'] = true,
  ['with'] = true
}

local keywords = {}
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
      if skipwords[w:lower()] == nil then
        keywords[w] = (keywords[w] or 0) + 1
      end
    end
  end
end

function Doc(body, metadata, variables)
  local pagemeta = {
    links = links,
    keywords = keywords,
    title = (metadata.title or metadata.docname),
    index = {}
  }

  for i, block in ipairs(PANDOC_DOCUMENT.blocks) do
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

      assert(header:len() > 0)
      table.insert(pagemeta["index"],
                   { header = header,
                     itemtype = itemtype,
                     id = block.attr.identifier })
    end
  end

  return string.format('-- %s\n\nreturn %s', metadata.docname, serialize(pagemeta))
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
