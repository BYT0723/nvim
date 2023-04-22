local lspkind = require('lspkind')
local cmp = require('cmp')

package.path = package.path .. ';..\\?.lua;'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local options = {
  -- 指定 snippet 引擎
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  -- 窗体样式
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- 来源
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'crates' },
    { name = 'orgmode' },
  }),

  -- 快捷键
  mapping = require('keybindings').cmp(cmp),
  -- 使用lspkind-nvim显示类型图标
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = strings[1]
      kind.menu = strings[2]

      return kind
    end,
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

return options
