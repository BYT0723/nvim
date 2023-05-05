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

require('lazy').setup({
  -- base or lib
  'nvim-lua/plenary.nvim',

  -- colorscheme
  {
    'folke/tokyonight.nvim',
    opts = function()
      return require('plugins.configs.tokyonight')
    end,
    config = function(_, opts)
      require('tokyonight').setup(opts)
      -- Load the colorscheme
      vim.cmd([[colorscheme tokyonight]])
    end,
    priority = 1000,
  },
  -- Dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      return require('plugins.configs.dashboard')
    end,
    config = function(_, opts)
      require('dashboard').setup(opts)
    end,
  },

  -- gui
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'rcarriga/nvim-notify',
    init = function()
      require('keybindings').Load_Keys('Notify')
    end,
    opts = function()
      return require('plugins.configs.notify')
    end,
    config = function(_, opts)
      local notify = require('notify')
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    'folke/noice.nvim',
    opts = function()
      return require('plugins.configs.noice')
    end,
    config = function(_, opts)
      require('noice').setup(opts)
    end,
  },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  -- 退格设置
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    config = function()
      require('indent_blankline').setup({
        show_end_of_line = true,
        space_char_blankline = ' ',
        show_current_context = true, -- 高亮显示当前代码块的条
        show_current_context_start = false, -- 高亮显示当前代码块的起始位置
        filetype_exclude = { 'dashboard' },
      })
    end,
  },
  -- status bar
  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      return require('plugins.configs.lualine')
    end,
    config = function(_, opts)
      require('lualine').setup(opts)
    end,
  },
  -- keyword highlight
  {
    'RRethy/vim-illuminate',
    event = 'BufEnter',
    config = function()
      require('illuminate').configure({
        filetypes_denylist = { 'NvimTree', 'Trouble', 'Dashboard', 'lspsagaoutline', 'toggleterm' },
      })
    end,
  },
  -- buffer bar
  {
    'akinsho/bufferline.nvim',
    version = 'v3.*',
    init = function()
      require('keybindings').Load_Keys('Bufferline')
    end,
    opts = function()
      return require('plugins.configs.bufferline')
    end,
    config = function(_, opts)
      require('bufferline').setup(opts)
    end,
  },
  -- 16进制颜色显示(例如: #999901)
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- common
  {
    'windwp/nvim-autopairs', -- 括号自动闭合
    event = 'BufEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
        ts_config = {
          lua = { 'string' }, -- it will not add a pair on that treesitter node
          javascript = { 'template_string' },
          java = false, -- don't check treesitter on java
        },
      })
    end,
  },
  -- 文件树
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    init = function()
      require('keybindings').Load_Keys('NvimTree')
    end,
    opts = function()
      return require('plugins.configs.tree')
    end,
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
  {
    'akinsho/toggleterm.nvim', -- 终端
    init = function()
      require('keybindings').Load_Keys('ToggleTerm')
    end,
    opts = function()
      return require('plugins.configs.toggleterm')
    end,
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
  },
  -- 注释
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  -- git样式，包括blame,修改标记
  {
    'lewis6991/gitsigns.nvim',
    init = function()
      require('keybindings').Load_Keys('Gitsigns')
    end,
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
  'mg979/vim-visual-multi', -- 多选
  -- char align
  {
    'junegunn/vim-easy-align',
    init = function()
      require('keybindings').Load_Keys('EasyAlign')
    end,
  },
  -- todo comment
  {
    'folke/todo-comments.nvim',
    cmd = 'TodoTrouble',
    init = function()
      require('keybindings').Load_Keys('TodoComments')
    end,
    config = function()
      require('todo-comments').setup()
    end,
  },
  -- 错误统计
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'TodoTrouble' },
    init = function()
      require('keybindings').Load_Keys('Trouble')
    end,
    opts = function()
      return require('plugins.configs.trouble')
    end,
    config = function(_, opts)
      require('trouble').setup(opts)
    end,
  },
  -- 代码包裹
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  -- 快速移动
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    cmd = { 'HopChar1CurrentLine', 'HopChar2' },
    init = function()
      require('keybindings').Load_Keys('Hop')
    end,
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    init = function()
      require('keybindings').Load_Keys('Diffview')
    end,
    opts = function()
      require('plugins.configs.diffview')
    end,
    config = function(_, opts)
      require('diffview').setup(opts)
    end,
  },
  -- tranlator
  {
    'potamides/pantran.nvim',
    init = function()
      require('keybindings').Load_Keys('PanTran')
    end,
    config = function()
      local pantran = require('pantran')
      pantran.setup({
        default_engine = 'google',
        engines = {
          google = {
            default_source = 'auto',
            default_target = 'en',
          },
        },
      })
    end,
  },

  -- language
  -- godot
  {
    'habamax/vim-godot',
    ft = { 'gdscript', 'gdresource' },
  },
  -- rust
  'simrat39/rust-tools.nvim',
  {
    'saecki/crates.nvim',
    ft = 'toml',
    tag = 'v0.3.0',
    config = function()
      require('crates').setup()
    end,
  },
  -- golang
  { 'fatih/vim-go', ft = { 'go', 'gomod' } },
  -- go-zero
  {
    'BYT0723/goctl.nvim',
    ft = { 'goctl', 'proto', 'sql' },
    config = function()
      require('goctl').setup()
    end,
    dev = true,
  },
  -- sql
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = 'DBUIToggle',
    init = function()
      require('keybindings').Load_Keys('DB')
    end,
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    config = function()
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
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = 'markdown',
  },

  --finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    init = function()
      require('keybindings').Load_Keys('Telescope')
    end,
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup()
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

    config = function(_, opts)
      require('cmp').setup(opts)
    end,
  },

  -- lsp
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
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
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      {
        'ray-x/lsp_signature.nvim', -- 补全时的文档显示
        config = function()
          require('lsp_signature').setup({
            hint_enable = false, -- virtual hint enable
          })
        end,
      },
    },
    config = function()
      require('plugins.configs.lspconfig')
    end,
  },
  {
    'mfussenegger/nvim-lint',
    init = function()
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
    config = function()
      require('lint').linters_by_ft = require('plugins.configs.linter')
    end,
  },
  -- lsp wrapper
  {
    'glepnir/lspsaga.nvim',
    cmd = 'Lspsaga',
    init = function()
      require('keybindings').Load_Keys('Lspsaga')
    end,
    opts = function()
      return require('plugins.configs.lspsaga')
    end,
    config = function(_, opts)
      require('lspsaga').setup(opts)
    end,
  },
  {
    'mhartington/formatter.nvim', -- formatter配置
    init = function() end,
    config = function()
      local formatter = require('plugins.configs.formatter')
      require('formatter').setup(formatter.options)
      -- set auto format after writen
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          if formatter.is_exc_file() then
            return
          end
          for _, v in pairs(formatter.formatCond) do
            if v.func() then
              -- vim.notify(v.msg, v.level)
              return
            end
          end
          vim.cmd('FormatWriteLock')
        end,
      })
    end,
  },
  -- debug配置
  {
    'mfussenegger/nvim-dap',
    cmd = 'DapToggle',
    dependencies = {
      'rcarriga/nvim-dap-ui', -- debug UI
    },
    init = function()
      require('keybindings').Load_Keys('Dap')
    end,
    config = function()
      local dap_local = require('plugins.configs.dap-local')
      vim.api.nvim_create_user_command('DapToggle', function()
        dap_local.DapToggle()
      end, {})
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    -- cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    event = 'BufEnter',
    build = ':TSUpdate',
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
      { 'nvim-treesitter/nvim-treesitter-context' },
      'p00f/nvim-ts-rainbow', -- 彩色括号
      'ThePrimeagen/refactoring.nvim', -- 代码重构
      {
        'nvim-orgmode/orgmode',
        config = function()
          require('orgmode').setup_ts_grammar()
          require('orgmode').setup({
            org_agenda_files = { '~/Documents/org/*' },
            org_default_notes_file = '~/Documents/org/refile.org',
            -- win_split_mode = { 'float', 0.6 },
            win_border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
          })
        end,
      },
    },
  },
  -- highlight block by nvim-treesitter
  {
    'folke/twilight.nvim',
    cmd = 'Twilight',
    config = function()
      require('twilight').setup()
    end,
  },

  -- wakatime tool
  'wakatime/vim-wakatime',
  -- which key
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require('which-key').setup({
        window = {
          border = 'double', -- none, single, double, shadow
        },
      })
    end,
  },
  {
    'lilydjwg/fcitx.vim',
    event = 'InsertEnter',
  },
}, {
  ui = {
    border = 'double',
  },
  dev = {
    path = '~/Workspace/Github/Neovim',
    patterns = {},
    fallback = false,
  },
})
