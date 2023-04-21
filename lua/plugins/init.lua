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
  { 'MunifTanjim/nui.nvim', lazy = true },

  -- develop
  'folke/neodev.nvim',
  'wakatime/vim-wakatime',

  -- gui
  {
    'rcarriga/nvim-notify',
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

  -- theme
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
  },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  -- Dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup(require('plugins.configs.dashboard'))
    end,
  },
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
      require('illuminate').configure()
    end,
  },
  -- buffer bar
  {
    'akinsho/bufferline.nvim',
    version = 'v3.*',
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
    opts = function()
      return require('plugins.configs.tree')
    end,
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
  {
    'akinsho/toggleterm.nvim', -- 终端
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
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
  'mg979/vim-visual-multi', -- 多选
  'voldikss/vim-translator', -- translator
  'junegunn/vim-easy-align', -- char align
  -- todo comment
  {
    'folke/todo-comments.nvim',
    cmd = 'TodoTrouble',
    config = function()
      require('todo-comments').setup()
    end,
  },
  -- 错误统计
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'TodoTrouble' },
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
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    opts = function()
      require('plugins.configs.diffview')
    end,
    config = function(_, opts)
      require('diffview').setup(opts)
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
  -- golang
  { 'fatih/vim-go', ft = { 'go', 'gomod' } },
  -- go-zero
  {
    'BYT0723/goctl.nvim',
    ft = { 'goctl', 'proto', 'sql' },
    config = function()
      require('goctl').setup()
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
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'ahmedkhalf/project.nvim',
        config = function()
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
    -- event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- { name = nvim_lsp }
      'hrsh7th/cmp-buffer', -- { name = 'buffer' },
      'hrsh7th/cmp-path', -- { name = 'path' }
      'hrsh7th/cmp-cmdline', -- { name = 'cmdline' }
      'hrsh7th/cmp-vsnip', -- { name = 'vsnip' }
      'hrsh7th/vim-vsnip', -- vscode的json code snippet的支持
      'rafamadriz/friendly-snippets', -- 各种语言常用的代码片段
      'onsails/lspkind-nvim', -- 补全中的图标
      'ray-x/lsp_signature.nvim', -- 补全时的文档显示
    },
    opts = function()
      return require('plugins.configs.cmp')
    end,

    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)
      for prefix, cmdline in pairs(opts.cmdline) do
        cmp.setup.cmdline(prefix, cmdline)
      end
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
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
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
            vim.notify('is exc file')
            return
          end
          for _, v in pairs(formatter.formatCond) do
            if v.func() then
              vim.notify(v.msg, v.level)
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
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
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
})
