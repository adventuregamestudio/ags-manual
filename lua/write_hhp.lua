-- invoke as Pandoc writer
-- write a project file for the CHM compiler

Writer = pandoc.scaffolding.Writer

Writer.Inline.Str = function(str)
  return str.text
end

Writer.Inline.Space = function()
  return ' '
end

Writer.Pandoc = function(doc)
  local buffer = {}

  for inc in doc.meta.incfiles:gmatch('%S+') do
    table.insert(buffer, inc)
  end

  return table.concat(buffer, '\n')
end
