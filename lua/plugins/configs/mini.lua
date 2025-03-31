local header = '\
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗\
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║\
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║\
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║\
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║\
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\
                                                      \
          [ May everyone not be alone ]               '

return {
  {
    'echasnovski/mini.icons',
    version = '*',
  },
  -- starter UI
  {
    'echasnovski/mini.starter',
    version = '*',
    opts = {
      header = header,
      items = {
        {
          name = 'New File',
          action = function()
            vim.ui.input({ prompt = ' ' .. vim.fn.getcwd() .. '/' }, function(input)
              if not input or input == '' then
                vim.notify('invalid path', vim.log.levels.ERROR)
                return
              end
              local full_path = vim.fn.fnamemodify(input, ':p')
              if vim.fn.isdirectory(full_path) == 1 then
                vim.notify('already exists directory [' .. full_path .. ']', vim.log.levels.ERROR)
              elseif vim.fn.filereadable(full_path) == 1 then
                vim.ui.input({ prompt = 'File Exists, Open(y/n)' }, function(flag)
                  if flag == 'y' then
                    vim.cmd('edit ' .. full_path)
                  end
                end)
              else
                vim.cmd('edit ' .. full_path)
              end
            end)
          end,
          section = 'Guide',
        },
        { name = 'Recent Files', action = 'Telescope oldfiles', section = 'Guide' },
        { name = 'Recent Projects', action = 'Telescope projects', section = 'Guide' },
        -- TOOLS
        { name = 'Explorer', action = 'NvimTreeToggle', section = 'Tools' },
        { name = 'Finder', action = 'Telescope find_files', section = 'Tools' },
        { name = 'Plugin', action = 'Lazy', section = 'Tools' },
        -- SYSTEM
        { name = 'Configuration', action = 'Telescope find_files cwd=~/.config/nvim', section = 'System' },
      },
    },
  },
  -- bufferline
  {
    'echasnovski/mini.tabline',
    version = '*',
    opts = {},
  },
  -- statusline
  {
    'echasnovski/mini.statusline',
    version = '*',
    dependencies = { 'folke/noice.nvim' },
    config = function()
      local MiniStatusline = require('mini.statusline')
      MiniStatusline.setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })
            local has_noice, noice = pcall(require, 'noice')
            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              has_noice and { strings = { noice.api.status.command.get() } }, -- noice statusline command
              has_noice and { hl = mode_hl, strings = { noice.api.status.mode.get() } }, -- noice statusline mode (eg: recording)
              vim.bo.filetype == 'http' and { hl = mode_hl, strings = { '', require('kulala').get_selected_env() } }, -- kulala environment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            })
          end,
          inactive = function()
            return MiniStatusline.combine_groups({
              { strings = { vim.bo.buftype == 'terminal' and '%t' or '%f%m%r' } },
            })
          end,
        },
        use_icons = true,
        set_vim_settings = true,
      })
    end,
  },
  -- autopairs
  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {},
  },
  -- comment
  {
    'echasnovski/mini.comment',
    version = '*',
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
    version = '*',
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
    version = '*',
    opts = {},
  },
  -- use 2d replace quick jump
  {
    'echasnovski/mini.jump2d',
    version = '*',
    opts = {
      mappings = {
        start_jumping = 'gf',
      },
    },
  },
  -- text align
  {
    'echasnovski/mini.align',
    version = '*',
    opts = {},
  },
  -- surround text
  {
    'echasnovski/mini.surround',
    version = '*',
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
    version = '*',
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
    versiont = '*',
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    },
  },
  -- show line tail space
  {
    'echasnovski/mini.trailspace',
    opts = {},
  },
}
