function Link(elem)
  -- fast check for internal links
  if not string.find(elem.target, '.', 1, true) then
    local insert, count = string.gsub(elem.target, '#', '.html#', 1)

    if count == 0 then
      elem.target = elem.target .. '.html'
    else
      elem.target = insert
    end
  end

  return elem
end
