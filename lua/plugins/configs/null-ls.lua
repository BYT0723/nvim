local null_ls = require('null-ls')
return {
  -- root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
  sources = {
    --lint
    --
    -- TODO: 下面两个会引发encodingoffset警告
    --
    null_ls.builtins.diagnostics.golangci_lint,
    -- 如下两个linter强制性较高，比较严格，不建议接手旧项目使用，或者新项目一开始就使用该linter
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.protolint,
    null_ls.builtins.diagnostics.sqruff,
    -- format
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.goimports,
    -- null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.sqruff,

    -- action
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.code_actions.impl,
    null_ls.builtins.code_actions.refactoring,
  },
}
