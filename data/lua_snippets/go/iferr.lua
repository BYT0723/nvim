local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    {
      trig = '(.+)%.iferr(%d*)',
      regTrig = true,
      hidden = false,
    },
    d(1, function(_, snip)
      local n = tonumber(snip.captures[2]) or 0
      local raw = snip.captures[1] or ''
      local indent = raw:match('^(%s*)')
      local expr = raw:match('^%s*(.*)')
      if n == 0 then
        return sn(
          nil,
          fmt('{indent}if {err} := {expression}; {err} != nil {{\n{indent}\t{todo}\n{indent}}}', {
            indent = f(function()
              return indent
            end),
            err = f(function()
              return 'err'
            end),
            expression = f(function()
              return expr
            end),
            todo = i(1),
          })
        )
      end
      local var_nodes = {}
      local var_placeholders = {}
      for k = 1, n do
        local name = 'v' .. k
        var_placeholders[k] = '{' .. name .. '}'
        var_nodes[name] = i(k, k == 1 and 'v' or name)
      end
      local template = '{indent}if '
        .. table.concat(var_placeholders, ', ')
        .. ', {err} := {expression}; {err} != nil {{\n{indent}\t{todo}\n{indent}}}'
      local nodes = {
        indent = f(function()
          return indent
        end),
        err = f(function()
          return 'err'
        end),
        expression = f(function()
          return expr
        end),
        todo = i(n + 1),
      }
      for name, node in pairs(var_nodes) do
        nodes[name] = node
      end
      return sn(nil, fmt(template, nodes))
    end)
  ),
}
