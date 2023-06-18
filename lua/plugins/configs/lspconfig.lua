local lspconfig = require('lspconfig')
local install_servers = {
  -- "angularls",
  'asm_lsp',
  'bashls',
  'bufls',
  'clangd',
  'cmake',
  'cssls',
  'dockerls',
  'docker_compose_language_service',
  'dotls',
  'emmet_ls',
  'eslint',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'pyright',
  -- "rust_analyzer",
  'sqlls',
  'taplo',
  'tsserver',
  'vimls',
  'volar',
  'yamlls',
  -- Other non-installation servers
  'gdscript',
  'dartls',
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require('plugins.keymaps').maplsp(bufnr)
  if client.name == 'clangd' then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      'gs',
      '<cmd>ClangdSwitchSourceHeader<CR>',
      { noremap = true, silent = true, desc = 'jump between header and c/cpp' }
    )
  end
end

local settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      path = { unpack(vim.split(package.path, ';')), 'lua/?.lua', 'lua/?/?.lua', 'lua/?/?/?.lua' },
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
    completion = {
      callSnippet = 'Replace',
    },
  },
  gopls = {
    usePlaceholders = true,
    codelenses = {
      generate = true,
      test = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  },
  yaml = {
    keyOrdering = false,
  },
  html = {
    options = {
      -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
      ['bem.enabled'] = true,
    },
  },
  typescript = {
    inlayHints = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
  javascript = {
    inlayHints = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp
for _, lsp in pairs(install_servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end

-- rust-tools.nvim
require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  },
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
})

-- emmet
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = settings,
})

lspconfig.asm_lsp.setup({
  root_dir = function()
    return vim.fn.getcwd()
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = settings,
})
