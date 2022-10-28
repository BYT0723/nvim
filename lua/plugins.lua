local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

return require("packer").startup({
	function()
		-- base
		use({ "nvim-lua/plenary.nvim" })

		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- theme
		use({
			"kyazdani42/nvim-web-devicons", -- 文件图标
			"lukas-reineke/indent-blankline.nvim", -- 退格设置
			"nvim-lualine/lualine.nvim", -- 底部状态栏
			"folke/tokyonight.nvim", -- colorscheme, nvim样式
			"norcalli/nvim-colorizer.lua", -- 16进制颜色显示(例如: #999901)
		})

		-- common code plugin
		use({
			"windwp/nvim-autopairs", -- 括号自动闭合
			"numToStr/Comment.nvim", -- 注释
			"mg979/vim-visual-multi", -- 多选
			"folke/trouble.nvim", -- 错误统计
			"ThePrimeagen/refactoring.nvim", -- 代码重构
		})
		-- term
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			config = function()
				require("toggleterm").setup()
			end,
		})
		-- surround
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({})
			end,
		})
		-- quick position
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		-- language
		use({
			"fatih/vim-go",
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

		-- git
		use({
			"kdheepak/lazygit.nvim", -- lazygit, 终端中的git工具，很好用，推荐
			"lewis6991/gitsigns.nvim", -- git样式处理，包括blame,修改符号等
			"sindrets/diffview.nvim", -- diffview, 展示当前项目中未git add的文件，并展示修改处，类似idea的git diff
		})

		-- finder
		use("nvim-telescope/telescope.nvim")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use("nvim-telescope/telescope-ui-select.nvim")
		use({
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({})
			end,
		})

		-- nvim-tree
		use("kyazdani42/nvim-tree.lua")

		-- bufferline
		use({ "romgrk/barbar.nvim" })

		-- treesitter 代码高亮等
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "p00f/nvim-ts-rainbow" })

		-- lspconfig
		use({
			"neovim/nvim-lspconfig", -- lsp配置
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim", -- lsp管理
			"mfussenegger/nvim-lint", -- linter配置
			"simrat39/symbols-outline.nvim", -- 语法树
			"mhartington/formatter.nvim", -- formatter配置
			"mfussenegger/nvim-dap", -- debug配置
			"rcarriga/nvim-dap-ui",

			"ray-x/lsp_signature.nvim", -- 补全时的文档显示
		})
		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
		})

		-- nvim-cmp
		use({
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
			"hrsh7th/cmp-vsnip", -- { name = 'vsnip' }
			"hrsh7th/vim-vsnip", -- 一些代码片段
			"rafamadriz/friendly-snippets", -- 各种语言常用的代码片段
			"onsails/lspkind-nvim", -- 补全中的图标
		})

		-- quick startup
		use({
			"lewis6991/impatient.nvim", -- 加速plugin加载
			"nathom/filetype.nvim", -- 代替nvim中默认的filetype检测，速度提升
			"folke/which-key.nvim", -- nvim键盘映射提示
			"glepnir/dashboard-nvim", -- nvim面板
		})

		-- save every buffer's status of fcitx
		use({ "lilydjwg/fcitx.vim" })

		if ensure_packer() then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
