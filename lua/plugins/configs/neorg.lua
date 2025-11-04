return {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = {
          default = '~/Documents/neorg',
        },
        index = 'index.norg',
      },
    },
    ['core.dirman.utils'] = {},
    ['core.ui'] = {},
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['core.integrations.nvim-cmp'] = {},
    ['core.integrations.treesitter'] = {},
    ['core.esupports.metagen'] = {
      config = {
        author = 'Tyler <twang9739@gmail.com>',
        type = 'empty',
      },
    },
    ['core.summary'] = {},
  },
}
