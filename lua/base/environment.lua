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
-- 折叠
set.wrap = false
-- 高亮行
set.cursorline = true

set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = -1
set.expandtab = true

-- 相对行号
set.number = true
set.relativenumber = true
-- 系统剪贴板
set.clipboard = 'unnamedplus'

-- markdown preview
vim.g.mkdp_browser = 'surf'
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_auto_close = 0

-- vsnip
vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'

-- neovide
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 20
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.1
  vim.g.neovide_position_animation_length = 0.15 -- s 秒
  vim.g.neovide_scroll_animation_length = 0.3 -- s 秒
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_no_idle = true
  vim.g.neovide_confirm_quit = false
  vim.g.neovide_fullscreen = true
  vim.g.neovide_profiler = false -- debug information
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = 'railgun' -- 粒子效果: wireframe | ripple | railgun | torpedo | pixiedust | sonicboom
  set.guifont = 'CaskaydiaCove Nerd Font:h9.5'
  set.linespace = 2
end

-- vim-go configuration
vim.g.go_term_enabled = true
vim.g.go_term_mode = 'split'
vim.g.go_term_reuse = true
vim.g.go_term_height = 10
vim.g.go_term_width = 20

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

vim.opt.list = false
vim.opt.showmode = false

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})
