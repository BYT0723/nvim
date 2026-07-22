-- stylua: ignore
local source_alias = {
	LSP       = 'LSP',
	Buffer    = 'BUF',
	Cmdline   = 'CMD',
	PATH      = 'PATH',
	Snippets  = 'SNIP',
	Norg      = 'NORG',
	LazyDev   = 'DEV',
	LuaSnip   = 'SNIP',
	Git       = 'GIT',
}

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
        -- align_to = 'cursor', -- label(default) / cursor / none
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'kind', 'source_name', gap = 1 },
        },
        components = {
          kind = {
            width = { fill = true },
            text = function(ctx)
              return string.lower(ctx.kind or '')
            end,
            highlight = function(ctx)
              return 'Comment'
            end,
          },
          source_name = {
            text = function(entry)
              return '[' .. (source_alias[entry.source_name] or entry.source_name) .. ']'
            end,
          },
        },
      },
      min_width = 30,
      border = 'none',
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = {
        border = 'none',
      },
    },
  },
  sources = {
    default = {
      'git',
      'neorg',
      'lazydev',
      'lsp',
      'snippets',
      'buffer',
      'path',
    },
    providers = {
      neorg = {
        name = 'Norg',
        module = 'blink.compat.source',
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
      git = {
        module = 'blink-cmp-git',
        name = 'Git',
        enabled = function()
          return vim.bo.filetype == 'gitcommit' or vim.bo.filetype == 'octo'
        end,
        opts = {},
      },
    },
  },
  signature = {
    enabled = true,
    trigger = {
      enabled = true,
      -- default: show_on_insert_on_trigger_character = true
      show_on_insert = true,
    },
    window = {
      show_documentation = true,
      border = 'none',
    },
  },
}
