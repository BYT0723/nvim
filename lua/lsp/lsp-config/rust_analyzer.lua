-- keymap import
local on_attach = function(client, bufnr)
    local mapbuf = vim.api.nvim_buf_set_keymap
    require 'keybindings'.maplsp(mapbuf, bufnr)
end

require("lspconfig").rust_analyzer.setup({
    cmd = { "rust-analyzer" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {},
})
