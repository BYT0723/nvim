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
		c = {
			require("formatter.filetypes.c").clangformat,
		},
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
			require("formatter.filetypes.go").gofmt,
			require("formatter.filetypes.go").goimports,
		},
		goctl = {},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--edition 2021" },
					stdin = true,
				}
			end,
		},
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
		toml = {
			require("formatter.filetypes.toml").taplo,
		},
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
		html = {
			require("formatter.filetypes.html").prettierd,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettierd,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettierd,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettierd,
		},
		css = {
			require("formatter.filetypes.css").prettierd,
		},
		vue = {
			function()
				return util.copyf(defaults.prettierd)
			end,
		},
		angular = {
			function()
				return util.copyf(defaults.prettierd)
			end,
		},
		less = {
			function()
				return util.copyf(defaults.prettierd)
			end,
		},
		scss = {
			function()
				return util.copyf(defaults.prettierd)
			end,
		},
	},
})

vim.api.nvim_command("au BufWritePost * FormatWrite")
