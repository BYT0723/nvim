local util = require("formatter.util")
local defaults = require("formatter.defaults")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
			require("formatter.filetypes.go").goimports,
			require("formatter.filetypes.go").golines,
		},
		goctl = {},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
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
			require("formatter.filetypes.css").prettierd,
		},
		css = {
			require("formatter.filetypes.markdown").prettierd,
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
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.api.nvim_command("au BufWritePost * FormatWrite")
