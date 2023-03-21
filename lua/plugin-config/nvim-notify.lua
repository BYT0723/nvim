require("notify").setup({
	-- background_colour = "NotifyBackground",
	background_colour = "#000000",
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default", -- default / minimal / simple / compact
	stages = "fade_in_slide_out", -- fade_in_slide_out / fade / slide / static
	timeout = 5000,
	top_down = true,
})

vim.notify = require("notify")
