local servers = {
	-- "angularls",
	"bashls",
	"bufls",
	"clangd",
	"cssls",
	"dotls",
	"dockerls",
	"eslint",
	"emmet_ls",
	"gopls",
	"html",
	"jsonls",
	"sumneko_lua",
	"marksman",
	"pyright",
	"rust_analyzer",
	"sqls",
	"taplo",
	"tsserver",
	"vimls",
	"volar",
	"yamlls",
}
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	require("keybindings").maplsp(vim.api.nvim_buf_set_keymap, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- godot engine
-- Arch: sudo pacman -S godot
require("lspconfig").gdscript.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- flutter
-- Arch: sudo pacman -S dart
require("lspconfig").dartls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lsp_signature").setup({
	hint_enable = false, -- virtual hint enable
})

--
-- specific lsp config
--

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/?.lua")
table.insert(runtime_path, "lua/?/?/?.lua")
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- emmet
require("lspconfig").emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})
