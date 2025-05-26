return {
  lsp = {
    signature = { enabled = false },
    documentation = {
      view = 'hover',
      opts = {
        win_options = { concealcursor = 'n', conceallevel = 3 },
        position = { row = 2, col = 0 },
        border = 'rounded',
      },
    },
  },
  views = {
    cmdline_popup = {
      position = { row = '30%', col = '50%' },
      -- size = { width = '50%' },
    },
    mini = {
      position = { row = -1, col = '100%' },
      -- win_options = { winblend = 0 },
    },
  },
}
