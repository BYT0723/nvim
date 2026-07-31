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
      trig = '(.+)%.err(%d*)',
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
          fmt('{indent}{err} := {expression}', {
            indent = f(function()
              return indent
            end),
            err = f(function()
              return 'err'
            end),
            expression = f(function()
              return expr
            end),
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
      }
      for name, node in pairs(var_nodes) do
        nodes[name] = node
      end
      return sn(nil, fmt('{indent}' .. table.concat(var_placeholders, ', ') .. ', {err} := {expression}', nodes))
    end)
  ),
}
