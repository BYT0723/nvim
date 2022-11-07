return require("packer").startup({
	function()
		-- base
		use({ "nvim-lua/plenary.nvim" })

		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- startup
		use({
			"lewis6991/impatient.nvim", -- 加速plugin加载
			"nathom/filetype.nvim", -- 代替nvim中默认的filetype检测，速度提升
			"folke/which-key.nvim", -- nvim键盘映射提示
			"glepnir/dashboard-nvim", -- nvim面板
		})

		-- theme
		use({
			"kyazdani42/nvim-web-devicons", -- 文件图标
			"lukas-reineke/indent-blankline.nvim", -- 退格设置
			"folke/tokyonight.nvim", -- colorscheme, nvim样式
			"norcalli/nvim-colorizer.lua", -- 16进制颜色显示(例如: #999901)
			"p00f/nvim-ts-rainbow",
			"romgrk/barbar.nvim",
			"nvim-lualine/lualine.nvim", -- 底部状态栏
		})

		-- common code plugin
		use({
			"windwp/nvim-autopairs", -- 括号自动闭合
			"numToStr/Comment.nvim", -- 注释
			"mg979/vim-visual-multi", -- 多选
			"folke/trouble.nvim", -- 错误统计
			"ThePrimeagen/refactoring.nvim", -- 代码重构
			"akinsho/toggleterm.nvim", -- 终端
			"kylechui/nvim-surround", -- 代码包裹
			"phaazon/hop.nvim", -- 快速移动
			"kdheepak/lazygit.nvim", -- lazygit
			"lewis6991/gitsigns.nvim", -- git样式，包括blame,修改标记
			"sindrets/diffview.nvim", -- diffview
			"lilydjwg/fcitx.vim", -- fcitx 输入法模式隔离
		})

		-- language
		use({
			"fatih/vim-go",
			"habamax/vim-godot",
			"BYT0723/vim-goctl",
			"saecki/crates.nvim",
		})

		-- markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		})

		-- finder
		use({
			"nvim-telescope/telescope.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"ahmedkhalf/project.nvim",
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		-- nvim-tree
		use("kyazdani42/nvim-tree.lua")

		-- complete and lsp
		use({
			-- cmp
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
			"hrsh7th/cmp-vsnip", -- { name = 'vsnip' }
			"hrsh7th/vim-vsnip", -- 一些代码片段
			"rafamadriz/friendly-snippets", -- 各种语言常用的代码片段
			"onsails/lspkind-nvim", -- 补全中的图标

			-- lsp
			"neovim/nvim-lspconfig", -- lsp配置
			"williamboman/mason-lspconfig.nvim",
			"glepnir/lspsaga.nvim", -- lsp wrapper
			"williamboman/mason.nvim", -- lsp管理
			"mfussenegger/nvim-lint", -- linter配置
			"simrat39/symbols-outline.nvim", -- 语法树
			"mhartington/formatter.nvim", -- formatter配置
			"mfussenegger/nvim-dap", -- debug配置
			"rcarriga/nvim-dap-ui",

			"ray-x/lsp_signature.nvim", -- 补全时的文档显示
		})

		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	end,
})
