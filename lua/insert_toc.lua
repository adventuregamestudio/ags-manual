-- invoke as Pandoc filter
-- inserts a local table of contents above or below the first heading

local headings = {}
local first_level = nil
local insert_above = false

function Header(elem)
  -- work out if the TOC should be before or after the first heading
  if first_level == nil then
    first_level = elem.level
  elseif elem.level <= first_level then
    insert_above = true
  end

  table.insert(headings, {
    level=elem.level,
    content=elem.content,
    identifier=elem.identifier
  })
end

function build_toc(toc_headings, i)
  i = i or 1
  local toc = {}
  local start = i

  while i <= #toc_headings do
    h = toc_headings[i]
    local link = pandoc.Link(h.content, '#' .. h.identifier)
    local plain = pandoc.Plain(link)
    local next_level = nil
    i = i + 1

    -- check next heading
    if i <= #toc_headings then
      next_level = toc_headings[i].level
    end

    -- check for higher level
    if next_level ~= nil and next_level > h.level then
      local added, subtoc = build_toc(toc_headings, i)
      i = i + added
      table.insert(toc, {plain, subtoc})
    else
      table.insert(toc, {plain})

      -- check for lower level
      if (next_level or 0) < h.level then
        break
      end
    end
  end

  return i - start, pandoc.BulletList(toc)
end

function Pandoc(doc)
  local meta = doc.meta
  local blocks = doc.blocks
  local toc_headings = {}

  -- filter headings to remove the unwanted ones
  if #headings > 0 then
    for _, h in ipairs(headings) do
      -- skip items at the level of the first header if the TOC is going
      -- underneath that header
      if insert_above or first_level ~= h.level then
        table.insert(toc_headings, h)
      end
    end
  end

  -- only looking to insert TOC if there is something to add, and only if:
  --   - there is at least one entry if the TOC is going under the first heading
  --   - or there are at least two entries if the TOC is going above the first
  --     heading, since the first heading will be included
  if #toc_headings > 0 and (not insert_above or #toc_headings > 1) then
    -- find first heading
    local _, insert_at = blocks:find_if(function(b) return b.level ~= nil end)
    -- this should always an integer less than the number of blocks
    assert(insert_at ~= nil and insert_at < #blocks)
    -- based on selection criteria the operation is always an insert and never
    -- an extend, because the target heading can never be the final block
    if not insert_above then
      insert_at = insert_at + 1
    end

    local _, toc = build_toc(toc_headings)
    blocks:insert(insert_at, toc)
  end

  return pandoc.Pandoc(blocks, meta)
end
