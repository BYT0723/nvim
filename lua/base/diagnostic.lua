-- The style of code diagnostic, the style setting has nothing to do with LSP or Linter
local signs = {
  text = {
    [vim.diagnostic.severity.ERROR] = ' ',
    [vim.diagnostic.severity.WARN] = ' ',
    [vim.diagnostic.severity.INFO] = ' ',
    [vim.diagnostic.severity.HINT] = ' ',
  },
}

vim.diagnostic.config({
  virtual_text = true,
  signs = signs,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    title = '  Diagnostic ',
    format = function(diagnostic)
      return string.format('%s %s [%s]', signs.text[diagnostic.severity], diagnostic.message, diagnostic.source)
    end,
  },
})
