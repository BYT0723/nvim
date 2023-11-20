local keymaps = require('plugins.keymaps')
local header = '\
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗\
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║\
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║\
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║\
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║\
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\
                                                      \
          [ May everyone not be alone ]               '

-- require('mini.completion').setup()

return {
  -- colorscheme
  {
    'echasnovski/mini.hues',
    enabled = false,
    version = false,
    init = function()
      vim.cmd([[colorscheme randomhue]])
    end,
  },
  {
    'echasnovski/mini.cursorword',
    -- 关闭原因：没有结合LSP分析
    enabled = false,
    version = false,
    opts = {
      delay = 500,
    },
  },
  -- starter UI
  {
    'echasnovski/mini.starter',
    version = false,
    opts = {
      header = header,
      items = {
        { name = 'Explorer', action = 'NvimTreeToggle', section = 'TOOLS' },
        { name = 'Finder', action = 'Telescope find_files', section = 'TOOLS' },
        { name = 'Plugin', action = 'Lazy', section = 'TOOLS' },
        { name = 'Configuration', action = 'Telescope find_files cwd=~/.config/nvim', section = 'SYSTEM' },
      },
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
    opts = {},
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
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<C-h>',
        right = '<C-l>',
        down = '<C-j>',
        up = '<C-k>',
      },
    },
  },
  -- show line tail space
  {
    'echasnovski/mini.trailspace',
    opts = {},
  },
  -- file manager
  {
    'echasnovski/mini.files',
    version = false,
    enabled = false,
    keys = keymaps.MiniFiles,
    opts = {
      windows = {
        max_number = math.huge,
        preview = true,
        width_preview = 30,
      },
    },
  },
  -- nvim session
  {
    'echasnovski/mini.sessions',
    version = false,
    enabled = false,
    keys = keymaps.MiniSession,
    opts = {},
  },
}
