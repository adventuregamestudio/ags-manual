-- invoke as Pandoc writer
-- write a contents file for the CHM compiler

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')
local header = nil
local format = [[<OBJECT type="text/sitemap">
<param name="Name" value="%s">
<param name="%s" value="%s">
</OBJECT>]]

function Doc(body, metadata, variables)
  return body
end

function Blocksep()
  return ''
end

function Plain(s)
  return s
end

function Space()
  return ' '
end

function Str(s)
  return agsman.escape(s)
end

function Header(lev, s, attr)
  if lev ~= 1 then
    header = { [attr.id] = s }
  end

  return ''
end

function BulletList(items)
  assert(header)
  local buffer = {}

  for id, name in pairs(header) do
    table.insert(buffer, '<LI> ' .. string.format(format, name, 'Comment', id) .. '\n<UL>\n')
  end

  for _, item in pairs(items) do
    table.insert(buffer, '<LI> ' .. item)
  end

  return '<UL>\n' .. table.concat(buffer, '\n') .. '\n</UL>\n</UL>\n'
end

function Link(s, src, tit, attr)
  return string.format(format, s, 'Local', agsman.escape(src))
end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Dropping contents element '%s'\n", key))
    return function() return '' end
  end
setmetatable(_G, meta)
