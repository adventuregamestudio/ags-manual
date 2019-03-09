local agsman = {}

function agsman.table_has_value(table, value, key)
  if not table[key] then
    return false
  end

  for k, v in pairs(table[key]) do
    if v == value then
      return true
    end
  end

  return false
end

function agsman.file_exists(file)
  local f = io.open(file, 'rb')

  if f then
    f:close()
  end

  return f ~= nil
end

-- https://www.lua.org/pil/19.3.html
function agsman.pairs_by_keys(t, f)
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

function agsman.split_tsv(line)
  local read = {}

  for l in line:gmatch('[^\t]+') do
    read[#read+1] = l
  end

  assert(#read == 2)
  return read[1], read[2]
end

return agsman
