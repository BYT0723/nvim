local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    {
      trig = '(%S+%b())%.([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt('{cond}{var}, {ok} := {expression}{cond2}', {
      cond = f(function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return pfx .. ' '
        end
      end),
      var = i(1, 'v'),
      ok = f(function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return snip.captures[2]:sub(3, -1)
        else
          return snip.captures[2]
        end
      end),
      expression = f(function(_, snip)
        return snip.captures[1]
      end),
      cond2 = d(2, function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return sn(nil, { t('; ' .. snip.captures[2]:sub(3, -1) .. '{'), i(1), t('}') })
        end
      end),
    })
  ),
  s(
    {
      trig = '([%w_]+%[.+%])%.([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt('{cond}{var}, {ok} := {expression}{cond2}', {
      cond = f(function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return pfx .. ' '
        end
      end),
      var = i(1, 'v'),
      ok = f(function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return snip.captures[2]:sub(3, -1)
        else
          return snip.captures[2]
        end
      end),
      expression = f(function(_, snip)
        return snip.captures[1]
      end),
      cond2 = d(2, function(_, snip)
        local pfx = snip.captures[2]:sub(1, 2)
        if pfx == 'if' then
          return sn(nil, { t('; ' .. snip.captures[2]:sub(3, -1) .. '{'), i(1), t('}') })
        end
      end),
    })
  ),
  s(
    {
      trig = 'func ([%w_]+)',
      regTrig = true,
      hidden = false,
      name = 'func',
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
      name = 'meth',
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
