-- common functions

-- https://www.lua.org/pil/19.3.html
function pairs_by_keys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
	i = i + 1
	if a[i] == nil then return nil
	else return a[i], t[a[i]]
	end
  end
  return iter
end

function escape(s)
  return s:gsub("[<>&\"']",
    function(x)
      if x == '<' then
        return '&lt;'
      elseif x == '>' then
        return '&gt;'
      elseif x == '&' then
        return '&amp;'
      elseif x == '"' then
        return '&quot;'
      elseif x == "'" then
        return '&#39;'
      else
        return x
      end
    end)
end

function order_alpha(a, b)
  return b:lower() > a:lower()
end

function serialize(o, d)
  if type(o) == "number" then
    return string.format("%d", o)
  elseif type(o) == "string" then
    return string.format("%q", o)
  elseif type(o) == "table" then
    local indent = (d or 0) + 1
    local buffer = {}
    table.insert(buffer, "{\n")
    for k,v in pairs_by_keys(o, order) do
      table.insert(buffer, string.format("%s[", string.rep("  ", indent)))
      table.insert(buffer, serialize(k, indent))
      table.insert(buffer, "] = ")
      table.insert(buffer, serialize(v, indent))
      table.insert(buffer, ",\n")
    end
    table.insert(buffer, string.rep("  ", indent - 1))
    table.insert(buffer, "}")
    return table.concat(buffer)
  else
    error("cannot serialize a " .. type(o))
  end
end

return {
  pairs_by_keys = pairs_by_keys,
  escape = escape,
  order_alpha = order_alpha,
  serialize = serialize
}
