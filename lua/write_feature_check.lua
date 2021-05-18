-- invoke as Pandoc writer
-- test for required features

-- list:insert appears in Pandoc 2.9.2
local list = pandoc.List({1, 2, 4})
list:insert(3, 3)

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
