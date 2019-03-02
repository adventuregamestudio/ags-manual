local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Keyword" value="%s">
<param name="Local" value="%s">
</OBJECT>
]]

local indices = {}

function file_exists(file)
  local f = io.open(file, 'rb')
  if f then f:close() end
  return f ~= nil
end

function split_line(line)
  local read = {}

  for l in line:gmatch('[^\t]+') do
    read[#read+1] = l
  end

  assert(#read == 2)
  return read[1], read[2]
end

-- https://www.lua.org/pil/19.3.html
function pairs_by_keys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
	i = i + 1
	if a[i] == nil then return nil
	else return a[i], t[a[i]]
	end
  end
  return iter
end

function Meta(meta)
  local mapfiles = meta.mapfiles

  for map in mapfiles:gmatch('%S+') do
    assert(file_exists(map))
    for line in io.lines(map) do
      local id, name = split_line(line)
      indices[name] = id
    end
  end

  -- sort alphabetically ignoring case
  order = function(a, b)
    return b:lower() > a:lower()
  end

  local f = assert(io.open(meta.output, 'w'))

  for name, id in pairs_by_keys(indices, order) do
    f:write(string.format(format, name, id))
  end

  f:close()
end
