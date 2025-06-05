local lspconfig = require('lspconfig')
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
  -- 'rust_analyzer', -- rust_analyzer is started by rustaceanvim
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
  gopls = {
    usePlaceholders = true,
    codelenses = { test = true },
    staticcheck = true,
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = false,
      compositeLiteralTypes = false,
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
local capabilities = {
  textDocument = {
    completion = {
      dynamicRegistration = false,
      completionItem = {
        snippetSupport = true,
        commitCharactersSupport = true,
        deprecatedSupport = true,
        preselectSupport = true,
        tagSupport = {
          valueSet = {
            1, -- Deprecated
          },
        },
        insertReplaceSupport = true,
        resolveSupport = {
          properties = {
            'documentation',
            'additionalTextEdits',
            'insertTextFormat',
            'insertTextMode',
            'command',
          },
        },
        insertTextModeSupport = {
          valueSet = {
            1, -- asIs
            2, -- adjustIndentation
          },
        },
        labelDetailsSupport = true,
      },
      contextSupport = true,
      insertTextMode = 1,
      completionList = {
        itemDefaults = {
          'commitCharacters',
          'editRange',
          'insertTextFormat',
          'insertTextMode',
          'data',
        },
      },
    },
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

for _, lsp in pairs(install_servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end

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
