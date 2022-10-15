-- Example config in Lua
vim.g.tokyonight_style = "moon" -- storm / night / day / moon
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_day_brightness = 0.3
vim.g.tokyonight_lualine_bold = true

-- Load the colorscheme
vim.cmd([[colorscheme tokyonight]])
