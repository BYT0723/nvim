require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = require("keybindings").telescope(),
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		find_files = {
			theme = "ivy", -- cursor/dropdown/ivy
			no_ignore = true,
		},
		live_grep = {
			theme = "ivy",
		},
		buffers = {
			theme = "ivy",
		},
		help_tags = {
			theme = "ivy",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		projects = {},
		["ui-select"] = { require("telescope.themes").get_cursor({}) },
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("ui-select")
