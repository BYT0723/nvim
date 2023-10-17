-- global variable
require('base.environment')

-- basic keymap
require('base.keymaps')

-- The global indentation is 4 spaces, but some languages are more suitable for 2 spaces indentation
-- Flexible setting of 2 space indentation according to different languages
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'html',
    'javascript',
    'typescript',
    'css',
    'less',
    'scss',
    'vue',
    'json',
    'lua',
    'python',
    'dart',
    'markdown',
    'yaml',
    'toml',
    'dockerfile',
    'make',
    'ruby',
  },
  command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2',
})

-- The style of code diagnosis, the style setting has nothing to do with LSP or Linter
local signs = {
  { name = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignWarn', text = ' ' },
  { name = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignHint', text = ' ' },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'double',
    header = '',
    prefix = '',
    title = '  Diagnostic ',
    format = function(diagnostic)
      return string.format('%s %s [%s]', signs[diagnostic.severity].text, diagnostic.message, diagnostic.source)
    end,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'double',
  title = '  Hover ',
})
