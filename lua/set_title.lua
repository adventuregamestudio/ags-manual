-- invoke as Pandoc filter
-- set the metadata value 'title' based on the first level 2 header

local title

function Header(elem)
  if elem.level == 2 then
    -- save first heading to use as the page title
    if not title then
      title = pandoc.utils.stringify(elem)
    end
  end
end

function Meta(meta)
  if title then
    meta.title = title
  end

  return meta
end
