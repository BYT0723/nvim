local servers = {
    "angularls",
    "bashls",
    "clangd",
    "cmake",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "marksman",
    "tsserver",
    "sumneko_lua",
    "pyright",
    "rust_analyzer",
    "vimls",
    "vuels",
    "sqls",
}
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local mapbuf = vim.api.nvim_buf_set_keymap
    require("keybindings").maplsp(mapbuf, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require('lsp/lsp-config/gopls')
require('lsp/lsp-config/sumneko_lua')
require('lsp_signature').setup {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_enable = false, -- virtual hint enable
    handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none
    },
}

vim.api.nvim_command("au BufWritePre * lua vim.lsp.buf.formatting_sync(nil,2000)")
