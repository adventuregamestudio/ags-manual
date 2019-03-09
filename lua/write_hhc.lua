package.path = package.path .. ';lua/agsman.lua'
local agsman = require('agsman')

local header = [[<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
<HEAD>
<meta name="GENERATOR" content="Microsoft&reg; HTML Help Workshop 4.1">
<!-- Sitemap 1.0 -->
</HEAD><BODY>
<OBJECT type="text/site properties">
        <param name="Window Styles" value="0x801227">
        <param name="ImageType" value="Folder">
</OBJECT>
<UL>
]]

local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Name" value="%s">
<param name="Local" value="%s">
</OBJECT>
]]

local footer = [[</UL></BODY></HTML>
]]

function Meta(meta)
  local contents = meta.contents
  assert(agsman.file_exists(contents))
  local pagename = contents:gsub('.*/(%w+)%.%w+$', '%1.html')
  local f = assert(io.open(meta.output, 'w'))
  f:write(header)

  local first = true
  local is_header

  for line in io.lines(contents) do
    is_header = line:sub(1, 1) == '#'

    if is_header then
      line = pagename .. line
    end

    local id, name = agsman.split_tsv(line)
    local formatted = string.format(format, name, id)

    if is_header then
      if not first then
        f:write('</UL>\n')
      end

      formatted = formatted .. '<UL>\n'
      first = false
    end

    f:write(formatted)
  end

  if not is_header then
    f:write('</UL>\n')
  end

  f:write(footer)
  f:close()
end
