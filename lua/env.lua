local set = vim.opt

-- 交换文件
set.swapfile = false
-- 忽略大小写
set.ignorecase = true
set.showmatch = true
-- 折叠
set.wrap = false
-- 高亮行
set.cursorline = true

set.shiftwidth = 2
set.expandtab = true
set.softtabstop = 2
set.tabstop = 2

-- 相对行号
set.number = true
set.relativenumber = true
-- 系统剪贴板
set.clipboard = "unnamedplus"

-- markdown preview
vim.g.mkdp_browser = "chromium"

-- vsnip
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

-- neovide
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 20
vim.g.neovide_transparency = 0.9
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_remember_window_size = true
set.guifont = "CaskaydiaCove Nerd Font SemiLight:i:h9"
