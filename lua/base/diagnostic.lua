-- The style of code diagnostic, the style setting has nothing to do with LSP or Linter
local signs = {
  { name = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignWarn', text = ' ' },
  { name = 'DiagnosticSignInfo', text = ' ' },
  { name = 'DiagnosticSignHint', text = ' ' },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = { active = signs },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    title = '  Diagnostic ',
    format = function(diagnostic)
      return string.format('%s %s [%s]', signs[diagnostic.severity].text, diagnostic.message, diagnostic.source)
    end,
  },
})
