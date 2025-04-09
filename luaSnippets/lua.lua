local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    {
      trig = 'fn([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt(
      [[
---@type fun({args}){ret}
function {name}({params})
  {body}
end
      ]],
      {
        args = i(1, ''),
        ret = i(2, ''),
        name = f(function(_, snip)
          return snip.captures[1]
        end),
        params = f(function(args)
          local argstr = args[1][1]
          local params = {}
          for name in argstr:gmatch('([%w_]+)%s*:[^,%)]*') do
            table.insert(params, name)
          end
          return table.concat(params, ', ')
        end, { 1 }),
        body = i(0),
      }
    )
  ),
}
