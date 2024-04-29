local nls = require('null-ls')
return {
  -- root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
  sources = {
    --lint
    --
    -- TODO: 下面两个会引发encodingoffset警告
    --
    -- nls.builtins.diagnostics.cpplint,
    nls.builtins.diagnostics.golangci_lint,
    nls.builtins.diagnostics.mypy,
    nls.builtins.code_actions.ts_node_action,
    -- format
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.cmake_format,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.prettierd,
    nls.builtins.formatting.buf,

    -- action
    --- language
    nls.builtins.code_actions.gomodifytags,
    nls.builtins.code_actions.impl,
    --- git
    nls.builtins.code_actions.gitrebase,
    nls.builtins.code_actions.gitsigns.with({
      config = {
        filter_actions = function(title)
          -- return title:lower():match('blame') == nil -- filter out blame actions
          return false
        end,
      },
    }),
    --- util
    nls.builtins.code_actions.refactoring,
  },
}
