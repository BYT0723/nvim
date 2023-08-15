local function Starter()
  local starter = require('mini.starter')
  starter.setup({
    header = '                                                       \
                                                                   \
             ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗\
             ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║\
             ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║\
             ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║\
             ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║\
             ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\
                                                                   \
                         [ May everyone not be alone ]             \
                                                                   \
                                                                   ',
          -- stylua: ignore
          items = {
            { name = 'Explorer',      action = 'lua require("mini.files").open()',        section = 'TOOLS' },
            { name = 'Finder',        action = 'Telescope find_files',                    section = 'TOOLS' },
            { name = 'Plugin',        action = 'Lazy',                                    section = 'TOOLS' },
            { name = 'Configuration', action = 'Telescope find_files cwd=~/.config/nvim', section = 'SYSTEM' },
          },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
end

function Init()
  -- Load the colorscheme
  vim.cmd([[colorscheme minicyan]])

  Starter()

  -- bufferline
  require('mini.tabline').setup()

  -- stautsline
  require('mini.statusline').setup({
    content = {
      active = nil,
      inactive = nil,
    },
    use_icons = true,
    set_vim_settings = true,
  })

  -- animation
  -- require('mini.animate').setup()

  -- indent
  vim.opt.list = false
  require('mini.indentscope').setup({
    mappings = {
      object_scope = 'ii',
      object_scope_with_border = 'ai',
      goto_top = '[i',
      goto_bottom = ']i',
    },
  })

  -- colors
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      -- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      -- hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      -- todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      -- note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- file manager
  require('mini.files').setup({
    windows = {
      max_number = math.huge,
      preview = true,
      width_preview = 30,
    },
  })
  require('mini.pairs').setup()
  require('mini.comment').setup()
  require('mini.surround').setup({
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
  })
  require('mini.splitjoin').setup({
    mappings = {
      toggle = 'gS',
      split = '',
      join = '',
    },
  })
  require('mini.move').setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<C-h>',
      right = '<C-l>',
      down = '<C-j>',
      up = '<C-k>',
    },
  })

  require('mini.jump').setup({})
  require('mini.jump2d').setup({
    mappings = {
      start_jumping = '<C-f>',
    },
  })

  require('mini.align').setup()

  require('mini.completion').setup()
end

return Init
