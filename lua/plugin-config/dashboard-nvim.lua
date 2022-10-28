local home = os.getenv("HOME")
local db = require("dashboard")
-- db.preview_file_height = 13
-- db.preview_file_width = 55
db.default_banner = {
	"                                                       ",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"         ,__,                              ,__,        ",
	"     ____(^^)   ________________________   (^^)____    ",
	"   /(    (__)   May you never be alone   (__)    )\\  ",
	"  * ||--||      ------------------------      ||--|| * ",
	"                                                       ",
	"                                                       ",
}
db.custom_center = {
	{
		icon = "  ",
		desc = "New Buffer                   ",
		action = "DashboardNewFile",
		shortcut = "SPC   n",
	},
	{
		icon = "  ",
		desc = "Recent Projects              ",
		action = "Telescope projects",
		shortcut = "SPC   p",
	},
	{
		icon = "פּ  ",
		desc = "Open File Tree               ",
		action = "NvimTreeOpen",
		shortcut = "SPC   e",
	},
	{
		icon = "  ",
		desc = "Search File                  ",
		action = "Telescope fd",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Search Context               ",
		action = "Telescope live_grep",
		shortcut = "SPC f g",
	},
	{
		icon = "  ",
		desc = "Plugin Update                ",
		action = "PackerSync",
		shortcut = "       ",
	},
	{
		icon = "  ",
		desc = "Configuration                ",
		action = "edit ~/.config/nvim/init.vim",
		shortcut = "       ",
	},
}
