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

  -- A series of mini.nvim plugins
  require('plugins.configs.mini'),

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variable = {},
      },
    },
  },
  -- keyword highlight
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetypes_denylist = { 'NvimTree', 'Trouble', 'Dashboard', 'toggleterm' },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = keymaps.NvimTree,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = function()
      return require('plugins.configs.nvim-tree')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      whitespace = {
        remove_blankline_trail = true,
      },
      indent = {
        char = '┊',
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

  -- background transparent
  {
    'xiyaowong/transparent.nvim',
    cmd = { 'TransparentToggle', 'TransparentEnable' },
    opts = {},
  },
  -- multi cursor
  {
    'mg979/vim-visual-multi',
    keys = { '<C-n>', '<C-Up>', '<C-Down>' },
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
  -- Wrap the input and select of vim.ui
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- terminal
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = [[<c-\>]],
    },
  },
  -- git style, including blame, modify tags
  {
    'lewis6991/gitsigns.nvim',
    -- keymap in options
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
  },
  -- 错误统计
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'TodoTrouble' },
    keys = keymaps.Trouble,
    opts = function()
      return require('plugins.configs.trouble')
    end,
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
    opts = function()
      require('plugins.configs.diffview')
    end,
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
  { 'fatih/vim-go', ft = { 'go', 'gomod' } },
  -- go-zero
  { 'BYT0723/goctl.nvim', ft = { 'goctl', 'proto', 'sql' }, opts = {}, dev = true },
  -- godot
  { 'habamax/vim-godot', ft = { 'gdscript', 'gdresource' } },
  -- sql
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = 'DBUIToggle',
    keys = keymaps.DB,
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    init = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'mysql' },
        callback = function()
          vim.opt.filetype = 'sql'
        end,
      })
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

  --finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = keymaps.Telescope,
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'ahmedkhalf/project.nvim',
        init = function()
          require('project_nvim').setup()
        end,
      },
    },
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

  -- completion
  {
    'hrsh7th/nvim-cmp',
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

  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      'williamboman/mason.nvim',
    },
    init = function()
      require('plugins.configs.lspconfig')
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    keys = keymaps.Noice,
    opts = function()
      return require('plugins.configs.noice')
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
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    config = function(_, _)
      require('null-ls').setup(require('plugins.configs.null-ls'))
      require('plugins.configs.formatter').setup()
    end,
  },
  -- lsp wrapper
  {
    'glepnir/lspsaga.nvim',
    enabled = false,
    cmd = 'Lspsaga',
    keys = keymaps.Lspsaga,
    opts = function()
      return require('plugins.configs.lspsaga')
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
  {
    -- This plugin requires nvim-nightly
    'lvimuser/lsp-inlayhints.nvim',
    enabled = false,
    branch = 'anticonceal',
    ft = { 'rust' },
    keys = keymaps.LspInlayHints,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttach_inlayhints', {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, args.buf, false)
        end,
      })
      require('lsp-inlayhints').setup({
        inlay_hints = { highlight = 'Comment' },
      })
    end,
  },
  -- debug配置
  {
    'mfussenegger/nvim-dap',
    cmd = 'DapToggle',
    keys = keymaps.Dap,
    dependencies = {
      'rcarriga/nvim-dap-ui', -- debug UI
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
      'p00f/nvim-ts-rainbow', -- 彩色括号
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  -- 代码重构
  {
    'ThePrimeagen/refactoring.nvim',
    lazy = true,
    opts = {},
  },

  {
    'nvim-orgmode/orgmode',
    enabled = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      org_agenda_files = { '~/Documents/org/*' },
      org_default_notes_file = '~/Documents/org/refile.org',
      -- win_split_mode = { 'float', 0.6 },
      -- win_border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
    },
    init = function()
      require('orgmode').setup_ts_grammar()
    end,
  },
  -- which key
  {
    'folke/which-key.nvim',
    enabled = true,
    opts = {
      window = {
        border = 'double', -- none, single, double, shadow
        position = 'bottom',
      },
    },
  },
  -- normal/insert模式切换的输入法记忆
  { 'h-hg/fcitx.nvim', event = 'VeryLazy' },
  -- funny
  {
    'BYT0723/typist.nvim',
    enabled = false,
    opts = {},
    dev = true,
  },
  {
    'eandrju/cellular-automaton.nvim',
    enabled = true,
    opts = {},
    cmd = 'CellularAutomaton',
  },
}, {
  ui = {
    border = 'shadow',
  },
  dev = {
    path = '~/Workspace/Github/Neovim',
    patterns = {},
    fallback = false,
  },
})
