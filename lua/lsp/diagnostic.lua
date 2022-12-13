local theme = require("theme")
local signs = {
	{ name = "DiagnosticSignError", text = theme.diagnostic.error },
	{ name = "DiagnosticSignWarn", text = theme.diagnostic.warn },
	{ name = "DiagnosticSignHint", text = theme.diagnostic.hint },
	{ name = "DiagnosticSignInfo", text = theme.diagnostic.info },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = true,
	signs = {
		active = signs,
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "single",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)
