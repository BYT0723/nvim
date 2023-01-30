local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		-- cann't connect to github.com
		-- fn.system({ "git", "clone", "--depth", "1", "https://kgithub.com/wbthomason/packer.nvim.git", install_path })
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim.git", install_path })
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

return require("packer").startup({
	function()
		-- base
		use("nvim-lua/plenary.nvim")

		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- startup
		use({
			"lewis6991/impatient.nvim", -- 加速plugin加载
			"nathom/filetype.nvim", -- 代替nvim中默认的filetype检测，速度提升
		})

		use({
			"glepnir/dashboard-nvim",
			event = "VimEnter",
		})

		-- theme
		use({
			"kyazdani42/nvim-web-devicons", -- 文件图标
			"lukas-reineke/indent-blankline.nvim", -- 退格设置
			"norcalli/nvim-colorizer.lua", -- 16进制颜色显示(例如: #999901)
			"nvim-lualine/lualine.nvim", -- status bar
			"RRethy/vim-illuminate", -- keyword highlight
		})
		use("folke/tokyonight.nvim")
		use({ "akinsho/bufferline.nvim", tag = "v3.*" })

		-- common code plugin
		use({
			"kyazdani42/nvim-tree.lua", -- 文件树
			"windwp/nvim-autopairs", -- 括号自动闭合
			"numToStr/Comment.nvim", -- 注释
			"mg979/vim-visual-multi", -- 多选
			"folke/trouble.nvim", -- 错误统计
			"akinsho/toggleterm.nvim", -- 终端
			"kylechui/nvim-surround", -- 代码包裹
			"phaazon/hop.nvim", -- 快速移动
			"lewis6991/gitsigns.nvim", -- git样式，包括blame,修改标记
			"sindrets/diffview.nvim", -- diffview
			"lilydjwg/fcitx.vim", -- fcitx 输入法模式隔离
			"voldikss/vim-translator", -- translator
			"junegunn/vim-easy-align", -- char align
		})

		-- language
		use({
			"fatih/vim-go",
			"habamax/vim-godot",
			"BYT0723/vim-goctl",
		})
		use({
			"saecki/crates.nvim",
			tag = "v0.3.0",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		})

		-- markdown preview
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

		-- complete and lsp
		use({
			-- cmp
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
			"hrsh7th/cmp-vsnip", -- { name = 'vsnip' }
			"hrsh7th/vim-vsnip", -- vscode的json code snippet的支持
			"rafamadriz/friendly-snippets", -- 各种语言常用的代码片段
			"onsails/lspkind-nvim", -- 补全中的图标
			"ray-x/lsp_signature.nvim", -- 补全时的文档显示

			-- lsp
			"neovim/nvim-lspconfig", -- lsp配置
			"williamboman/mason.nvim", -- lsp管理
			"williamboman/mason-lspconfig.nvim",
			-- "glepnir/lspsaga.nvim", -- lsp wrapper
			"mfussenegger/nvim-lint", -- linter配置
			"mhartington/formatter.nvim", -- formatter配置
			"mfussenegger/nvim-dap", -- debug配置
			"rcarriga/nvim-dap-ui", -- debug UI
		})

		use({
			"glepnir/lspsaga.nvim", -- lsp wrapper
			branch = "main",
		})

		-- treesitter 语法分析
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			"p00f/nvim-ts-rainbow", -- 彩色括号
			"ThePrimeagen/refactoring.nvim", -- 代码重构
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
