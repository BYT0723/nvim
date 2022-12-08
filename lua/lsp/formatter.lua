local util = require("formatter.util")
local defaults = require("formatter.defaults")

local excFile = {
	lua = { "keybindings.lua", "plugins.lua" },
	cpp = { "config.h" },
}

local function isExcFile()
	for _, v in ipairs(excFile[vim.bo.filetype]) do
		if util.get_current_buffer_file_name() == v then
			return true
		end
	end
	return false
end

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			function()
				if isExcFile() then
					return nil
				end

				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		c = { require("formatter.filetypes.c").clangformat },
		cpp = {
			function()
				if isExcFile() then
					return nil
				end
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
					},
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		go = {
			require("formatter.filetypes.go").goimports,
			require("formatter.filetypes.go").gofmt,
		},
		goctl = {},
		python = {
			require("formatter.filetypes.python").autopep8,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--edition 2021" },
					stdin = true,
				}
			end,
		},
		sh = { require("formatter.filetypes.sh").shfmt },
		toml = { require("formatter.filetypes.toml").taplo },
		proto = {
			function()
				return {
					exe = "buf",
					args = { "format", util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},
		sql = {
			function()
				return {
					exe = "sql-formatter",
					stdin = true,
				}
			end,
		},
		json = { util.copyf(defaults.prettierd) },
		html = { util.copyf(defaults.prettierd) },
		javascript = { util.copyf(defaults.prettierd) },
		typescript = { util.copyf(defaults.prettierd) },
		yaml = { util.copyf(defaults.prettierd) },
		markdown = { util.copyf(defaults.prettierd) },
		css = { util.copyf(defaults.prettierd) },
		less = { util.copyf(defaults.prettierd) },
		scss = { util.copyf(defaults.prettierd) },
		vue = { util.copyf(defaults.prettierd) },
		angular = { util.copyf(defaults.prettierd) },
	},
})

vim.api.nvim_command("au BufWritePost * FormatWrite")
