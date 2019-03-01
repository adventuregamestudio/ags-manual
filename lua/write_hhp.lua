local format = [[[OPTIONS]
Binary TOC=No
Binary Index=No
Compiled file=%s.chm
Contents file=%s.hhc
Default Window=%s
Default topic=index.html
Display compile progress=No
Full text search stop list file=%s.stp
Full-text search=Yes
Index file=%s.hhk
Language=0x409
Title=AGS Documentation

[WINDOWS]
%s="AGS Documentation","%s.hhc","%s.hhk","index.html","index.html",,,,,0x63520,220,0x10384e,[0,0,1024,768],,,,,,,0

[FILES]
]]

function Meta(meta)
  local incfiles = meta.incfiles
  local f = assert(io.open(meta.output, 'w'))
  f:write(string.format(format, meta.projectname, meta.projectname, meta.projectname,
    meta.projectname, meta.projectname, meta.projectname, meta.projectname, meta.projectname))

  for inc in incfiles:gmatch('%S+') do
    f:write(inc .. '\n')
  end

  f:close()
end
