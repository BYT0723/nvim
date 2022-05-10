local servers = { 
  'pyright',
  'rust_analyzer',
  'sumneko_lua',
  'tsserver',
  "gopls",
  "vimls",
  "html",
  "angularls",
  "vuels",
  "sqls",
  "dockerls",
  "clangd",
  "bashls"
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
end


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig')['gopls'].setup{
  cmd = {'gopls'},
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
    usePlaceholders = true,
  }
}
