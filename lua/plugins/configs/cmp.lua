-- stylua: ignore
local source_alias = {
  LSP      = 'LSP',
  Buffer   = 'BUF',
  Cmdline  = 'CMD',
  Emoji    = 'EMJ',
  PATH     = 'PATH',
  Snippets = 'SNIP',
  LuaSnip  = 'SNIP',
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
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
        components = {
          source_name = {
            text = function(entry)
              local short = source_alias[entry.source_name] or entry.source_name
              return '[' .. short .. ']'
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
    default = { 'neorg', 'lazydev', 'avante', 'emoji', 'lsp', 'snippets', 'buffer', 'path' },
    providers = {
      neorg = {
        name = 'neorg',
        module = 'blink.compat.source',
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
      avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {},
      },
      emoji = {
        module = 'blink-emoji',
        name = 'Emoji',
        score_offset = 15, -- Tune by preference
        opts = {
          insert = true, -- Insert emoji (default) or complete its name
          ---@type string|table|fun():table
          trigger = function()
            return { ':' }
          end,
        },
        should_show_items = function()
          return vim.tbl_contains({
            'gitcommit',
            'markdown',
          }, vim.o.filetype)
        end,
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
      show_documentation = false,
    },
  },
}
