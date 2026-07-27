local install_servers = {
  'bashls',
  'buf_ls',
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
  'systemd_lsp', -- use `cargo` install, not 'mason-installer', installed in the user directory, may fail when editing non-user services
  -- 'rust_analyzer', -- rust_analyzer is started by rustaceanvim
  'ts_ls',
  -- Other non-installation servers
  'gdscript',
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  require('plugins.keymaps').maplsp(bufnr)
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint and vim.g.lsp_inlay_hint_enabled then
    vim.lsp.inlay_hint.enable()
  end
end

local inlay_hints = {
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

local settings = {
  Lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = { globals = { 'vim' } },
    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
  },
  gopls = {
    usePlaceholders = true,
    staticcheck = true,
    analyses = {
      nilness = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
      shadow = false,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = false,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
    },
    directoryFilters = {
      '-.git',
      '-vendor',
      '-**/node_modules',
    },
  },
  yaml = { keyOrdering = false },
  typescript = { inlayHints = inlay_hints },
  javascript = { inlayHints = inlay_hints },
}

local capabilities = {
  textDocument = {
    completion = {
      completionItem = { snippetSupport = true },
      completionList = {
        itemDefaults = { 'commitCharacters', 'editRange', 'insertTextFormat', 'insertTextMode', 'data' },
      },
    },
  },
}

local emmet_filetypes = {
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
}

local server_overrides = {
  emmet_ls = { filetypes = emmet_filetypes },
  html = { filetypes = { 'html', 'gohtmltmpl' } },
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, server in pairs(install_servers) do
  local config = { on_attach = on_attach, capabilities = capabilities, settings = settings }
  local overrides = server_overrides[server]
  if overrides then
    config = vim.tbl_deep_extend('force', config, overrides)
  end
  vim.lsp.enable(server)
  vim.lsp.config(server, config)
end
