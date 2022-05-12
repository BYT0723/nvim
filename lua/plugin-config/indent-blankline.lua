vim.opt.termguicolors = true
vim.opt.list = true

require("indent_blankline").setup {
  char = '┆',
  show_current_context = true,
  -- 显示代码段开始位置(下划线显示)
  show_current_context_start = false,
}
