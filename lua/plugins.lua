local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    -- cann't connect to github.com
    -- fn.system({ "git", "clone", "--depth", "1", "https://gitee.com/BYT0723/packer.nvim.git", install_path })
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim.git', install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

-- cann't connect to github.com
-- require("packer").init({
--     git = {
--         default_url_format = 'https://kgithub.com/%s'
--     }
-- })

local packer_bootstrap = ensure_packer()

return require('packer').startup({
  function(use)
    -- eg:
    -- use {
    --   'myusername/example',        -- The plugin location string
    --
    --   -- The following keys are all optional
    --   disable = boolean,           -- Mark a plugin as inactive
    --   as = string,                 -- Specifies an alias under which to install the plugin
    --   installer = function,        -- Specifies custom installer. See "custom installers" below.
    --   updater = function,          -- Specifies custom updater. See "custom installers" below.
    --   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
    --   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
    --   opt = boolean,               -- Manually marks a plugin as optional.
    --   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
    --   branch = string,             -- Specifies a git branch to use
    --   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
    --   commit = string,             -- Specifies a git commit to use
    --   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
    --   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
    --   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
    --   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
    --   config = string or function, -- Specifies code to run after this plugin is loaded.
    --   -- The setup key implies opt = true
    --   setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
    --                                -- the plugin is waiting for other conditions (ft, cond...) to be met.
    --   -- The following keys all imply lazy-loading and imply opt = true
    --   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
    --   ft = string or list,         -- Specifies filetypes which load this plugin.
    --   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
    --   event = string or list,      -- Specifies autocommand events which load this plugin.
    --   fn = string or list          -- Specifies functions which load this plugin.
    --   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
    --   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
    --                                -- with one of these module names, the plugin will be loaded.
    --   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
    --                                -- requiring a string which matches one of these patterns, the plugin will be loaded.
    -- }

    -- base
    use('nvim-lua/plenary.nvim')

    -- develop
    use('folke/neodev.nvim')
    use('wakatime/vim-wakatime')

    -- gui
    use('MunifTanjim/nui.nvim')
    use('rcarriga/nvim-notify')
    use('folke/noice.nvim')

    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- startup
    use({
      'lewis6991/impatient.nvim', -- 加速plugin加载
    })

    use({
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('plugin-config/dashboard-nvim')
      end,
    })

    -- theme
    use({
      'folke/tokyonight.nvim', -- colorscheme
      'kyazdani42/nvim-web-devicons', -- 文件图标
      'lukas-reineke/indent-blankline.nvim', -- 退格设置
      'nvim-lualine/lualine.nvim', -- status bar
      'RRethy/vim-illuminate', -- keyword highlight
      -- buffer bar
      { 'akinsho/bufferline.nvim', tag = 'v3.*' },
      -- 16进制颜色显示(例如: #999901)
      {
        'norcalli/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup()
        end,
      },
    })

    -- common code plugin
    use({
      'windwp/nvim-autopairs', -- 括号自动闭合
      'mg979/vim-visual-multi', -- 多选
      'akinsho/toggleterm.nvim', -- 终端
      'kyazdani42/nvim-tree.lua', -- 文件树
      'lewis6991/gitsigns.nvim', -- git样式，包括blame,修改标记
      'lilydjwg/fcitx.vim', -- fcitx 输入法模式隔离
      'numToStr/Comment.nvim', -- 注释
      'voldikss/vim-translator', -- translator
      'junegunn/vim-easy-align', -- char align
      -- todo comment
      {
        'folke/todo-comments.nvim',
        config = function()
          require('plugin-config.todo-comments')
        end,
      },
      -- 错误统计
      {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle', 'TodoTrouble' },
        config = function()
          require('plugin-config.trouble')
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
        config = function()
          require('plugin-config.diffview')
        end,
      },
    })

    -- godot
    use({
      'habamax/vim-godot',
      ft = { 'gdscript', 'gdresource' },
    })

    -- rust
    use({ 'simrat39/rust-tools.nvim' })
    use({
      'saecki/crates.nvim',
      tag = 'v0.3.0',
      ft = 'toml',
      config = function()
        require('crates').setup()
      end,
    })

    -- golang
    use({ 'fatih/vim-go', ft = { 'go', 'gomod' } })
    -- go-zero
    use({
      'BYT0723/goctl.nvim',
      ft = { 'api', 'proto', 'sql' },
      config = function()
        require('goctl').setup()
      end,
    })

    -- markdown preview
    use({
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
      ft = 'markdown',
    })

    -- finder
    use({
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('project_nvim').setup()
        end,
      },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    })

    -- completion and lsp configuration
    use({
      -- cmp
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp', -- { name = nvim_lsp }
      'hrsh7th/cmp-buffer', -- { name = 'buffer' },
      'hrsh7th/cmp-path', -- { name = 'path' }
      'hrsh7th/cmp-cmdline', -- { name = 'cmdline' }
      'hrsh7th/cmp-vsnip', -- { name = 'vsnip' }
      'hrsh7th/vim-vsnip', -- vscode的json code snippet的支持
      'rafamadriz/friendly-snippets', -- 各种语言常用的代码片段
      'onsails/lspkind-nvim', -- 补全中的图标
      'ray-x/lsp_signature.nvim', -- 补全时的文档显示

      -- lsp
      'neovim/nvim-lspconfig', -- lsp配置
      'williamboman/mason.nvim', -- lsp管理
      'williamboman/mason-lspconfig.nvim',
      'mfussenegger/nvim-lint', -- linter配置
      -- lsp wrapper
      {
        'glepnir/lspsaga.nvim',
        cmd = 'Lspsaga',
        config = function()
          require('lsp/lsp-saga')
        end,
      },
      'mhartington/formatter.nvim', -- formatter配置
      'mfussenegger/nvim-dap', -- debug配置
      'rcarriga/nvim-dap-ui', -- debug UI
    })

    -- treesitter 语法分析
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')
    use('p00f/nvim-ts-rainbow') -- 彩色括号
    use('ThePrimeagen/refactoring.nvim') -- 代码重构

    -- highlight block by nvim-treesitter
    use({
      'folke/twilight.nvim',
      cmd = 'Twilight',
      config = function()
        require('plugin-config.twilight')
      end,
    })

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
    },
  },
})
