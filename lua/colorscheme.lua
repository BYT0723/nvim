require("tokyonight").setup({
	transparent = true,
	style = "night", -- storm / night / moon / day
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
		variables = { italic = false },
		sidebars = "transparent", -- dark / transparent / normal
		floats = "transparent",
	},
	sidebars = { "qf", "toggleterm", "lspsagaoutline", "NvimTree" },
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = false,
	lualine_bold = true,

	on_colors = function(colors) end,

	on_highlights = function(hl, c)
		-- 设置telescope 透明效果
		local bg = c.fg_transparent
		hl.TelescopeNormal = {
			bg = bg,
		}
		hl.TelescopeBorder = {
			bg = bg,
		}
		hl.TelescopePromptNormal = {
			bg = bg,
		}
		hl.TelescopePromptBorder = {
			bg = bg,
		}
		hl.TelescopePromptTitle = {
			bg = bg,
		}
		hl.TelescopePreviewTitle = {
			bg = bg,
		}
		hl.TelescopeResultsTitle = {
			bg = bg,
		}
	end,
})

-- Load the colorscheme
vim.cmd([[colorscheme tokyonight]])
