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
    enabled = true,
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
    opts = {
      transparent = not vim.g.neovide,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variable = {},
        sidebars = 'dark', -- style for sidebars, see below
        floats = 'transparent', -- style for floating windows
      },
      sidebars = { 'qf' },
    },
  },
  -- background transparent
  {
    'xiyaowong/transparent.nvim',
    enabled = false,
    opts = {
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    },
  },
  -- notify
  {
    'rcarriga/nvim-notify',
    keys = keymaps.Notify,
    opts = function()
      return require('plugins.configs.notify')
    end,
    init = function()
      vim.notify = require('notify')
    end,
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
    cmd = { 'TroubleToggle', 'TodoTrouble' },
    keys = keymaps.Trouble,
    opts = require('plugins.configs.trouble'),
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
    opts = require('plugins.configs.zen-mode'),
  },

  -- run code in document or comment
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    opts = require('plugins.configs.sniprun'),
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    opts = require('plugins.configs.neorg'),
  },
  {
    -- install
    -- Arch: pacman -S imagemagick ueberzugpp
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim' },
    enabled = not vim.g.neovide,
    opts = {
      backend = 'ueberzug', -- ueberzug / kitty
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'notify', 'cmp_menu', 'cmp_docs' },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
    },
  },
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
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
          'tsserver',
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
    'hrsh7th/nvim-cmp',
    enabled = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- { name = nvim_lsp }
      'hrsh7th/cmp-buffer', -- { name = 'buffer' },
      'hrsh7th/cmp-path', -- { name = 'path' }
      'hrsh7th/cmp-cmdline', -- { name = 'cmdline' }
      'hrsh7th/cmp-vsnip', -- { name = 'vsnip' }
      'hrsh7th/vim-vsnip', -- vscode的json code snippet的支持
      'rafamadriz/friendly-snippets', -- 各种语言常用的代码片段
      'onsails/lspkind-nvim', -- 补全中的图标
    },
    opts = function()
      return require('plugins.configs.cmp')
    end,
  },
  {
    'codota/tabnine-nvim',
    enabled = true,
    build = './dl_binaries.sh',
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = false,
        dismiss_keymap = false,
        debounce_ms = 800,
        suggestion_color = { gui = '#808080', cterm = 255 },
        exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
        log_file_path = nil, -- absolute path to Tabnine log file
      })

      local tabnine = require('tabnine.keymaps')
      vim.keymap.set('i', '<C-l>', function()
        if tabnine.has_suggestion() then
          return tabnine.accept_suggestion()
        else
          return '<C-l>'
        end
      end, { expr = true })
      vim.keymap.set('i', '<C-h>', function()
        if tabnine.has_suggestion() then
          return tabnine.dismiss_suggestion()
        else
          return '<C-h>'
        end
      end, { expr = true })
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
  -- FIX: lsp inlayhints will be builtin in neovim version 0.10
  -- {
  --   'lvimuser/lsp-inlayhints.nvim',
  --   opts = {},
  --   event = 'LspAttach',
  --   branch = 'anticonceal',
  -- },
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
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = keymaps.SymbolOutline,
    opts = {
      symbols = {
        File = { icon = '󰈙', hl = '@text.uri' },
        Module = { icon = '', hl = '@namespace' },
        Namespace = { icon = '', hl = '@namespace' },
        Package = { icon = '', hl = '@namespace' },
        Class = { icon = '󰠱', hl = '@type' },
        Struct = { icon = '󰙅', hl = '@type' },
        Interface = { icon = '', hl = '@type' },
        Method = { icon = '󰆧', hl = '@method' },
        Property = { icon = '󰜢', hl = '@method' },
        Field = { icon = '󰜢', hl = '@field' },
        Constructor = { icon = '', hl = '@constructor' },
        Enum = { icon = '', hl = '@type' },
        Function = { icon = '󰊕', hl = '@function' },
        Variable = { icon = '󰀫', hl = '@constant' },
        Constant = { icon = '󰏿', hl = '@constant' },
        String = { icon = '󰉿', hl = '@string' },
        Number = { icon = '󰎠', hl = '@number' },
        Boolean = { icon = '', hl = '@boolean' },
        Array = { icon = '', hl = '@constant' },
        Object = { icon = '⦿', hl = '@type' },
        Key = { icon = '󰌋', hl = '@type' },
        Null = { icon = 'NULL', hl = '@type' },
        EnumMember = { icon = '', hl = '@field' },
        Event = { icon = '', hl = '@type' },
        Operator = { icon = '󰆕', hl = '@operator' },
        TypeParameter = { icon = '𝙏', hl = '@parameter' },
        Component = { icon = '', hl = '@function' },
        Fragment = { icon = '', hl = '@constant' },
      },
    },
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
      'nvim-treesitter/playground',
      { 'nvim-treesitter/nvim-treesitter-context', keys = keymaps.TreeSitterContext },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      require('rainbow-delimiters.setup').setup({})
    end,
  },
  -- which key
  {
    'folke/which-key.nvim',
    enabled = true,
    opts = {
      window = {
        border = 'none', -- none, single, double, shadow
        position = 'top', -- bottom, top
        margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        align = 'center',
      },
    },
  },
  -- normal/insert模式切换的输入法记忆
  { 'h-hg/fcitx.nvim', event = 'VeryLazy' },
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
