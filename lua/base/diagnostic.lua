-- The style of code diagnostic, the style setting has nothing to do with LSP or Linter
local signs = {
  text = {
    [vim.diagnostic.severity.ERROR] = ' ',
    [vim.diagnostic.severity.WARN] = ' ',
    [vim.diagnostic.severity.INFO] = ' ',
    [vim.diagnostic.severity.HINT] = ' ',
  },
  hl = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
    [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
    [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
  },
}

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = signs.text,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    title = '  Diagnostic ',
    header = {},
    prefix = function(diagnostic, i, total)
      return string.format(' %s ', signs.text[diagnostic.severity]), signs.hl[diagnostic.severity]
    end,
    suffix = function(diagnostic, i, total)
      return string.format(' [%d/%d] - %s ', i, total, diagnostic.source), 'DiagnosticUnnecessary'
    end,
  },
})
