local options = {
  cmdline = {
    enabled = false, -- enables the Noice cmdline UI
  },
  messages = {
    enabled = false, -- enables the Noice messages UI
    view = 'mini', -- default view for messages
    view_error = 'notify', -- view for errors
    view_warn = 'notify', -- view for warnings
    view_history = 'messages', -- view for :messages
    view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
  },
  lsp = {
    progress = {
      enabled = true,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      --- @type NoiceFormat|string
      format = 'lsp_progress',
      --- @type NoiceFormat|string
      format_done = 'lsp_progress_done',
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = 'mini',
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
      -- override the lsp markdown formatter with Noice
      ['vim.lsp.util.stylize_markdown'] = false,
      -- override cmp documentation with Noice (needs the other options to work)
      ['cmp.entry.get_documentation'] = false,
    },
    hover = {
      enabled = true,
      view = nil, -- when nil, use defaults from documentation
    },
    signature = {
      enabled = true, -- have issue with plugin <lsp-signature>
      auto_open = {
        enabled = true,
        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce lsp signature help request by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
    },
    message = {
      -- Messages shown by lsp servers
      enabled = true,
      view = 'notify',
      opts = {},
    },
    -- defaults for hover and signature help
    documentation = {
      view = 'hover',
      ---@type NoiceViewOptions
      opts = {
        lang = 'markdown',
        replace = true,
        render = 'plain',
        format = { '{message}' },
        win_options = { concealcursor = 'n', conceallevel = 3 },
        position = { row = 2, col = 0 },
        border = 'rounded',
      },
    },
  },
  ---@type NoicePresets
  presets = {
    -- you can enable a preset by setting it to true, or a table that will override the preset config
    -- you can also add custom presets that you can enable/disable with enabled=true
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  ---@type NoiceConfigViews
  views = {
    cmdline_popup = {
      position = { row = '30%', col = '50%' },
      size = { width = '50%' },
    },
    mini = {
      position = { row = -2, col = '100%' },
      win_options = { winblend = 0 },
    },
  }, ---@see section on views
  ---@type NoiceRouteConfig[]
  routes = {}, --- @see section on routes
  ---@type table<string, NoiceFilter>
  status = {}, --- @see section on statusline components
  ---@type NoiceFormatOptions
  format = {}, --- @see section on formatting
}

return options
