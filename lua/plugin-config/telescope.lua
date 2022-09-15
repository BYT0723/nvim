require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                ["<C-h>"] = "which_key",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        -- find_files = {
        --   theme = "ivy", -- cursor/dropdown/ivy
        -- },
        -- live_grep = {
        --   theme = "ivy",
        -- },
        -- buffers = {
        --   theme = "dropdown",
        -- },
        -- help_tags = {
        --   theme = "ivy",
        -- }
    },
    extensions = {
        projects = {},
        notify = {},
        ["ui-select"] = { require("telescope.themes").get_cursor {} }
    }
}
require('telescope').load_extension('projects')
require('telescope').load_extension('notify')
require('telescope').load_extension('ui-select')
