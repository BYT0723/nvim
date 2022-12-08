vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:")

require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true, -- 高亮显示当前代码块的条
	show_current_context_start = true, -- 高亮显示当前代码块的起始位置
	filetype_exclude = { "dashboard" },
})
