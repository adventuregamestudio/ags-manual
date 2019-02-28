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

function file_exists(file)
  local f = io.open(file, 'rb')
  if f then f:close() end
  return f ~= nil
end

function format_line(line)
  local read = {}

  for l in line:gmatch('[^\t]+') do
    read[#read+1] = l
  end

  assert(#read == 2)
  return string.format(format, read[2], read[1])
end

function Meta(meta)
  local mapfile = meta.mapfile
  assert(file_exists(mapfile))
  local f = assert(io.open(meta.output, 'w'))
  f:write(header)

  for line in io.lines(mapfile) do
    f:write(format_line(line))
  end

  f:write(footer)
  f:close()
end
