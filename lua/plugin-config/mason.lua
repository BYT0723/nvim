require("mason").setup({
	ui = {
		-- Whether to automatically check for new versions when opening the :Mason window.
		check_outdated_packages_on_open = true,

		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",

		icons = {
			-- The list icon to use for installed packages.
			package_installed = "◍",
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = "◍",
			-- The list icon to use for packages that are not installed.
			package_uninstalled = "◍",
		},

		keymaps = require("keybindings").mason(),
	},
})
