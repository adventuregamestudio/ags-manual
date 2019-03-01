headers = {}
links = {}
section = 0

get_links = {
  Link = function(elem)
    if not links[section] then
      links[section] = {}
    end

    links[section][#links[section]+1] = {
      [elem.target] = pandoc.utils.stringify(elem) }
  end
}

get_contents = {
  Header = function(elem)
    if elem.level ~= 1 then
      headers[#headers+1] = {
      ['#' .. elem.attr.identifier] = pandoc.utils.stringify(elem) }
    end
  end,

  BulletList = function(elem)
    section = section + 1
    pandoc.walk_block(elem, get_links)
  end
}

function Pandoc(elem, meta)
  pandoc.walk_block(pandoc.Div(elem.blocks), get_contents)

  if #links > 0 and #links == #headers then
    local filename = PANDOC_STATE.output_file:gsub('%.%w+$', '.contents')
    local format = '%s\t%s\n'
    local f = assert(io.open(filename, 'w'))

    for horder, header in ipairs(headers) do
      for href, name in pairs(header) do
        f:write(string.format(format, href, name))
      end

      for lorder, link in ipairs(links[horder]) do
        for href, name in pairs(link) do
          f:write(string.format(format, href, name))
        end
      end
    end

    f:close()
  end
end
