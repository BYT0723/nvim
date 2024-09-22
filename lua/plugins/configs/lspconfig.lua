local lspconfig = require('lspconfig')
local install_servers = {
  'bashls',
  'bufls',
  'clangd',
  'cssls',
  'dockerls',
  'docker_compose_language_service',
  'dotls',
  'emmet_ls',
  'gopls',
  'jsonls',
  'lua_ls',
  'marksman',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  -- Other non-installation servers
  'gdscript',
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require('plugins.keymaps').maplsp(bufnr)
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable()
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
      checkThirdParty = false,
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
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
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
  tools = { inlay_hints = { auto = false } },
})

-- emmet
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'typescriptreact',
    'vue',
    'gohtmltmpl',
  },
  init_options = settings,
})

lspconfig.html.setup({
  filetypes = { 'html', 'gohtmltmpl' },
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

lspconfig.clangd.setup({
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  on_attach = function(client, bufnr)
    require('plugins.keymaps').maplsp(bufnr)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      'gs',
      '<cmd>ClangdSwitchSourceHeader<CR>',
      { noremap = true, silent = true, desc = 'jump between header and c/cpp' }
    )
  end,
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = 'utf-16',
  },
  init_options = settings,
})
