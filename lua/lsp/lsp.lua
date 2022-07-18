local servers = { 
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'tsserver',
    "gopls",
    "vimls",
    "html",
    "angularls",
    "jsonls",
    "vuels",
    "sqls",
    "dockerls",
    "clangd",
    "bashls",
    "gdscript"
}

-- install lsp
require("nvim-lsp-installer").setup({
    ensure_installed = servers, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local mapbuf = vim.api.nvim_buf_set_keymap
    require'keybindings'.maplsp(mapbuf,bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

require('lsp/lsp-config/gopls')
require('lsp/lsp-config/sumneko_lua')

-- godot
-- require('lspconfig').gdscript.setup{
--     capabilities = require('cmp_nvim_lsp').update_capabilities( vim.lsp.protocol.make_client_capabilities() )
-- }
