local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    {
      trig = 'func ([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt(
      [[
func {name}({params}) {ret} {{
  {body}
}}
      ]],
      {
        name = f(function(_, snip)
          return snip.captures[1]
        end),
        params = i(1),
        ret = i(2),
        body = i(0),
      }
    )
  ),
  s(
    {
      trig = 'meth ([%w_*]+) ([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt(
      [[
func ({var} {typ}) {name}({params}) {ret} {{
  {body}
}}
      ]],
      {
        var = f(function(_, snip)
          local first_letter = snip.captures[1]:match('[a-zA-Z]') or 't'
          return first_letter:lower()
        end),
        typ = f(function(_, snip)
          return snip.captures[1]
        end),
        name = f(function(_, snip)
          return snip.captures[2]
        end),
        params = i(1),
        ret = i(2),
        body = i(0),
      }
    )
  ),
}
