--invoke as custom writer

function Doc(body, metadata, variables)
  local buffer = {}

  for inc in metadata.incfiles:gmatch('%S+') do
    table.insert(buffer, inc)
  end

  return table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
