local custom_header = {
	"                                                       ",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"                                                       ",
	"             [ May everyone not be alone ]             ",
	"                                                       ",
	"                                                       ",
}
local hyper_config = {
	header = custom_header, -- ascii text in there
	shortcut = {
		{ desc = "Files", key = "SPC   e", action = "NvimTreeOpen", group = "DashboardRecentTitle" },
		{ desc = "Search", key = "SPC f f", action = "Telescope fd", group = "DashboardRecentTitle" },
		{ desc = "Update", key = "SPC u", action = "PackerSync", group = "DashboardRecentTitle" },
		{ desc = "dotfiles", key = "cf", action = "edit ~/.config/nvim/init.vim", group = "DashboardRecentTitle" },
	},
	packages = { enable = true }, -- show how many plugins neovim loaded
	project = { limit = 8, action = "Telescope find_files cwd=" }, -- limit how many projects list, action when you press key or enter it will run this action.
	mru = { limit = 10 }, -- how many files in list
}

local doom_config = {
	header = custom_header,
	center = {
		{
			icon = "  ",
			desc = "New Buffer                ",
			action = "enew",
			key = "SPC   n",
		},
		{
			icon = "פּ  ",
			desc = "File Manager              ",
			action = "NvimTreeOpen",
			key = "SPC   e",
		},
		{
			icon = "  ",
			desc = "Recently Files            ",
			action = "Telescope oldfiles",
			key = "SPC f r",
		},
		{
			icon = "  ",
			desc = "Recent Projects           ",
			action = "Telescope projects",
			key = "SPC   p",
		},
		{
			icon = "  ",
			desc = "Search File               ",
			action = "Telescope fd",
			key = "SPC f f",
		},
		{
			icon = "  ",
			desc = "Search Context            ",
			action = "Telescope live_grep",
			key = "SPC f g",
		},
		{
			icon = "  ",
			desc = "Plugin Update             ",
			action = "PackerSync",
			key = "       ",
		},
		{
			icon = "  ",
			desc = "Configuration             ",
			action = "edit ~/.config/nvim/init.vim",
			key = "       ",
		},
	},
}

require("dashboard").setup({
	theme = "doom", --  theme is doom and hyper default is hyper
	config = doom_config,
})
