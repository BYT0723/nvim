return {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.tempus'] = {},
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
        name = '[Neorg]',
      },
    },
    ['core.keybinds'] = {
      config = {
        default_keybinds = true,
        neorg_leader = 'g',
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
    ['core.export'] = {},
    ['core.presenter'] = { config = { zen_mode = 'zen-mode' } },
  },
}
