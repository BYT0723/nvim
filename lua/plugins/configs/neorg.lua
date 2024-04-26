return {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
        name = '[Neorg]',
      },
    },
    ['core.integrations.nvim-cmp'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = {
          work = '~/.work_notes/',
        },
        default_workspace = 'work',
      },
    },
  },
}
