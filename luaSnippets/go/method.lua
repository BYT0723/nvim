local ls = require('luasnip')
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    {
      trig = '^meth',
      regTrig = true,
      hidden = false,
    },
    fmt('func ({var} {typ}) {name}({params}) {ret} {{\n\t{body}\n}}', {
      var = f(function(args, _)
        return ((args[1] and args[1][1]) or 't'):match('[a-zA-Z]'):lower()
      end, { 1 }),
      typ = i(1, 'T'),
      name = i(2, 'name'),
      params = i(3),
      ret = i(4),
      body = i(0),
    })
  ),
}
