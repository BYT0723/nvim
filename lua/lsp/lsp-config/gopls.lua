-- keymap import
local on_attach = function(client, bufnr)
	local mapbuf = vim.api.nvim_buf_set_keymap
	require("keybindings").maplsp(mapbuf, bufnr)
end

require("lspconfig").gopls.setup({
	cmd = { "gopls" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		usePlaceholders = false,
	},
})
