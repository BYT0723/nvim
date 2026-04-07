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

local M = {}

function M.init()
  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = signs.text,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  })
end

--- @param count integer
--- @param severity? vim.diagnostic.Severity
function M.jump(count, severity)
  vim.diagnostic.jump({
    count = count,
    severity = severity,
    on_jump = function(diagnostic, bufnr)
      -- vim.lsp.util.open_floating_preview({ diagnostic.message }, 'plaintext', {
      --   title = '  Diagnostic ',
      --   relative = 'cursor',
      --   border = 'rounded',
      --   focus = false,
      -- })
      vim.diagnostic.open_float({
        border = 'rounded',
        title = '  Diagnostic ',
        header = {},
        prefix = function(diagnostic, i, total)
          return string.format(' %s ', signs.text[diagnostic.severity]), signs.hl[diagnostic.severity]
        end,
        suffix = function(diagnostic, i, total)
          return string.format(' [%d/%d] - %s ', i, total, diagnostic.source), 'DiagnosticHint'
        end,
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  })
end

return M
