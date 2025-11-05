vim.api.nvim_create_autocmd('FileType', {
  pattern = 'norg',
	-- stylua: ignore
  callback = function()
    vim.g.maplocalleader = 'g'
    vim.keymap.set('n', 'gd',    '<Plug>(neorg.esupports.hop.hop-link)', { buffer = true })
    vim.keymap.set('n', '<M-h>', '<Plug>(neorg.promo.demote.nested)',    { buffer = true })
    vim.keymap.set('n', '<M-H>', '<Plug>(neorg.promo.demote)',           { buffer = true })
    vim.keymap.set('n', '<M-l>', '<Plug>(neorg.promo.promote.nested)',   { buffer = true })
    vim.keymap.set('n', '<M-L>', '<Plug>(neorg.promo.promote)',          { buffer = true })
  end,
})

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
