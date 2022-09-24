local servers = {
	"angularls",
	"bashls",
	"bufls",
	"clangd",
	"cssls",
	"dockerls",
	"gopls",
	"html",
	"jsonls",
	"sumneko_lua",
	"marksman",
	"pyright",
	"rust_analyzer",
	"sqls",
	"taplo",
	"denols",
	"vimls",
}
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	require("keybindings").maplsp(vim.api.nvim_buf_set_keymap, bufnr)
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
for _, lsp in pairs(servers) do
	if lsp ~= "clangd" then
		require("lspconfig")[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

require("lsp/lsp-config/sumneko_lua")
require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	hint_enable = false, -- virtual hint enable
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none
	},
})
