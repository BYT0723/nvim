return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- theme
  use {
    'kyazdani42/nvim-web-devicons',         -- 文件图标
    'luochen1990/rainbow',                  -- 彩色括号
    'lukas-reineke/indent-blankline.nvim',  -- 退格设置
    'nvim-lualine/lualine.nvim',            -- 底部状态栏
    'folke/tokyonight.nvim',                -- colorscheme, nvim样式
    'rafi/awesome-vim-colorschemes',        -- vim的其他样式(例如: solarized, one, gruvbox, molokai)
    'norcalli/nvim-colorizer.lua',          -- 16进制颜色显示(例如: #999901)
  }

  -- common code plugin
  use {
    'windwp/nvim-autopairs',        -- 括号自动闭合
    'numToStr/Comment.nvim',        -- 注释
    'mg979/vim-visual-multi',       -- 多选
    'tpope/vim-surround',           -- 符号包裹处理
    'simrat39/symbols-outline.nvim',-- 语法树
    'skywind3000/asyncrun.vim',     -- 异步运行
    'folke/trouble.nvim',           -- 错误统计
  }

  -- language
  use {
    'BYT0723/vim-goctl',
    'habamax/vim-godot',
  }

  -- markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- git
  use {
    'kdheepak/lazygit.nvim',    -- lazygit, 终端中的git工具，很好用，推荐
    'lewis6991/gitsigns.nvim',  -- git样式处理，包括blame,修改符号等
    'sindrets/diffview.nvim',   -- diffview, 展示当前项目中未git add的文件，并展示修改处，类似idea的git diff
  }

  -- finder
  use 'nvim-telescope/telescope.nvim'
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }
  use 'rcarriga/nvim-notify'

  -- nvim-tree
  use 'kyazdani42/nvim-tree.lua'

  -- bufferline
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }

  -- treesitter 代码高亮等
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- lspconfig
  use {
    "neovim/nvim-lspconfig",                -- lsp配置
    "williamboman/nvim-lsp-installer",      -- lsp管理
    "ray-x/lsp_signature.nvim",
  }

  -- nvim-cmp
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',         -- { name = nvim_lsp }
    'hrsh7th/cmp-buffer',           -- { name = 'buffer' },
    'hrsh7th/cmp-path',             -- { name = 'path' }
    'hrsh7th/cmp-cmdline',          -- { name = 'cmdline' }
    'hrsh7th/cmp-vsnip',            -- { name = 'vsnip' }
    'hrsh7th/vim-vsnip',            -- 一些代码片段
    'rafamadriz/friendly-snippets', -- 各种语言常用的代码片段
    'onsails/lspkind-nvim',         -- 补全中的图标
  }

  -- quick startup
  use {
    'lewis6991/impatient.nvim',     -- 加速plugin加载
    'nathom/filetype.nvim',         -- 代替nvim中默认的filetype检测，速度提升
    'folke/which-key.nvim',         -- nvim键盘映射提示
    'glepnir/dashboard-nvim',       -- nvim面板
  }

  -- develop
  use {
    'nvim-lua/plenary.nvim',
  }
end)
