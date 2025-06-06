local keymaps = require('plugins.keymaps')

return {
  {
    'echasnovski/mini.icons',
    version = false,
  },
  {
    'echasnovski/mini.files',
    version = false,
    keys = keymaps.MiniFiles,
    opts = {
      options = { permanent_delete = false },
    },
  },
  -- bufferline
  {
    'echasnovski/mini.tabline',
    version = false,
    opts = {},
  },
  -- statusline
  {
    'echasnovski/mini.statusline',
    version = false,
    opts = {
      content = {
        active = function()
          local MiniStatusline = require('mini.statusline')
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          -- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local filename = vim.bo.filetype == 'snacks_terminal' and '%t'
            or require('base.util').relative_path() .. '%m%r'
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local has_noice, noice = pcall(require, 'noice')
          local has_kulala, kulala = pcall(require, 'kulala')
          local has_neocodeium, neocodeium = pcall(require, 'neocodeium')
          local codeium_status = '' -- 默认未知状态
          if has_neocodeium then
            local status, server_status = neocodeium.get_status()
            local status_icons = {
              [0] = '', -- 启用
              [5] = '', -- 编码不支持
              [6] = '󰆓', -- 特殊 buffer
              default = '󰂭', -- 其他禁用状态
            }
            local server_icons = {
              [0] = nil, -- 运行中 → 不覆盖插件状态图标
              [1] = '󱘖', -- 连接中
              [2] = '󰅖', -- 已停止
            }
            codeium_status = server_icons[server_status] or status_icons[status] or status_icons.default
          end

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            has_noice and { strings = { noice.api.status.command.get() } }, -- noice statusline command
            has_noice and { hl = mode_hl, strings = { noice.api.status.mode.get() } }, -- noice statusline mode (eg: recording)
            (vim.bo.filetype == 'http' and has_kulala)
              and { hl = 'MiniStatuslineModeOther', strings = { '🐼', kulala.get_selected_env() } }, -- kulala environment
            has_neocodeium and { hl = 'MiniStatuslineInactive', strings = { '󰚩 ', codeium_status } }, -- neocodeium status
            { hl = 'CurSearch', strings = { search } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { location } },
          })
        end,
      },
    },
  },
  -- autopairs
  {
    'echasnovski/mini.pairs',
    version = false,
    opts = {},
  },
  -- comment
  {
    'echasnovski/mini.comment',
    version = false,
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  -- hex colors display
  {
    'echasnovski/mini.hipatterns',
    version = false,
    config = function()
      require('mini.hipatterns').setup({
        highlighters = {
          -- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          -- hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          -- todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          -- note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })
    end,
  },
  -- quick jump
  {
    'echasnovski/mini.jump',
    version = false,
    opts = {},
  },
  -- use 2d replace quick jump
  {
    'echasnovski/mini.jump2d',
    version = false,
    opts = {
      mappings = {
        start_jumping = 'gf',
      },
    },
  },
  -- text align
  {
    'echasnovski/mini.align',
    version = false,
    opts = {},
  },
  -- surround text
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
  },
  -- toggle body
  {
    'echasnovski/mini.splitjoin',
    version = false,
    opts = {
      mappings = {
        toggle = 'gS',
        split = '',
        join = '',
      },
    },
  },
  -- move code block
  {
    'echasnovski/mini.move',
    versiont = false,
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    },
  },
  -- show line tail space
  {
    'echasnovski/mini.trailspace',
    version = false,
    event = 'BufReadPost',
    opts = {},
  },
}
