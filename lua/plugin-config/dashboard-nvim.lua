local home = os.getenv("HOME")
local db = require("dashboard")
-- db.preview_command = "lolcat -F 0.2"
-- db.preview_file_path = home .. "/.config/nvim/neovim.cat"
-- db.preview_file_height = 8
-- db.preview_file_width = 55
db.default_banner = {
	"                                                       ",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
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
		icon = "פּ  ",
		desc = "Open File Tree               ",
		action = "NvimTreeOpen",
		shortcut = "SPC   e",
	},
	{
		icon = "  ",
		desc = "Recent Projects              ",
		action = "Telescope projects",
		shortcut = "SPC   p",
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
		icon = "  ",
		desc = "Most Recently                ",
		action = "Telescope oldfiles",
		shortcut = "SPC f r",
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
