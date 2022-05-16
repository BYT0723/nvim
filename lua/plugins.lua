return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- theme
  use 'kyazdani42/nvim-web-devicons'
  use 'luochen1990/rainbow'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'flazz/vim-colorschemes'
  use 'norcalli/nvim-colorizer.lua'

  -- common code plugin
  -- auto plugin
  use 'jiangmiao/auto-pairs' -- 括号自动闭合
  use 'alvan/vim-closetag' -- html标签自动闭合

  -- other
  use 'numToStr/Comment.nvim' --- 注释
  use 'mg979/vim-visual-multi' -- 多选
  use 'tpope/vim-surround' -- 包裹符号
  use 'simrat39/symbols-outline.nvim' -- syntax tree
  use 'skywind3000/asyncrun.vim' -- 异步运行
  use 'folke/trouble.nvim'

  -- gozero
  use 'BYT0723/vim-goctl'

  -- git
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- nvim-tree
  use 'kyazdani42/nvim-tree.lua'

  -- bufferline
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }

  -- treesitter 代码高亮等
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- lspconfig
  use {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
  }

  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
  use 'hrsh7th/cmp-buffer' -- { name = 'buffer' },
  use 'hrsh7th/cmp-path' -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline' -- { name = 'cmdline' }
  use 'hrsh7th/nvim-cmp'
  -- vsnip
  use 'hrsh7th/cmp-vsnip' -- { name = 'vsnip' }
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  -- lspkind
  use 'onsails/lspkind-nvim'


  -- quick startup
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
end)
