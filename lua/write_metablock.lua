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

function add_word(keywords, word)
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

function Writer(doc)
  local index = {}
  local key = nil
  local keywords = {}
  local links = {}
  local title = nil

  doc:walk {
    Meta = function(meta)
      key = meta.docname
      title = meta.title or meta.docname
    end,
    Header = function(header)
      local name = nil
      local itemtype = nil

      header:walk {
        Code = function(code)
          name = name or code.text
        end
      }

      if name then
        -- heading was describing some code
        itemtype = 'script'
      else
        -- if no code matched just convert to a string
        itemtype = 'editorial'
        name = stringify(header.content)
      end

      assert(name:len() > 0)
      table.insert(index,
                   { header = name,
                     itemtype = itemtype,
                     id = header.identifier })
    end,
    Code = function(code)
      for word in code.text:gmatch('%S+') do
        add_word(keywords, word)
      end
    end,
    CodeBlock = function(codeblock)
      for word in codeblock.text:gmatch('%S+') do
        add_word(keywords, word)
      end
    end,
    Str = function(str)
      add_word(keywords, str.text)
    end,
    Link = function(link)
      links[link.target] = (links[link.target] or 0) + 1
    end
  }

  assert(key:len() > 0)
  return string.format('["%s"] = %s,',
                       key,
                       serialize({ index = index,
                                   keywords = keywords,
                                   links = links,
                                   title = title }))
end
