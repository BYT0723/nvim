local util = require("formatter.util")
local defaults = require("formatter.defaults")
local api = vim.api

local exc_file = {
	lua = { "keybindings.lua" },
	cpp = { "config.h" },
}

local function is_exc_file()
	for _, v in ipairs(exc_file[vim.bo.filetype]) do
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
				if is_exc_file() then
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
				if is_exc_file() then
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
		goctl = {
			function()
				return {
					exe = "goctl api format --stdin",
					stdin = true,
				}
			end,
		},
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

-- formatting condition
local formatCond = {
	-- return true, if buf is empty
	is_empty = function()
		for _, line_text in pairs(api.nvim_buf_get_lines(0, 0, api.nvim_buf_line_count(0), 0)) do
			if line_text ~= "" then
				return false
			end
		end
		return true
	end,

	-- return true, if there is any error.
	have_error = function()
		local diagnostic_list = vim.diagnostic.get(0, nil)
		for _, v in pairs(diagnostic_list) do
			if v.severity == vim.diagnostic.severity.ERROR then
				return true
			end
		end
		return false
	end,
}
api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		if formatCond.is_empty() or formatCond.have_error() then
			return
		end
		vim.cmd("FormatWrite")
	end,
})
