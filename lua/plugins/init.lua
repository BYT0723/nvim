local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local keymaps = require('plugins.keymaps')

require('lazy').setup({
  -- base or lib
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- gui
  { 'MunifTanjim/nui.nvim', lazy = true },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  -- Wrap the input and select of vim.ui
  { 'stevearc/dressing.nvim', event = 'VeryLazy', opts = {} },
  -- UI美化
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    keys = keymaps.Noice,
    opts = require('plugins.configs.noice'),
  },

  -- A series of mini.nvim plugins
  require('plugins.configs.mini'),

  -- colorscheme
  {
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = {
      transparent = not vim.g.neovide,
      styles = {
        style = 'storm', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        light_style = 'day', -- The theme is used when the background is set to light
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variable = {},
        sidebars = 'dark', -- style for sidebars, see below
        floats = not vim.g.neovide and 'transparent' or 'dark', -- style for floating windows
      },
      sidebars = { 'qf' },
      on_colors = function(colors) end,
      on_highlights = function(hl, c)
        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = c.hint,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.NoiceCmdlinePopup = {
          bg = prompt,
        }
        local title = {
          bg = prompt,
          fg = prompt,
          -- fg = c.hint,
        }
        local border = {
          bg = prompt,
          fg = prompt,
        }
        hl.NoiceCmdlinePopupTitleCmdline = title
        hl.NoiceCmdlinePopupTitleSearch = title
        hl.NoiceCmdlinePopupTitleLua = title
        hl.NoiceCmdlinePopupTitleHelp = title
        hl.NoiceCmdlinePopupTitleInput = title
        hl.NoiceCmdlinePopupBorderCmdline = border
        hl.NoiceCmdlinePopupBorderSearch = border
        hl.NoiceCmdlinePopupBorderLua = border
        hl.NoiceCmdlinePopupBorderHelp = border
        hl.NoiceCmdlinePopupBorderInput = border
        hl.LspInlayHint = {
          fg = '#545c7e',
        }
        hl.WhichKeyBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.WhichKeyTitle = {
          bg = c.hint,
          fg = c.bg_dark,
        }
        hl.BlinkCmpMenu = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
      end,
    },
  },
  -- notify
  {
    'rcarriga/nvim-notify',
    keys = keymaps.Notify,
    init = function()
      vim.notify = require('notify')
    end,
    opts = {
      render = 'wrapped-compact', -- default / minimal / simple / compact / wrapped-compact
      stages = 'fade_in_slide_out', -- fade_in_slide_out / fade / slide / static
      timeout = 5000,
      fps = 60,
    },
  },
  -- keyword highlight
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetypes_denylist = { 'NvimTree', 'Trouble', 'Dashboard', 'toggleterm' },
      delay = 500,
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
  -- tree file manager
  {
    'nvim-tree/nvim-tree.lua',
    keys = keymaps.NvimTree,
    cmd = { 'NvimTreeToggle' },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = function()
      return require('plugins.configs.nvim-tree')
    end,
  },

  -- indent blank line
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      whitespace = {
        remove_blankline_trail = true,
      },
      indent = {
        char = '╎',
      },
      exclude = {
        filetypes = { 'lspinfo', 'mason', 'lazy', 'checkhealth', 'help', 'man', '' },
      },
      scope = {
        show_start = false,
        show_end = false,
        highlight = { 'Function', 'Label' },
      },
    },
  },
  -- terminal
  { 'akinsho/toggleterm.nvim', opts = { open_mapping = [[<c-\>]] } },
  -- git style, including blame, modify tags
  { 'lewis6991/gitsigns.nvim', opts = require('plugins.configs.gitsigns') },
  -- 错误统计
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = keymaps.Trouble,
    opts = {
      auto_jump = { 'lsp_definitions', 'lsp_type_definitions', 'lsp_implementations', 'lsp_references' }, -- for the given modes, automatically jump if there is only a single result
    },
  },
  -- todo comment
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    keys = keymaps.TodoComments,
    opts = {},
  },
  -- search and replace
  {
    'nvim-pack/nvim-spectre',
    keys = keymaps.Spectre,
    opts = {},
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    keys = keymaps.Diffview,
    opts = {},
  },
  -- translator
  {
    'potamides/pantran.nvim',
    cmd = 'Pantran',
    keys = keymaps.PanTran,
    opts = {
      default_engine = 'google',
      engines = {
        google = {
          default_source = 'auto',
          default_target = 'en',
        },
      },
      window = {
        window_config = {
          border = 'rounded',
        },
      },
    },
  },

  -- HTTP REST-Client Interface
  {
    'mistweaverco/kulala.nvim',
    filetypes = { 'http' },
    keys = keymaps.Kulala,
    opts = {
      additional_curl_options = { '--insecure', '-A', 'Mozilla/5.0' },
    },
  },

  -- language
  -- rust
  { 'simrat39/rust-tools.nvim' },
  { 'saecki/crates.nvim', ft = 'toml', opts = {} },
  -- golang
  {
    'ray-x/go.nvim',
    event = { 'CmdlineEnter' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    dependencies = { 'ray-x/guihua.lua' },
    keys = keymaps.GoNvim,
    opts = {
      lsp_inlay_hints = { enable = false },
    },
  },
  -- go-zero
  { 'BYT0723/goctl.nvim', opts = {}, dev = false },
  -- godot
  { 'habamax/vim-godot', ft = { 'gdscript', 'gdresource' } },
  -- sql
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    keys = keymaps.DB,
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  -- Zen Mode like vscode
  {
    'folke/zen-mode.nvim',
    opts = {},
  },

  -- run code in document or comment
  {
    'michaelb/sniprun',
    keys = keymaps.Sniprun,
    branch = 'master',
    build = 'sh install.sh',
    opts = {
      display = { 'Terminal', 'VirtualText' },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
  {
    'HakonHarnes/img-clip.nvim',
    keys = {
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
    opts = {},
  },

  --finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = keymaps.Telescope,
    dependencies = { { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    opts = function()
      return require('plugins.configs.telescope')
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        manual_mode = false,
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', 'Makefile', 'package.json', 'go.mod' },
        ignore_lsp = {
          'bashls',
          'cssls',
          'dockerls',
          'docker_compose_language_service',
          'dotls',
          'emmet_ls',
          'jsonls',
          'marksman',
          'pyright',
          'rust_analyzer',
          'ts_ls',
        },
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
      })
    end,
  },
  -- completion
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = require('plugins.configs.cmp'),
  },
  {
    'Exafunction/codeium.vim',
    init = function()
      vim.g.codeium_disable_bindings = 1
      -- stylua: ignore
      vim.keymap.set('i', '<C-L>', function () return vim.fn['codeium#Accept']() end,            { expr = true, silent = true })
      -- stylua: ignore
      vim.keymap.set('i', '<C-h>', function() return vim.fn['codeium#AcceptNextWord']() end,     { expr = true, silent = true })
      -- stylua: ignore
      vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,  { expr = true, silent = true })
      -- stylua: ignore
      vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    end,
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      -- lua vim developer
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'nvim-dap-ui' }, types = true },
        },
      },
    },
    init = function()
      require('plugins.configs.lspconfig')
    end,
  },
  -- lsp 管理
  {
    'williamboman/mason.nvim',
    opts = function()
      return require('plugins.configs.mason')
    end,
    config = function(_, opts)
      require('mason').setup(opts)
      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
      end, {})
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'ThePrimeagen/refactoring.nvim', lazy = true, opts = {} },
    },
    config = function(_, _)
      require('null-ls').setup(require('plugins.configs.null-ls'))

      require('plugins.configs.formatter').setup()
    end,
  },
  -- debug配置
  {
    'mfussenegger/nvim-dap',
    cmd = 'DapToggle',
    keys = keymaps.Dap,
    dependencies = {
      'rcarriga/nvim-dap-ui', -- debug UI
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('plugins.configs.dap-local')
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      return require('plugins.configs.treesitter')
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup(opts.context)
      -- 开启 Folding
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-context', keys = keymaps.TreeSitterContext },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
    },
  },
  -- which key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = { preset = 'helix' },
  },
  -- normal/insert模式切换的输入法记忆
  { 'h-hg/fcitx.nvim', event = 'VeryLazy' },

  -- Correct bad habits
  {
    'm4xshen/hardtime.nvim',
    opts = {
      max_count = 10,
      restriction_mode = 'hint',
    },
  },
}, {
  ui = {
    border = 'double',
    backdrop = 100,
  },
  dev = {
    path = '~/Workspace/Github/Neovim',
    patterns = {},
    fallback = false,
  },
})
