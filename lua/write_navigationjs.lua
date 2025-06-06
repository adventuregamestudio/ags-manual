-- invoke as Pandoc writer
-- write a contents file for the website

package.path = package.path .. ';' ..
  string.gsub(PANDOC_SCRIPT_FILE, '/[^/]+$', '') .. '/agsman.lua'
local escape = require('agsman').escape
local stringify = (require 'pandoc.utils').stringify
local formatTop = [[<li><span><a id="topic-%s">%s</span></a>]]
local formatSub = [[<li><span><a id="topic-%s" href="%s.html">%s</span></a>]]

Writer = pandoc.scaffolding.Writer

local buffer = {}
local depth = 1
Writer.Pandoc = function(doc)
  doc:walk {
    traverse = 'topdown',
    Header = function(header)
      if header.level > 1 then
        local name = escape(stringify(header.content))
        local id = header.identifier
        table.insert(buffer,
                     '<ul class="level-0">\n' ..
                     string.format(formatTop, id, name) ..
                     '\n<ul class="level-1">')
      end
    end,
    BulletList = function(bulletlist)
      bulletlist:walk {
        traverse = 'topdown',
        Link = function(link)
          local name = escape(stringify(link.content))
          local target = escape(link.target)
          table.insert(buffer,
                       string.format(formatSub, target, target, name))
        end, 
        BulletList = recurseBulletList
      }
      table.insert(buffer, '</li></ul>\n</li>\n</ul>')
      return _, false
    end
  }
  return 'var topics = `' .. table.concat(buffer, '\n') .. '`;'
end

function recurseBulletList(bulletlist)
  depth = depth + 1
  table.insert(buffer, '<ul class="level-'.. depth ..'">')
  bulletlist:walk {
    traverse = 'topdown',
    Link = function(link)
      local name = escape(stringify(link.content))
      local target = escape(link.target)
      table.insert(buffer,
                   string.format(formatSub, target, target, name))
    end,
    BulletList = recurseBulletList
  }
  table.insert(buffer, '</ul>\n')
  depth = depth - 1
  return bulletlist, false

end
