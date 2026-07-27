local null_ls = require('null-ls')
return {
  -- root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
  -- sources = {
  --   -- ============== diagnostics ==============
  --   null_ls.builtins.diagnostics.golangci_lint,
  --   null_ls.builtins.diagnostics.actionlint,
  --   null_ls.builtins.diagnostics.checkmake,
  --   null_ls.builtins.diagnostics.hadolint,
  --   null_ls.builtins.diagnostics.protolint,
  --   null_ls.builtins.diagnostics.sqruff,
  --   require('none-ls.diagnostics.ruff'),
  --
  --   -- ============== code actions ==============
  --   null_ls.builtins.code_actions.gomodifytags,
  --   null_ls.builtins.code_actions.impl,
  --   null_ls.builtins.code_actions.refactoring,
  -- },
}
