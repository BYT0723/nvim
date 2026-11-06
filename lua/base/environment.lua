-- 设置英文环境
vim.cmd([[language en_US.UTF-8]])

local set = vim.opt

-- fix nvim-notify bug
set.termguicolors = true

-- 交换文件
set.swapfile = false
-- 忽略大小写
set.ignorecase = true
set.showmatch = true
-- 隐藏底部模式显示， like "-- INSERT --"
set.showmode = false
-- 折叠
set.wrap = false
-- 高亮行
set.cursorline = true

set.complete = {}

set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true

-- 相对行号
set.number = true
set.relativenumber = true
-- 系统剪贴板
set.clipboard = 'unnamedplus'

-- markdown preview
vim.g.mkdp_browser = 'chromium'
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_auto_close = 0

-- neovide
if vim.g.neovide then
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_confirm_quit = true
  set.guifont = 'CaskaydiaCove Nerd Font:h12'
  -- set.linespace = 1
end

vim.g.lsp_inlay_hint_enabled = true

-- vim-go configuration
vim.g.go_term_enabled = true
vim.g.go_term_mode = 'split'
vim.g.go_term_reuse = true
vim.g.go_term_height = 10
vim.g.go_term_width = 20

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

-- 显示不可见字符
set.list = true
set.listchars = {
  tab = '  󰌒',
  space = '·',
  trail = '█',
  extends = '',
  precedes = '',
  nbsp = '·',
  eol = '↴',
}

set.guicursor = 'n-v:block,c-i-ci-ve:ver25,r-cr:hor20,o:hor50'
