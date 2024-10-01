local lspkind = require('lspkind')
local cmp = require('cmp')

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local special_cfg = {
  cmdline = {
    {
      pattern = { '/', '?' },
      config = {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      },
    },
    {
      pattern = ':',
      config = {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      },
    },
  },
  filetype = {
    {
      ft = 'norg',
      config = {
        sources = cmp.config.sources({
          { name = 'neorg' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      },
    },
    {
      ft = 'toml',
      config = {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'crates' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      },
    },
    {
      ft = { 'sql', 'mysql', 'plsql' },
      config = {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vim-dadbod-completion' },
        }, {
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      },
    },
  },
}

for _, cfg in ipairs(special_cfg.cmdline) do
  cmp.setup.cmdline(cfg.pattern, cfg.config)
end

for _, cfg in ipairs(special_cfg.filetype) do
  cmp.setup.filetype(cfg.ft, cfg.config)
end

return {
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
    { name = 'nvim_lsp', max_item_count = 20 },
    { name = 'vsnip', max_item_count = 10 },
    { name = 'buffer', max_item_count = 10 },
    { name = 'path', max_item_count = 10 },
  }),

  -- 快捷键
  mapping = {
    ['<Tab>'] = function(fallback)
      return cmp.visible() and cmp.select_next_item() or fallback()
    end,
    ['<S-Tab>'] = function(fallback)
      return cmp.visible() and cmp.select_prev_item() or fallback()
    end,
    ['<C-j>'] = cmp.mapping(function()
      feedkey('<Plug>(vsnip-jump-next)', 'i')
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function()
      feedkey('<Plug>(vsnip-jump-prev)', 'i')
    end, { 'i', 's' }),

    -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-y>'] = cmp.config.disable,
    ['<C-u>'] = cmp.mapping.scroll_docs(-2),
    ['<C-d>'] = cmp.mapping.scroll_docs(2),
    ['<C-.>'] = cmp.mapping.complete(),
    ['<C-,>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },

  -- 使用lspkind-nvim显示类型图标
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.menu = vim_item.kind
        return vim_item
      end,
    }),
  },
}
