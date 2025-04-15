-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- stylua: ignore
local baseKeymaps = {
  { '<C-s>',        '<cmd>w!<CR>',                                                                         desc = 'save file' },
  { '<C-q>',        '<cmd>q!<CR>',                                                                         desc = 'exit window' },
  -- layout
  { '<C-k>',        '<cmd>resize -5<CR>',                                                                  desc = 'Reduce window width',     mode = 'n' },
  { '<C-j>',        '<cmd>resize +5<CR>',                                                                  desc = 'Increase window width',   mode = 'n' },
  { '<C-h>',        '<cmd>vertical resize -5<CR>',                                                         desc = 'Reduce form height',      mode = 'n'},
  { '<C-l>',        '<cmd>vertical resize +5<CR>',                                                         desc = 'Increase window height',  mode = 'n' },
  -- tab
  { '<C-t>k',       '<cmd>tabp<CR>',                                                                       desc = 'previous tab' },
  { '<C-t>j',       '<cmd>tabn<CR>',                                                                       desc = 'next tab' },
  { '<C-t>q',       '<cmd>tabclose<CR>',                                                                   desc = 'close tab' },
  -- buffer
  { 'bk',           '<cmd>bp<CR>',                                                                         desc = 'previous buffer',         mode = 'n' },
  { 'bj',           '<cmd>bn<CR>',                                                                         desc = 'next buffer',             mode = 'n' },
  { 'bq',           '<cmd>bdelete!<CR>',                                                                   desc = 'delete buffer',           mode = 'n' },
  -- launcher - terminal
  { '<leader>rf', function() require('base.launcher').runFile() end,                           						 desc = 'Run File',                mode = 'n' },
  -- terminal
  { '<C-q>q',       '<C-\\><C-n>',                                                                         desc = 'Exit terminal mode',      mode = "t" },
  { '<C-w>j',       '<cmd>wincmd j<CR>',                                                                   desc = 'Move to window below',    mode = "t" },
  { '<C-w>k',       '<cmd>wincmd k<CR>',                                                                   desc = 'Move to upper window',    mode = "t" },
  { '<C-w>h',       '<cmd>wincmd h<CR>',                                                                   desc = 'Move to left window',     mode = "t" },
  { '<C-w>l',       '<cmd>wincmd l<CR>',                                                                   desc = 'Move to right window',    mode = "t" },
  -- diagnostic
  {'dk', function() vim.diagnostic.jump({ count = -1, float = true }) end, 																					 desc = 'Prev Diagnostic',},
  {'dj', function() vim.diagnostic.jump({ count = 1, float = true }) end, 																					 desc = 'Next Diagnostic',},
  {'dK', function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end, desc = 'Prev Diagnostic [ERROR]',},
  {'dJ', function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end,  desc = 'Next Diagnostic [ERROR]',},
	-- utils
	{ '<leader>cpr', function() vim.fn.setreg("+", vim.fn.expand("%:.")) vim.notify("Copied Relative Path") end, desc = "Copy Path (relative) to clipboard" },
	{ '<leader>cpa', function() vim.fn.setreg("+", vim.api.nvim_buf_get_name(0)) vim.notify("Copied Absolute Path") end, desc = "Copy Path(absolute) to clipboard" },
	{ '<leader>cpl', function() vim.fn.setreg("+", string.format("%s:%d",vim.fn.expand("%:."), vim.fn.line("."))) vim.notify("Copied current line position") end, desc = "Copy rp:lnum to clipboard" },
}

for _, key in pairs(baseKeymaps) do
  vim.keymap.set(key.mode or 'n', key[1], key[2], { desc = key.desc, silent = true })
end
