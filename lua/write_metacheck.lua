-- invoke as Pandoc writer
-- write a report of metablock checks

-- This writer serves two purposes:
-- 1. Produce some kind of report that gives some information on the state of
--    all page items, particularly when page metadata is cross-referenced
-- 2. Output ERRORs to stderr. The current use-case is to halt a CI deployment
--    if there is a clear error in page content

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local agsman = require('agsman')

function get_valid_links(pagemeta, filepath)
  local valid = {}

  -- read explicitly approved links
  if filepath ~= nil then
    for line in io.lines(filepath) do
      if line:len() > 0 then
        valid[line] = true
      end
    end
  end

  -- read all valid link targets from pages
  for k, v in pairs(pagemeta) do
    valid[k] = true

    if v.index then
      for _, item in ipairs(v.index) do
        valid[k .. '#' .. item["id"]] = true
      end
    end
  end

  return valid
end

function get_bad_links(pagemeta, valid)
  local count = 0

  -- check all links
  for k, v in pairs(pagemeta) do
    if v.links then
      for link in pairs(v.links) do
        if valid[link] == nil then
          io.stderr:write(string.format("ERROR: unmatched link '%s' in page '%s'\n", link, k))
          count = count + 1
        end
      end
    end
  end

  return count
end

function get_editorial_collisions(pagemeta)
  local count = 0

  for k, v in pairs(pagemeta) do
    if v.index then
      local subheadings = {}

      for _, item in ipairs(v.index) do
        local name = item["header"]
        local itemtype = item["itemtype"]

        if itemtype == "editorial" then
          if subheadings[name] ~= nil then
            io.stderr:write(
              string.format("ERROR: Duplicate heading '%s' within editorial page '%s'\n",
                            name,
                            k))
            count = count + 1
          end

          subheadings[name] = true
        end
      end
    end
  end

  return count
end

function get_toplevel_collisions(pagemeta)
  local count = 0

  for k, v in pairs(pagemeta) do
    if v.index then
      local toplevel = {}

      for _, item in ipairs(v.index) do
        local name = item["header"]
        local itemtype = item["itemtype"]

        if itemtype == "editorial" and name ~= v.title then
          -- within editorial page sub-sections
          -- (do nothing - cross page collisions are allowed)
        else
          -- within script references and editorial headings
          -- (this is always a problem since this is a name collision within the CHM index)
          if toplevel[name] ~= nil then
            io.stderr:write(
              string.format("ERROR: Duplicate heading '%s' in %s page '%s'. First seen in page '%s'\n",
                            name,
                            itemtype,
                            k,
                            toplevel[name]))
            count = count + 1
          else
            toplevel[name] = k
          end
        end
      end
    end
  end

  return count
end

function Doc(body, metadata, variables)
  local pagemeta = {}

  for file in metadata._metafiles:gmatch('%S+') do
    pagemeta[file:match('([^/]+)%.lua$')] = dofile(file)
  end

  local valid_links = get_valid_links(pagemeta, metadata._approved_links)
  local buffer = {}
  table.insert(buffer,
               string.format(
                 "Broken links: %d",
                 get_bad_links(pagemeta, valid_links)))
  table.insert(buffer,
               string.format(
                 "Heading errors: %d",
                 get_toplevel_collisions(pagemeta) + get_editorial_collisions(pagemeta)))
  return table.concat(buffer, '\n')
end

local meta = {}
meta.__index =
  function(_, key)
    return function() return '' end
  end
setmetatable(_G, meta)
