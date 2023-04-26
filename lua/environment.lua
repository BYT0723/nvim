local set = vim.opt

-- fix nvim-notify bug
set.termguicolors = true

-- 交换文件
set.swapfile = false
-- 忽略大小写
set.ignorecase = true
set.showmatch = true
-- 折叠
set.wrap = false
-- 高亮行
set.cursorline = true

set.tabstop = 4
set.softtabstop = 4

set.expandtab = true
set.shiftwidth = 4

-- 相对行号
set.number = true
set.relativenumber = true
-- 系统剪贴板
set.clipboard = 'unnamedplus'

-- markdown preview
vim.g.mkdp_browser = 'surf'
vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_auto_close = 0

-- vsnip
vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'

-- neovide
if vim.fn.exists('g:neovide') ~= 0 then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 20
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_remember_window_size = true
  set.guifont = 'CaskaydiaCove Nerd Font SemiLight:h13'
end

-- vim-go configuration
vim.g.go_term_enabled = true
vim.g.go_term_mode = 'split'
vim.g.go_term_reuse = true
vim.g.go_term_height = 10
vim.g.go_term_width = 20

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

vim.opt.list = true
-- vim.opt.listchars:append('space:⋅')
-- vim.opt.listchars:append("eol:")

-- indent by filetype
vim.api.nvim_command(
  'au FileType html,javascript,typescript,css,less,scss,vue,proto,json,c,cpp,lua,dart set tabstop=2 softtabstop=2 shiftwidth=2'
)

vim.api.nvim_command('au BufRead *.api set filetype=goctl')

-- stylua: ignore
local signs = {
  { name = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignWarn',  text = ' ' },
  { name = 'DiagnosticSignHint',  text = ' ' },
  { name = 'DiagnosticSignInfo',  text = ' ' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  virtual_text = true,
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'single',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(config)
