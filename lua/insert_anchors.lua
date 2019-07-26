-- invoke as Pandoc filter
-- replace H2 or H3 content with an anchor link to itself
-- (this is for manual linking and not related to indexing)

local List = require 'pandoc.List'

function Header(elem)
  if elem.level == 2 or elem.level == 3 then
    local link = pandoc.Link(elem.content, '#' .. elem.identifier)
    elem.content = List:new({link})
    return elem
  end
end
