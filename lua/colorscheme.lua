-- configure tokyonight
require("tokyonight").setup({
	transparent = function()
		return vim.fn.exists("g:neovide") == 0
	end,
	style = "moon", -- storm / night / moon / day
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true, bold = true },
		functions = { italic = true },
		variables = { italic = false },
		sidebars = "transparent", -- dark / transparent / normal
		floats = "transparent",
	},
	sidebars = { "qf", "toggleterm", "lspsagaoutline", "NvimTree" },
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = true,
	lualine_bold = true,

	on_colors = function(colors) end,

	on_highlights = function(highlights, colors)
		local transparent = colors.fg_transparent

		-- 设置telescope 透明效果
		highlights.TelescopeNormal = { bg = transparent }
		highlights.TelescopeBorder = { bg = transparent }
		highlights.TelescopePromptNormal = { bg = transparent }
		highlights.TelescopePromptBorder = { bg = transparent }
		highlights.TelescopePromptTitle = { bg = transparent }
		highlights.TelescopePreviewTitle = { bg = transparent }
		highlights.TelescopeResultsTitle = { bg = transparent }
	end,
})

-- Load the colorscheme
vim.cmd([[colorscheme tokyonight]])
