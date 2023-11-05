-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- stylua: ignore
local baseKeymaps = {
  { 'gh', '^',           desc = 'line head',     mode = { 'n', 'v', 'x' } },
  { 'ge', '$',           desc = 'line end',      mode = { 'n', 'v', 'x' } },
  { 'W',  '<cmd>w!<CR>', desc = 'save file' },
  { 'Q',  '<cmd>q!<CR>', desc = 'exit window' },
  -- layout
  { '<C-k>', '<cmd>resize -5<CR>',          desc = 'Reduce window width' },
  { '<C-j>', '<cmd>resize +5<CR>',          desc = 'Increase window width' },
  { '<C-h>', '<cmd>vertical resize -5<CR>', desc = 'Reduce form height' },
  { '<C-l>', '<cmd>vertical resize +5<CR>', desc = 'Increase window height' },
  -- tab
  { '<C-t>k', '<cmd>tabp<CR>',     desc = 'previous tab' },
  { '<C-t>j', '<cmd>tabn<CR>',     desc = 'next tab' },
  { '<C-t>q', '<cmd>tabclose<CR>', desc = 'close tab' },
  -- buffer
  { '<C-b>k', '<cmd>bp<CR>',       desc = 'previous buffer' },
  { '<C-b>j', '<cmd>bn<CR>',       desc = 'next buffer' },
  { '<C-b>q', '<cmd>bdelete!<CR>', desc = 'delete buffer' },
  -- launcher - terminal
  { '<leader>rf', function() require('base.launcher').runFile() end,             desc = 'Run File' },
  { '<leader>lr', function() require('base.launcher').toolToggle('ranger') end, mode = { 'n', 't' }, desc = 'Ranger' },
  { '<leader>ld', function() require('base.launcher').toolToggle('docker') end, mode = { 'n', 't' }, desc = 'LazyDocker' },
  { '<leader>lg', function() require('base.launcher').toolToggle('git') end,    mode = { 'n', 't' }, desc = 'LazyGit' },
  -- terminal
  { '<C-q>',  '<C-\\><C-n>',       desc = 'Exit terminal mode', mode = "t" },
  { '<C-w>j', '<cmd>wincmd j<CR>', desc = 'Move to window below', mode = "t" },
  { '<C-w>k', '<cmd>wincmd k<CR>', desc = 'Move to upper window', mode = "t" },
  { '<C-w>h', '<cmd>wincmd h<CR>', desc = 'Move to left window', mode = "t" },
  { '<C-w>l', '<cmd>wincmd l<CR>', desc = 'Move to right window', mode = "t" },
}

for _, key in pairs(baseKeymaps) do
  vim.keymap.set(key.mode or 'n', key[1], key[2], { desc = key.desc, silent = true })
end
