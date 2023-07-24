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
  { 'tk', '<cmd>tabp<CR>',     desc = 'previous tab' },
  { 'tj', '<cmd>tabn<CR>',     desc = 'next tab' },
  { 'tq', '<cmd>tabclose<CR>', desc = 'close tab' },
  -- buffer
  { 'bk', '<cmd>bp<CR>',       desc = 'previous buffer' },
  { 'bj', '<cmd>bn<CR>',       desc = 'next buffer' },
  { 'bq', '<cmd>bdelete!<CR>', desc = 'delete buffer' },
  -- quickfix
  { 'ck',         '<cmd>cp<CR>',                                         desc = 'previous item in quickfix' },
  { 'cj',         '<cmd>cn<CR>',                                         desc = 'next item in quickfix' },
  { 'cc',         '<cmd>cc<CR>',                                         desc = 'current item in quickfix' },
  { '<leader>cc', "<cmd>lua require('base.util').toggle_quickfix()<CR>", desc = 'Quickfix' },
  -- launcher
  { '<leader>rf', function() require('base.launcher').runFile() end,             desc = 'Run File' },
  { '<leader>rp', function() require('base.launcher').runProject() end,          desc = 'Start Project' },
  { '<leader>ri', function() require('base.launcher').getRunProjectCmd() end,    desc = 'Show project command' },
  { '<leader>re', function() require('base.launcher').editRunProjectCmd() end,   desc = 'Edit project command' },
  { '<leader>rm', function() require('base.launcher').removeRunProjectCmd() end, desc = 'Remove project command' },
  -- launcher - terminal
  { '<leader>lr', function() require('base.launcher').toolToggle('ranger') end, mode = { 'n', 't' }, desc = 'Ranger' },
  { '<leader>ld', function() require('base.launcher').toolToggle('docker') end, mode = { 'n', 't' }, desc = 'LazyDocker' },
  { '<leader>lg', function() require('base.launcher').toolToggle('git') end,    mode = { 'n', 't' }, desc = 'LazyGit' },
  { '<C-b>n',     function() require('base.launcher').term_new() end,           mode = { 'n', 't' }, desc = 'New Terminal' },
  { '<C-b>k',     function() require('base.launcher').term_prev() end,          mode = { 'n', 't' }, desc = 'Previous Terminal' },
  { '<C-b>j',     function() require('base.launcher').term_next() end,          mode = { 'n', 't' }, desc = 'Next Terminal' },
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
