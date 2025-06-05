return {
  cmdline = {
    completion = {
      menu = { auto_show = true },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },
  enabled = function()
    return not vim.tbl_contains({ 'DressingInput' }, vim.bo.filetype)
      and vim.bo.buftype ~= 'prompt'
      and vim.b.completion ~= false
  end,
	-- stylua: ignore
	keymap = {
		preset = 'none',
		['<Tab>']   = { 'select_next',               'fallback' },
		['<S-Tab>'] = { 'select_prev',               'fallback' },
		['<CR>']    = { 'accept',                    'fallback' },
		['<C-j>']   = { 'snippet_forward',           'fallback' },
		['<C-k>']   = { 'snippet_backward',          'fallback' },
		['<C-u>']   = { 'scroll_documentation_up',   'fallback' },
		['<C-d>']   = { 'scroll_documentation_down', 'fallback' },
	},
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = {
      draw = {
        align_to = 'cursor', -- or 'none' to disable, or 'cursor' to align to the cursor
        columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'source_name' } },
        components = {
          source_name = {
            highlight = 'Comment',
            text = function(entry)
              return '[' .. entry.source_name .. ']'
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
    },
  },
  sources = {
    default = { 'avante', 'lsp', 'snippets', 'buffer', 'path' },
    providers = {
      avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {},
      },
    },
  },
  signature = {
    enabled = true,
  },
}
