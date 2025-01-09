vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'norg' },
  callback = function()
    vim.g.maplocalleader = 'g'
    vim.keymap.set('n', '<localleader>o', '<Plug>(neorg.esupports.hop.hop-link)', { buffer = true })
  end,
})

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
    ['core.keybinds'] = {},
    -- ['core.integrations.nvim-cmp'] = {},
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
