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
      trig = '(%S+%b())%.([%w_]+)',
      regTrig = true,
      hidden = false,
    },
    fmt('{cond}{var}, {ok} := {expression}{cond2}', {
      cond = f(function(_, snip)
        return snip.captures[2]:sub(1, 2) == 'if' and snip.captures[2]:sub(1, 2) .. ' ' or ''
      end),
      var = i(1, 'v'),
      ok = f(function(_, snip)
        return snip.captures[2]:sub(1, 2) == 'if' and snip.captures[2]:sub(3, -1) or snip.captures[2]
      end),
      expression = f(function(_, snip)
        return snip.captures[1]
      end),
      cond2 = d(2, function(_, snip)
        return snip.captures[2]:sub(1, 2) == 'if'
            and sn(nil, fmt('; {condVar} {{\n\t{todo}\n}}', { condVar = snip.captures[2]:sub(3, -1), todo = i(1) }))
          or sn(nil, {})
      end),
    })
  ),
}
