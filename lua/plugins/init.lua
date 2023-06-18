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

local keymaps = require('keymaps')

require('lazy').setup({
  -- base or lib
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- gui
  { 'MunifTanjim/nui.nvim', lazy = true },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- colorscheme
  {
    'folke/tokyonight.nvim',
    opts = function()
      return require('plugins.configs.tokyonight')
    end,
    init = function()
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
  },
  -- buffer bar
  {
    'akinsho/bufferline.nvim',
    event = 'VimEnter',
    keys = keymaps.Bufferline,
    opts = function()
      return require('plugins.configs.bufferline')
    end,
  },
  -- status bar
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    opts = function()
      return require('plugins.configs.lualine')
    end,
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
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    keys = keymaps.Noice,
    opts = function()
      return require('plugins.configs.noice')
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- 退格设置
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      show_end_of_line = true,
      space_char_blankline = ' ',
      show_current_context = true, -- 高亮显示当前代码块的条
      show_current_context_start = true, -- 高亮显示当前代码块的起始位置
      filetype_exclude = { 'dashboard' },
    },
  },
  -- keyword highlight
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      filetypes_denylist = { 'NvimTree', 'Trouble', 'Dashboard', 'lspsagaoutline', 'toggleterm' },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
  -- 16进制颜色显示(例如: #999901)
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      require('colorizer').setup()
    end,
  },

  -- common
  {
    'windwp/nvim-autopairs', -- 括号自动闭合
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false, -- don't check treesitter on java
      },
    },
  },
  -- 文件树
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    keys = keymaps.NvimTree,
    opts = function()
      return require('plugins.configs.tree')
    end,
  },
  -- 终端
  -- TODO: 终端的键盘映射
  {
    'akinsho/toggleterm.nvim',
    opts = function()
      return require('plugins.configs.toggleterm')
    end,
  },
  -- 注释
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n' },
      { 'gbc', mode = 'n' },
      { 'gc', mode = 'v' },
      { 'gb', mode = 'v' },
      { 'gco', mode = 'n' },
      { 'gcO', mode = 'n' },
      { 'gcA', mode = 'n' },
    },
    opts = {
      mappings = {
        basic = true,
        extra = true,
      },
    },
  },
  -- git样式，包括blame,修改标记
  {
    'lewis6991/gitsigns.nvim',
    -- keymap in options
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
  },
  -- 多选
  {
    'mg979/vim-visual-multi',
    keys = { '<C-n>' },
  },
  -- char align
  {
    'junegunn/vim-easy-align',
    keys = keymaps.EasyAlign,
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
    cmd = 'TodoTrouble',
    keys = keymaps.TodoComments,
    opts = {},
  },
  -- 代码包裹
  {
    'kylechui/nvim-surround',
    keys = {
      { 'ys', mode = 'n' },
      { 'yS', mode = 'n' },
      { 'ds', mode = 'n' },
      { 'cs', mode = 'n' },
      { 'S', mode = 'v' },
    },
    opts = {},
  },
  -- 快速移动
  {
    'phaazon/hop.nvim',
    cmd = { 'HopChar1CurrentLine', 'HopChar2' },
    keys = keymaps.Hop,
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
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
  -- tranlator
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
  -- go-zero
  { 'BYT0723/goctl.nvim', ft = { 'goctl', 'proto', 'sql' }, opts = {}, dev = true },
  -- godot
  { 'habamax/vim-godot', ft = { 'gdscript', 'gdresource' } },

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
  -- lsp wrapper
  -- {
  --   'glepnir/lspsaga.nvim',
  --   cmd = 'Lspsaga',
  --   keys = keymaps.Lspsaga,
  --   opts = function()
  --     return require('plugins.configs.lspsaga')
  --   end,
  -- },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
        sources = {
          --lint
          --
          -- TODO: 下面两个会引发encodingoffset警告
          --
          -- nls.builtins.diagnostics.cpplint,
          -- nls.builtins.diagnostics.codespell,
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.diagnostics.proselint,
          nls.builtins.code_actions.eslint_d,
          -- format
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.cmake_format,
          nls.builtins.formatting.goimports,
          nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.taplo,
          nls.builtins.formatting.prettierd,
        },
      }
    end,
    config = function(_, opts)
      require('null-ls').setup(opts)
      require('plugins.configs.formatter').setup()
    end,
  },
  {
    -- This plugin requires nvim-nightly
    'lvimuser/lsp-inlayhints.nvim',
    event = 'LspAttach',
    branch = 'anticonceal',
    enabled = false,
    keys = keymaps.LspInlayHints,
    init = function()
      require('lsp-inlayhints').setup({
        inlay_hints = { highlight = 'Comment' },
      })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttach_inlayhints', {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, args.buf)
        end,
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
      { 'nvim-treesitter/nvim-treesitter-context' },
      'p00f/nvim-ts-rainbow', -- 彩色括号
      'ThePrimeagen/refactoring.nvim', -- 代码重构
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },

  {
    'nvim-orgmode/orgmode',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      org_agenda_files = { '~/Documents/org/*' },
      org_default_notes_file = '~/Documents/org/refile.org',
      -- win_split_mode = { 'float', 0.6 },
      win_border = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
    },
    init = function()
      require('orgmode').setup_ts_grammar()
    end,
  },

  -- wakatime tool
  { 'wakatime/vim-wakatime', event = 'VeryLazy' },
  -- which key
  {
    'folke/which-key.nvim',
    enalbe = true,
    opts = {
      window = {
        border = 'double', -- none, single, double, shadow
        position = 'top',
      },
    },
  },
  -- normal/insert模式切换的输入法记忆
  { 'h-hg/fcitx.nvim', event = 'VeryLazy' },
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
