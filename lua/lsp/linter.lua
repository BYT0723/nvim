require('lint').linters_by_ft = {
  c = {
    'cpplint',
    'codespell',
  },
  cpp = {
    'cpplint',
    'codespell',
  },
  go = {
    'golangcilint',
    'codespell',
  },
  javascript = {
    'codespell',
  },
  typescript = {
    'codespell',
  },
  proto = {
    -- "buf",
    'codespell',
  },
  markdown = {
    'codespell',
  },
  vimscript = {
    'vint',
    'codespell',
  },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  callback = function()
    require('lint').try_lint()
  end,
})
