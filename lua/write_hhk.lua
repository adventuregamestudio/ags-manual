local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>
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
  local mapfiles = meta.mapfiles
  local f = assert(io.open(meta.output, 'w'))

  for map in mapfiles:gmatch('%S+') do
    assert(file_exists(map))
    for line in io.lines(map) do
      f:write(format_line(line))
    end
  end

  f:close()
end
