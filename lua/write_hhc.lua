-- invoke as Pandoc writer
-- write a contents file for the CHM compiler

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local escape = require('agsman').escape
local stringify = (require 'pandoc.utils').stringify
local format = [[<LI> <OBJECT type="text/sitemap">
<param name="Name" value="%s">
<param name="%s" value="%s">
</OBJECT>]]

Writer = pandoc.scaffolding.Writer

Writer.Pandoc = function(doc)
  buffer = {}

  doc:walk {
    traverse = 'topdown',
    Header = function(header)
      if header.level > 1 then
        local name = escape(stringify(header.content))
        local id = header.identifier
        table.insert(buffer,
                     '<UL>\n' ..
                     string.format(format, name, 'Comment', id)
                     .. '\n<UL>\n')
      end
    end,
    BulletList = function(bulletlist)
      bulletlist:walk {
        Link = function(link)
          local name = escape(stringify(link.content))
          local target = escape(link.target)
          table.insert(buffer,
                       string.format(format, name, 'Local', target))
        end
      }
      table.insert(buffer, '</UL>\n</UL>')
    end
  }

  return table.concat(buffer, '\n')
end
