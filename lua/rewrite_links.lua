-- invoke as Pandoc filter
-- append new output extension to link targets

assert(PANDOC_STATE.output_file ~= nil)
local newext, _ = string.match(PANDOC_STATE.output_file, "%.[^.]+$")
assert(#newext > 0)

-- if the result isn't html or html, force one of them based on the
-- file extension length
if newext ~= '.html' and newext ~= '.htm' then
  if #newext == 5 then
    newext = '.html'
  elseif #newext == 4 then
    newext = '.htm'
  end
end

function Link(elem)
  -- fast check for internal links
  if not string.find(elem.target, '.', 1, true) then
    local insert, count = string.gsub(elem.target, '#', newext .. '#', 1)

    if count == 0 then
      elem.target = elem.target .. newext
    else
      elem.target = insert
    end
  end

  return elem
end
